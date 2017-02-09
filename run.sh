#!/bin/sh

set -e

VAULT_FILE=/var/run/secrets/vault/vault-token

test -e ${VAULT_FILE}
VAULT_ADDR=$(jq -r .vaultAddr < ${VAULT_FILE})
VAULT_TOKEN=$(jq -r .clientToken < ${VAULT_FILE})

curl -v \
    -H "X-Vault-Token: ${VAULT_TOKEN}" \
    -X GET \
    -o /tmp/mysql \
    "${VAULT_ADDR}/v1/mysql/creds/readonly"


MYSQL_USER=$(jq -r .data.username < /tmp/mysql)
MYSQL_PASSWORD=$(jq -r .data.password < /tmp/mysql)

echo "user: $MYSQL_USER"
echo "password: $MYSQL_PASSWORD"

while true; do
  mysql -h mysql -u "${MYSQL_USER}" "-p${MYSQL_PASSWORD}" -e 'SELECT * from names;' test
  sleep 10
  echo "sleep for 10 sec" 
done
