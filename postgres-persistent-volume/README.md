# Table of Contents
- [Table of Contents](#table-of-contents)
  - [Run deployment script](#run-deployment-script)
  - [Connect database pod \& list DB](#connect-database-pod--list-db)
  - [Create table](#create-table)
  - [To keep db state after delete pods](#to-keep-db-state-after-delete-pods)
  - [Apply full](#apply-full)
  - [Delete full](#delete-full)

## Run deployment script
```bash
kubectl apply -f db-deployment.yaml
```

## Connect database pod & list DB
```bash
kubectl exec -it <pod-name> -- /bin/bash
psql -U vehicle_quotes
vehicle_quotes=# `\l`
```
![list_db](assets/list_db.jpg)

## Create table
```bash
vehicle_quotes=# CREATE TABLE test (test_field varchar);
vehicle_quotes=# \dt
```

## To keep db state after delete pods
```bash
kubectl apply -f db-persistent-volume-claim.yaml
kubectl apply -f db-persistent-volume.yaml
```
In db-deployment.yaml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: vehicle-quotes-db
spec:
  selector:
    matchLabels:
      app: vehicle-quotes-db
  replicas: 1
  template:
    metadata:
      labels:
        app: vehicle-quotes-db
    spec:
      containers:
        - name: vehicle-quotes-db
          image: postgres:13
          ports:
            - containerPort: 5432
              name: "postgres"
          volumeMounts: # <- mount volume
            - mountPath: "/var/lib/postgresql/data"
              name: vehicle-quotes-postgres-data-storage
          env:
            - name: POSTGRES_DB
              value: vehicle_quotes
            - name: POSTGRES_USER
              value: vehicle_quotes
            - name: POSTGRES_PASSWORD
              value: password
          resources:
            limits:
              memory: 4Gi
              cpu: "2"
      volumes: # <- add volume
        - name: vehicle-quotes-postgres-data-storage
          persistentVolumeClaim:
            claimName: vehicle-quotes-postgres-data-persisent-volume-claim
```
Apply the changes
```bash
kubectl apply -f db-persistent-volume.yaml
kubectl apply -f db-persistent-volume-claim.yaml
kubectl apply -f db-deployment.yaml
```
Create table and insert data
```bash
kubectl exec -it <pod-name> -- bash
psql -U vehicle_quotes
CREATE TABLE test (test_field varchar);
```
Delete the pods
```bash
kubectl delete -f db-deployment.yaml
kubectl delete -f db-persistent-volume-claim.yaml
kubectl delete -f db-persistent-volume.yaml
```
Create new pods
```bash
kubectl apply -f db-persistent-volume.yaml
kubectl apply -f db-persistent-volume-claim.yaml
kubectl apply -f db-deployment.yaml
```

## Apply full
```bash
kubectl apply -f db-persistent-volume.yaml
kubectl apply -f db-persistent-volume-claim.yaml
kubectl apply -f db-deployment.yaml
kubectl apply -f db-service.yaml
```

## Delete full
```bash
kubectl delete -f db-service.yaml
kubectl delete -f db-deployment.yaml
kubectl delete -f db-persistent-volume-claim.yaml
kubectl delete -f db-persistent-volume.yaml
```