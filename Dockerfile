###
# Build stage
FROM debian:buster-slim as build
WORKDIR /build
COPY public public
RUN find /build/public -type f -name "*.html" > /tmp/htmlfiles.txt

###
# Validation stage
# docker run -it --rm -v $(pwd)/index.html:/index.html validator/validator:latest vnu-runtime-image/bin/vnu --verbose /index.html
FROM validator/validator:latest as validator
COPY --from=build /bin/cat /bin/cat
COPY --from=build /build/public /build/public
COPY --from=build /tmp/htmlfiles.txt /tmp/htmlfiles.txt
RUN vnu-runtime-image/bin/vnu --verbose --errors-only $(cat /tmp/htmlfiles.txt)

### 
# Execution stage
FROM nginx:stable-alpine
COPY --from=build /build/public /usr/share/nginx/html
