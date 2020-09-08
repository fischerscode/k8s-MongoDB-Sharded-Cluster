kubectl run mongo-shell -it --rm --image mongo:4.2.9 --overrides='
{
  "apiVersion": "v1",
  "spec": {
    "containers": [
      {
        "name": "mongo-shell",
        "image": "mongo:4.2.9",
        "command": ["/bin/bash"],
        "args": ["-c", "cat /cert/tls.crt /cert/tls.key > /root.key && mongo --host mongodb-configserver-0.mongodb-cs --tls --tlsCAFile /cert/ca.crt --tlsCertificateKeyFile /root.key --authenticationDatabase '"'"'$external'"'"' --authenticationMechanism MONGODB-X509"],
        "stdin": true,
        "stdinOnce": true,
        "tty": true,
        "volumeMounts": [{
          "mountPath": "/cert",
          "name": "cert-root"
        }]
      }
    ],
    "volumes": [{
      "name": "cert-root",
      "secret": {"secretName": "certificate-mongodb-cs-root"}
    }]
  }
}
'  --restart=Never