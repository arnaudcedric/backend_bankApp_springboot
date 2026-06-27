#!/bin/bash

set -e

########################################
# Configuration
########################################

VERSION=${1:-v2}

IMAGE_NAME="ghcr.io/arnaudcedric/phegonbank"
IMAGE="$IMAGE_NAME:$VERSION"

########################################
# Build Local Image
########################################

echo "======================================="
echo "Building local Docker image..."
echo "Image: $IMAGE"
echo "======================================="

docker build \
    -t $IMAGE \
    .

########################################
# Build & Push Multi-Platform Image
########################################

echo ""
echo "======================================="
echo "Building Multi-Platform Image..."
echo "======================================="

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    -t $IMAGE \
    -t $IMAGE_NAME:latest \
    --push \
    .

########################################
# Finished
########################################

echo ""
echo "======================================="
echo "✅ Build Complete!"
echo "======================================="
echo "Image pushed successfully:"
echo "  $IMAGE"
echo "  $IMAGE_NAME:latest"
echo "======================================="




















##
##!/bin/bash
#
#set -e
#
#########################################
## Configuration
#########################################
#
#VERSION=${1:-v2}
#
#IMAGE_NAME="ghcr.io/arnaudcedric/phegonbank"
#IMAGE="$IMAGE_NAME:$VERSION"
#
#########################################
## Build Local Image
#########################################
#
#echo "======================================="
#echo "Building local Docker image..."
#echo "Image: $IMAGE"
#echo "======================================="
#
#docker build \
#    -t $IMAGE \
#    .
#
#########################################
## Scan Image
#########################################
#
#echo ""
#echo "======================================="
#echo "Scanning image with Trivy..."
#echo "======================================="
#
#trivy image \
#    --severity HIGH,CRITICAL \
#    --ignore-unfixed \
#    --exit-code 1 \
#    $IMAGE
#
#echo ""
#echo "✅ Trivy scan passed."
#
#########################################
## Build & Push Multi-Platform Image
#########################################
#
#echo ""
#echo "======================================="
#echo "Building Multi-Platform Image..."
#echo "======================================="
#
#docker buildx build \
#    --platform linux/amd64,linux/arm64 \
#    -t $IMAGE \
#    -t $IMAGE_NAME:latest \
#    --push \
#    .
#
#########################################
## Finished
#########################################
#
#echo ""
#echo "======================================="
#echo "✅ Build Complete!"
#echo "======================================="
#echo "Image pushed successfully:"
#echo "  $IMAGE"
#echo "  $IMAGE_NAME:latest"
#echo "======================================="