# Work in progress!

### Setup ca (for ssl)
1. make sure cert-manager is installed
2. `openssl genrsa -out ca.key 8192`
3. `openssl req -x509 -new -nodes -key ca.key -sha256 -subj "/CN=mongodb-cluster-ca.local" -days 36500 -reqexts v3_req -extensions v3_ca -out ca.crt`
4. `kubectl create secret tls mongodb-cluster-ca-key-pair --key=ca.key --cert=ca.crt`



### Setup mongodb config server
Have a look at the [config-server directory](./config-server)


