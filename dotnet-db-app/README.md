# WebApiWithDb
- [WebApiWithDb](#webapiwithdb)
  - [Init project](#init-project)
    - [Create new project](#create-new-project)
    - [Install Entity Framework Core](#install-entity-framework-core)
  - [Database](#database)
    - [Add migration](#add-migration)
    - [Update database](#update-database)
    - [Generate migrations between](#generate-migrations-between)
    - [Generate migrations full](#generate-migrations-full)
    - [Run from api dir](#run-from-api-dir)
    - [Run from db dir](#run-from-db-dir)
  - [Docker](#docker)
    - [Build docker image](#build-docker-image)
    - [Run container](#run-container)
    - [Get container logs](#get-container-logs)
    - [Check override env](#check-override-env)
    - [Run docker compose with build app](#run-docker-compose-with-build-app)
    - [Docker volues](#docker-volues)
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

## Init project

### Create new project
```bash
dotnet new webapi -n WebApiWithDb
```

### Install Entity Framework Core
```bash
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add package Microsoft.EntityFrameworkCore.Tools
```

---

## Database
### Add migration
```bash
dotnet ef migrations add InitialCreate --output-dir Data/Migrations
```

### Update database
```bash
dotnet ef database update
```

### Generate migrations between
```bash
dotnet ef migrations script FromMigration ToMigration -o migration_script.sql
dotnet ef migrations script InitialCreate AddNewColumnMigration -o migration_script.sql
```

### Generate migrations full
```bash
dotnet ef migrations script --idempotent -o idempotent_script.sql
```

### Run from api dir
```bash
dotnet ef migrations script --idempotent -o ../../db/idempotent_script.sql
```

### Run from db dir
```bash
dotnet ef migrations script --idempotent -o idempotent_script.sql --project ../src/WebApiWithDb/WebApiWithDb.csproj
```

---

## Docker
### Build docker image 
```bash
docker build -t webapiwithdb:local .
```

### Run container
```bash
docker run -d -p 5000:80 --name webapiwithdb webapiwithdb:local
```

### Get container logs
```bash
docker logs <container-id>
```

### Check override env
```bash
docker exec -it <container-id> env | grep JwtSettings__SecretKey
```

### Run docker compose with build app
```bash
docker-compose up --build -d
```

### Docker volues 
```bash
docker volume ls
docker volume inspect <volume-name>
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
kubectl describe pod <webapiwithdb-xxxxxxxxxx-xxxxx>
```

### Get pod logs
```bash
kubectl logs <webapiwithdb-xxxxxxxxxx-xxxxx>
```

### Enter to pod container
```bash
kubectl exec -it <webapiwithdb-xxxxxxxxxx-xxxxx> -- /bin/bash
```

### Get events
```bash
kubectl get events
```

### Get resources description
```bash
kubectl describe deployment webapiwithdb
kubectl describe svc webapiwithdb-service
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