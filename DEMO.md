# Show vault status
kubectl get pods

# Show vault mounts
vault mounts

# create new secret backend mysql
vault mount -path /mysql mysql

# configure db access
vault write mysql/config/connection connection_url="root:insecure@tcp(mysql:3306)/"

# create read only role
vault write mysql/roles/readonly sql="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';"

# show policy
vim policy.hcl

# write policy
vault policy-write sample-app policy.hcl

# show yaml
vim sample-app-mysql.yaml

# show sample script
vim run.sh

# create deployment
kubectl apply -f sample-app-mysql.yaml 

# look at logs of a Pod
kubectl logs sample-app-mysql-XX

# revoke token
vault token-revoke 2d4b44f6-2384-aa4b-1a46-cc66f554e757
