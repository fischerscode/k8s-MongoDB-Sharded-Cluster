### Setup ca (for ssl)
1. make sure cert-manager is installed
2. `openssl genrsa -out ca.key 8192`
3. `openssl req -x509 -new -nodes -key ca.key -sha256 -subj "/CN=mongodb-cluster-ca.local" -days 36500 -reqexts v3_req -extensions v3_ca -out ca.crt`
4. `kubectl create secret tls mongodb-cluster-ca-key-pair --key=ca.key --cert=ca.crt`



### Setup mongodb config server
1. change credentials in config-server.yaml
2. `kubectl apply -f config-server.yaml`
3. Wait until all pods are ready: `watch "kubectl get pods | grep mongodb-configserver"`
4. `kubectl exec -it mongodb-configserver-0 -- mongo --tls --tlsCAFile /certs/ca.crt --tlsCertificateKeyFile=/tls.pem --tlsAllowInvalidHostnames`
5. initiate
```
rs.initiate(
  {
    _id: "cfgrs",
    configsvr: true,
    members: [
      { _id : 0, host : "mongodb-configserver-0.mongodb-configserver:27017" },
      { _id : 1, host : "mongodb-configserver-1.mongodb-configserver:27017" },
      { _id : 2, host : "mongodb-configserver-2.mongodb-configserver:27017" }
    ]
  }
)
```
6. Check config: `rs.status()`
7. close: `quit()`

