# MyWebApi

## Build docker image 
```bash
docker build -t mywebapi:local .
```

## Run container
```bash
docker run -d -p 8080:80 --name mywebapi mywebapi:local
```

## Run container with env
```bash
docker run -d -p 8080:80 -e EnvKey=key_passed_to_container --name mywebapi mywebapi:local
docker run -d -p 8080:80 -e EnvKey=key_passed_to_container -e JwtSettings__SecretKey="NewSuperSecretKey12345" --name mywebapi mywebapi:local
```

## Run in kubernetes
```bash
kubectl apply -f k8s-local.yaml
```

## Delete resources
```bash
kubectl delete -f k8s-local.yaml
```

## Get pods
```bash
kubectl get pods
```

## Get services
```bash
kubectl get svc
```

## Describe pod
```bash
kubectl describe pod <mywebapi-xxxxxxxxxx-xxxxx>
```

## Get pod logs
```bash
kubectl logs <mywebapi-xxxxxxxxxx-xxxxx>
```

## Enter to pod container
```bash
kubectl exec -it <mywebapi-xxxxxxxxxx-xxxxx> -- /bin/bash
```

## Get events
```bash
kubectl get events
```

## Get resources description
```bash
kubectl describe deployment mywebapi
kubectl describe svc mywebapi-service
```

