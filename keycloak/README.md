# Keycloak Setup for Mealwurm

Install via docker with the following command

```
docker run -p 8081:8080 -e KC_BOOTSTRAP_ADMIN_USERNAME=admin -e KC_BOOTSTRAP_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:26.3.2 start-dev
```


## Connect to Postgres DB

1. Create a postgres db via docker

`docker run --name postgres-keycloak -p 5433:5432 -e POSTGRES_PASSWORD=keycloak -d postgres:latest`

2. Test the connection via dbeaver, pgadmin, etc.

3. Create a database within the container named `keycloak`


