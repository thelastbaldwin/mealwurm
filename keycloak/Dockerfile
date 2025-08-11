# bind a differet port based on root env.local. Does it require rebuilding?
# mount the themes directory to /themes within the container

# use the following cli args
# --spi-theme--static-max-age=-1 
# --spi-theme--cache-themes=false 
# --spi-theme--cache-templates=false

# ensure the keycloak server starts in dev mode
FROM quay.io/keycloak/keycloak:26.1.2
ENTRYPOINT [ "/opt/keycloak/bin/kc.sh" ]
CMD [ "start-dev" ]