### Setup mongodb config server
1. `kubectl apply -f config-server.yaml`
2. Wait until all pods are ready: `watch "kubectl get pods | grep mongodb-configserver"`
3. `kubectl run mongo --rm -it --image mongo -- mongo mongodb://mongodb-configserver-0.mongodb-configserver:27017`
4. initiate
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
5. Check config: `rs.status()`
6. close: `quit()`

