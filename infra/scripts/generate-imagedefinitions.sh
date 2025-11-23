#!/usr/bin/env bash
set -e
# Expects IMAGE_URI_USER and IMAGE_URI_PRODUCT env variables
cat > imagedefinitions.json <<EOF
[
  {
    "name":"user-service",
    "imageUri":"${IMAGE_URI_USER}"
  },
  {
    "name":"product-service",
    "imageUri":"${IMAGE_URI_PRODUCT}"
  }
]
EOF
echo "Wrote imagedefinitions.json:"
cat imagedefinitions.json