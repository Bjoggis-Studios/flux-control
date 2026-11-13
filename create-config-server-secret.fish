#!/usr/bin/fish

kubectl create secret generic config-server-secrets -n common --from-literal=jdbc-url=$SPRING_CLOUD_CONFIG_JDBC_URL --from-literal=jdbc-username=$SPRING_CLOUD_CONFIG_JDBC_USERNAME --from-literal=jdbc-password=$SPRING_CLOUD_CONFIG_JDBC_PASSWORD --from-literal=encrypt-key=$ENCRYPT_KEY