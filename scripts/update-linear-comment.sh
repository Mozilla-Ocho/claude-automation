#!/bin/bash
set -euo pipefail

# Check if required arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <comment_id> <comment_body> [api_key]"
    echo "Example: $0 '123e4567-e89b-12d3-a456-426614174000' 'Updated comment text'"
    exit 1
fi

comment_id=$1
body=$2

# Get API key from argument or environment variable
if [ $# -ge 3 ]; then
    LINEAR_API_KEY=$3
elif [ -z "${LINEAR_API_KEY:-}" ]; then
    echo "Error: LINEAR_API_KEY environment variable not set and no API key provided"
    echo "Set it with: export LINEAR_API_KEY='lin_api_...'"
    exit 1
fi

# Escape special characters in the body for JSON
escaped_body=$(echo "$body" | jq -Rs .)

# Create the GraphQL mutation
mutation=$(cat <<EOF
{
  "query": "mutation UpdateComment(\$id: String!, \$body: String!) { commentUpdate(id: \$id, input: { body: \$body }) { success comment { id body updatedAt } } }",
  "variables": {
    "id": "$comment_id",
    "body": $escaped_body
  }
}
EOF
)

# Execute the GraphQL mutation
response=$(curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d "$mutation" \
  https://api.linear.app/graphql)

# Check if the request was successful
if echo "$response" | jq -e '.errors' > /dev/null 2>&1; then
    echo "Error updating comment:"
    echo "$response" | jq '.errors'
    exit 1
else
    success=$(echo "$response" | jq -r '.data.commentUpdate.success')
    if [ "$success" = "true" ]; then
        echo "Comment updated successfully!"
        echo "$response" | jq '.data.commentUpdate.comment'
    else
        echo "Failed to update comment"
        echo "$response" | jq '.'
        exit 1
    fi
fi
