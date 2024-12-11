#!/bin/bash

# Application name in Kubernetes
APP_NAME="mywebapi"
SERVICE_NAME="${APP_NAME}-service"

echo "=== Kubernetes Diagnostics Script ==="
echo

# 1. Checking the status of pods
echo "[INFO] Checking Pods..."
kubectl get pods -o wide
echo

# 2. Checking the status of services
echo "[INFO] Checking Services..."
kubectl get svc
echo

# 3. Fetching logs for pods with the application label
echo "[INFO] Fetching Logs..."
POD_NAME=$(kubectl get pods -l app=${APP_NAME} -o jsonpath="{.items[0].metadata.name}")
if [ -n "$POD_NAME" ]; then
  echo "Logs for Pod: $POD_NAME"
  kubectl logs $POD_NAME
else
  echo "[WARNING] No pods found for app=${APP_NAME}"
fi
echo

# 4. Testing Service (without Minikube)
echo "[INFO] Testing Service..."
NODE_PORT=$(kubectl get svc ${SERVICE_NAME} -o jsonpath="{.spec.ports[0].nodePort}")
NODE_IP=$(kubectl get nodes -o jsonpath="{.items[0].status.addresses[?(@.type=='InternalIP')].address}")

if [ -n "$NODE_IP" ] && [ -n "$NODE_PORT" ]; then
  SERVICE_URL="http://localhost:${NODE_PORT}"
  echo "Service URL: $SERVICE_URL"
  echo "Response:"
  curl -s "${SERVICE_URL}/weatherforecast"
else
  echo "[WARNING] Unable to retrieve Node IP or NodePort. Check your Service configuration."
fi
echo

# 5. Displaying cluster events
echo "[INFO] Cluster Events:"
kubectl get events --sort-by='.lastTimestamp'
echo

# 6. Deployment details
echo "[INFO] Deployment Details:"
kubectl describe deployment ${APP_NAME}
echo

# 7. Service details
echo "[INFO] Service Details:"
kubectl describe svc ${SERVICE_NAME}
echo

echo "=== Diagnostics Complete ==="
