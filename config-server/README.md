### Setup mongodb config server
1. change credentials in config-server.yaml (also organizationName)
2. `kubectl apply -f .`
3. Wait until all pods are ready: `watch "kubectl get pods | grep mongodb-configserver"`
4. `kubectl exec -it mongodb-configserver-0 -- mongo --tls --tlsCAFile /certs/ca.crt --tlsCertificateKeyFile=/cluster-auth.pem --tlsAllowInvalidHostnames`
5. initiate
```
rs.initiate(
  {
    _id: "cfgrs",
    configsvr: true,
    members: [
      { _id : 0, host : "mongodb-configserver-0.mongodb-cs.default.svc.cluster.local:27017" },
      { _id : 1, host : "mongodb-configserver-1.mongodb-cs.default.svc.cluster.local:27017" },
      { _id : 2, host : "mongodb-configserver-2.mongodb-cs.default.svc.cluster.local:27017" }
    ]
  }
)
```
6. Check config: `rs.status()`
7. create user:
```
db.getSiblingDB("$external").runCommand({
   createUser: "CN=root,OU=administration,O=organizationName",
   roles: [{role: "root", db: "admin"}]
})
```
8. close: `quit()`
(connect as root using: `bash config-server-login.sh`)