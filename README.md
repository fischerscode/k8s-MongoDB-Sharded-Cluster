### Setup mongodb config server
`kubectl run mongo --rm -it --image mongo -- mongo mongodb://mongodb-configserver-0.mongodb-configserver:27017`
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

rs.status()
```