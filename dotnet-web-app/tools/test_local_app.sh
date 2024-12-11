#!/bin/bash

# Application settings
APP_NAME="mywebapi"
DOCKER_IMAGE="${APP_NAME}:local"
HOST_PORT=30001
CONTAINER_PORT=80

echo "=== Local Application Testing Script ==="
echo

cd ../src

# 1. Building Docker image
echo "[INFO] Building Docker image..."
docker build -t ${DOCKER_IMAGE} .
if [ $? -ne 0 ]; then
  echo "[ERROR] Failed to build Docker image."
  exit 1
fi
echo "[INFO] Docker image built successfully: ${DOCKER_IMAGE}"
echo

# 2. Starting Docker container
echo "[INFO] Starting Docker container..."
docker run -d --rm --name ${APP_NAME} -p ${HOST_PORT}:${CONTAINER_PORT} ${DOCKER_IMAGE}
if [ $? -ne 0 ]; then
  echo "[ERROR] Failed to start Docker container."
  exit 1
fi
echo "[INFO] Docker container started on port ${HOST_PORT}"
echo

# 3. Testing application
echo "[INFO] Testing application endpoint..."
sleep 3 # Give the application time to start

TEST_URL="http://localhost:${HOST_PORT}/weatherforecast"
HTTP_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" ${TEST_URL})

if [ "${HTTP_RESPONSE}" -eq 200 ]; then
  echo "[SUCCESS] Application is running. Response from ${TEST_URL}:"
  curl -s ${TEST_URL}
else
  echo "[ERROR] Application failed to respond. HTTP status: ${HTTP_RESPONSE}"
fi
echo

# 4. Stopping Docker container
echo "[INFO] Stopping Docker container..."
docker stop ${APP_NAME}
echo "[INFO] Docker container stopped."
echo

echo "=== Local Testing Complete ==="
