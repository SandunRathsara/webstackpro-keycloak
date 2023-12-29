FROM quay.io/keycloak/keycloak:23.0.3 as builder

WORKDIR /opt/keycloak

COPY ./build_keycloak/target/webstackpro-keycloak-theme-5.0.6.jar /opt/keycloak/providers/

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:23.0.3

COPY --from=builder /opt/keycloak /opt/keycloak

# Bellow environment variables are only for the local keycloak development
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://host.docker.internal:5432/webstackprokeycloak
ENV KC_DB_USERNAME=alpha
ENV KC_DB_PASSWORD=kali123
ENV KC_HOSTNAME=localhost

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]
