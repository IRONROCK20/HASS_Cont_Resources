ARG BUILD_FROM
FROM $BUILD_FROM

# Install runtime dependencies
RUN apk add --no-cache \
    docker-cli bash jq nginx nodejs npm

# Copy scripts and configs
COPY run.sh /run.sh
COPY run-limiter.sh /run-limiter.sh
COPY nginx.conf /etc/nginx/nginx.conf
COPY app /app
COPY web /web

# Make scripts executable
RUN chmod a+x /run.sh /run-limiter.sh

# Expose the ingress port internally
EXPOSE 8099

CMD [ "/run.sh" ]
