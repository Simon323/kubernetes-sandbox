# Table of Contents
- [Table of Contents](#table-of-contents)
  - [Deployemnt](#deployemnt)
    - [Run deployment app](#run-deployment-app)
    - [Delete deployment app](#delete-deployment-app)
    - [Enter to container](#enter-to-container)
  - [Service](#service)
    - [Run deployment app](#run-deployment-app-1)
    - [Delete deployment app](#delete-deployment-app-1)

## Deployemnt
### Run deployment app
```bash
kubectl apply -f nginx-deployment.yaml
```

### Delete deployment app
```bash
kubectl delete -f nginx-deployment.yaml
```

### Enter to container
```bash
kubectl exec -it <pod-name> -- /bin/bash
```

## Service
### Run deployment app
```bash
kubectl apply -f nginx-service.yaml
```

### Delete deployment app
```bash
kubectl delete -f nginx-service.yaml
```