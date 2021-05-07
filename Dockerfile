# Build stage
FROM debian:buster-slim as build
WORKDIR /build
COPY public public
RUN find ./public -type f -name "*.html" > /tmp/html

# Validation stage
FROM validator/validator:latest as validator
COPY --from=build /bin/cat /bin/cat
COPY --from=build /build/public /build/public
COPY --from=build /tmp/html /tmp/html
RUN vnu-runtime-image/bin/vnu --verbose --errors-only $(cat /tmp/html)

# Execution stage
FROM nginx:stable-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /build/public /usr/share/nginx/html
