#!/bin/bash

# Application settings
APP_NAME="mywebapi"
SERVICE_NAME="${APP_NAME}-service"
NAMESPACE="default" # You can change the namespace if the application runs in a different one
NODE_PORT=30001

echo "=== Kubernetes Application Testing Script ==="
echo

# 1. Checking the status of pods
echo "[INFO] Checking Pods..."
kubectl get pods -l app=${APP_NAME} -n ${NAMESPACE} -o wide
echo

# 2. Checking the status of services
echo "[INFO] Checking Services..."
kubectl get svc ${SERVICE_NAME} -n ${NAMESPACE}
echo

# 3. Testing the service using ClusterIP
echo "[INFO] Testing Service via ClusterIP..."
SERVICE_IP=$(kubectl get svc ${SERVICE_NAME} -n ${NAMESPACE} -o jsonpath="{.spec.clusterIP}")
SERVICE_PORT=$(kubectl get svc ${SERVICE_NAME} -n ${NAMESPACE} -o jsonpath="{.spec.ports[0].port}")

if [ -n "$SERVICE_IP" ] && [ -n "$SERVICE_PORT" ]; then
  CLUSTER_URL="http://localhost:${SERVICE_PORT}/weatherforecast"
  echo "Testing ClusterIP URL: $CLUSTER_URL"
  curl -s ${CLUSTER_URL} || echo "[ERROR] Failed to connect to ClusterIP"
else
  echo "[WARNING] Unable to retrieve ClusterIP or Port."
fi
echo

# 4. Testing the service using NodePort
echo "[INFO] Testing Service via NodePort..."
NODE_IP=$(kubectl get nodes -o jsonpath="{.items[0].status.addresses[?(@.type=='InternalIP')].address}")

if [ -n "$NODE_IP" ] && [ -n "$NODE_PORT" ]; then
  NODE_URL="http://localhost:${NODE_PORT}/weatherforecast"
  echo "Testing NodePort URL: $NODE_URL"
  curl -s ${NODE_URL} || echo "[ERROR] Failed to connect to NodePort"
else
  echo "[WARNING] Unable to retrieve Node IP or NodePort."
fi
echo

# 5. Fetching logs from the pod
echo "[INFO] Fetching Logs from Pods..."
POD_NAME=$(kubectl get pods -l app=${APP_NAME} -n ${NAMESPACE} -o jsonpath="{.items[0].metadata.name}")

if [ -n "$POD_NAME" ]; then
  echo "Logs for Pod: $POD_NAME"
  kubectl logs ${POD_NAME} -n ${NAMESPACE}
else
  echo "[WARNING] No pods found for app=${APP_NAME}"
fi
echo

# 6. Displaying cluster events
echo "[INFO] Cluster Events:"
kubectl get events -n ${NAMESPACE} --sort-by='.lastTimestamp'
echo

echo "=== Kubernetes Testing Complete ==="
