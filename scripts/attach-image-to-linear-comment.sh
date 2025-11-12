#!/bin/bash
set -euo pipefail

# Check if required arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <comment_id> <image_file_path>"
    echo "Example: $0 '123e4567-e89b-12d3-a456-426614174000' './screenshot.png'"
    exit 1
fi

comment_id=$1
image_path=$2

# Verify image file exists
if [ ! -f "$image_path" ]; then
    echo "Error: Image file not found: $image_path"
    exit 1
fi

# Confirm API key set in environment variable
if [ -z "${LINEAR_API_KEY:-}" ]; then
    echo "Error: LINEAR_API_KEY environment variable not set and no API key provided"
    echo "Set it with: export LINEAR_API_KEY='lin_api_...'"
    exit 1
fi

# Get file information
filename=$(basename "$image_path")
filesize=$(stat -f%z "$image_path" 2>/dev/null || stat -c%s "$image_path" 2>/dev/null)
mimetype=$(file -b --mime-type "$image_path")

echo "Uploading file: $filename (${filesize} bytes, $mimetype)"

# Step 1: Request upload URL from Linear
upload_mutation=$(cat <<EOF
{
  "query": "mutation FileUpload(\$filename: String!, \$size: Int!, \$mimeType: String!) { fileUpload(filename: \$filename, size: \$size, contentType: \$mimeType) { uploadFile { uploadUrl assetUrl headers { key value } } } }",
  "variables": {
    "filename": "$filename",
    "size": $filesize,
    "mimeType": "$mimetype"
  }
}
EOF
)

upload_response=$(curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d "$upload_mutation" \
  https://api.linear.app/graphql)

# Check for errors in upload mutation
if echo "$upload_response" | jq -e '.errors' > /dev/null 2>&1; then
    echo "Error requesting upload URL:"
    echo "$upload_response" | jq '.errors'
    exit 1
fi

# Extract upload URL and asset URL
upload_url=$(echo "$upload_response" | jq -r '.data.fileUpload.uploadFile.uploadUrl')
asset_url=$(echo "$upload_response" | jq -r '.data.fileUpload.uploadFile.assetUrl')

if [ "$upload_url" = "null" ] || [ "$asset_url" = "null" ]; then
    echo "Error: Failed to get upload URL"
    echo "$upload_response" | jq '.'
    exit 1
fi

echo "Got upload URL, uploading file..."

# Step 2: Extract headers and upload file to Linear's storage
headers_json=$(echo "$upload_response" | jq -c '.data.fileUpload.uploadFile.headers')

# Build curl command with dynamic headers
curl_cmd="curl -s -X PUT"
curl_cmd="$curl_cmd -H 'Content-Type: $mimetype'"

# Add each header from the response
while IFS= read -r header; do
    key=$(echo "$header" | jq -r '.key')
    value=$(echo "$header" | jq -r '.value')
    curl_cmd="$curl_cmd -H '$key: $value'"
done < <(echo "$headers_json" | jq -c '.[]')

curl_cmd="$curl_cmd --data-binary '@$image_path' '$upload_url'"

# Execute the upload
eval "$curl_cmd" > /dev/null 2>&1

echo "File uploaded successfully!"

# Step 3: Get current comment body
get_comment_mutation=$(cat <<EOF
{
  "query": "query GetComment(\$id: String!) { comment(id: \$id) { body } }",
  "variables": {
    "id": "$comment_id"
  }
}
EOF
)

comment_response=$(curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d "$get_comment_mutation" \
  https://api.linear.app/graphql)

current_body=$(echo "$comment_response" | jq -r '.data.comment.body // ""')

# Step 4: Append image to comment body
new_body="${current_body}

![${filename}](${asset_url})"

# Escape the body for JSON
escaped_body=$(echo "$new_body" | jq -Rs .)

# Step 5: Update comment with image
update_mutation=$(cat <<EOF
{
  "query": "mutation UpdateComment(\$id: String!, \$body: String!) { commentUpdate(id: \$id, input: { body: \$body }) { success comment { id body updatedAt } } }",
  "variables": {
    "id": "$comment_id",
    "body": $escaped_body
  }
}
EOF
)

response=$(curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d "$update_mutation" \
  https://api.linear.app/graphql)

# Check if the request was successful
if echo "$response" | jq -e '.errors' > /dev/null 2>&1; then
    echo "Error updating comment:"
    echo "$response" | jq '.errors'
    exit 1
else
    success=$(echo "$response" | jq -r '.data.commentUpdate.success')
    if [ "$success" = "true" ]; then
        echo "Image attached to comment successfully!"
        echo "Asset URL: $asset_url"
    else
        echo "Failed to update comment"
        echo "$response" | jq '.'
        exit 1
    fi
fi
