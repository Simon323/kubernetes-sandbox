## Apply dasboard
```bash
kubectl apply -f dashboard.yaml
```

## Delete dashboard
```bash
kubectl delete -f dashboard.yaml
```

## Disabled login prompt
```bash
kubectl patch deployment kubernetes-dashboard -n kubernetes-dashboard --type 'json' -p '[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--enable-skip-login"}]'
```

## Run GUI
```bash
kubectl proxy
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```