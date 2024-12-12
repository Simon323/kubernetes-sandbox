# MyWebApi
- [MyWebApi](#mywebapi)
  - [Docker](#docker)
    - [Build docker image](#build-docker-image)
    - [Run container](#run-container)
    - [Run container with env](#run-container-with-env)
    - [Check override env](#check-override-env)
  - [Kubernetes](#kubernetes)
    - [Run in kubernetes](#run-in-kubernetes)
    - [Delete resources](#delete-resources)
    - [Get pods](#get-pods)
    - [Get services](#get-services)
    - [Describe pod](#describe-pod)
    - [Get pod logs](#get-pod-logs)
    - [Enter to pod container](#enter-to-pod-container)
    - [Get events](#get-events)
    - [Get resources description](#get-resources-description)
  - [Kubernetes env](#kubernetes-env)
    - [ConfigMap Apply \& Display](#configmap-apply--display)
    - [Secret Applu \& Display](#secret-applu--display)

---

## Docker
### Build docker image 
```bash
docker build -t mywebapi:local .
```

### Run container
```bash
docker run -d -p 8080:80 --name mywebapi mywebapi:local
```

### Run container with env
```bash
docker run -d -p 8080:80 -e EnvKey=key_passed_to_container --name mywebapi mywebapi:local
docker run -d -p 8080:80 -e EnvKey=key_passed_to_container -e JwtSettings__SecretKey="NewSuperSecretKey12345" --name mywebapi mywebapi:local
```

### Check override env
```bash
docker exec -it <container-id> env | grep JwtSettings__SecretKey
```
---

## Kubernetes
### Run in kubernetes
```bash
kubectl apply -f k8s-local.yaml
```

### Delete resources
```bash
kubectl delete -f k8s-local.yaml
```

### Get pods
```bash
kubectl get pods
```

### Get services
```bash
kubectl get svc
```

### Describe pod
```bash
kubectl describe pod <mywebapi-xxxxxxxxxx-xxxxx>
```

### Get pod logs
```bash
kubectl logs <mywebapi-xxxxxxxxxx-xxxxx>
```

### Enter to pod container
```bash
kubectl exec -it <mywebapi-xxxxxxxxxx-xxxxx> -- /bin/bash
```

### Get events
```bash
kubectl get events
```

### Get resources description
```bash
kubectl describe deployment mywebapi
kubectl describe svc mywebapi-service
```

---

## Kubernetes env

### ConfigMap Apply & Display
```bash
kubectl apply -f jwt-configmap.yaml
kubectl describe configmap jwt-config
kubectl get configmap jwt-config -o yaml
```

### Secret Applu & Display
```bash
echo -n "PASS_YOUR_SUPER_SECRET_KEY_HERE" | base64
kubectl apply -f jwt-secret.yaml
kubectl describe secret jwt-secret
kubectl get secret jwt-secret -o yaml
```