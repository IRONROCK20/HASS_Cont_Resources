ARG BUILD_FROM
FROM $BUILD_FROM

# Install runtime deps
RUN apk add --no-cache \
    bash \
    jq \
    docker-cli \
    nginx \
    nodejs \
    npm

# Copy scripts, configs, UI
COPY run.sh /run.sh
COPY run-limiter.sh /run-limiter.sh
COPY ingress.conf /etc/nginx/http.d/ingress.conf
COPY app /app
COPY web /web

# Make executables
RUN chmod a+x /run.sh /run-limiter.sh

# Expose Ingress port
EXPOSE 8099

CMD [ "/run.sh" ]
