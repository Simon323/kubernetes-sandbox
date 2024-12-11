# MyWebApi

## Build docker image 
```bash
docker build -t mywebapi:local .
```

## Run container
```bash
docker run -d -p 8080:80 --name mywebapi mywebapi:local
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
kubectl get svc
```

## Get pod logs
```bash
kubectl logs mywebapi-xxxxxxxxxx-xxxxx
```