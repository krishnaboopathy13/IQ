# IQ Enterprise — Docker Image
# Uses nginx:alpine — minimal footprint (~25 MB)

FROM nginx:1.27-alpine

LABEL maintainer="IQ Platform"
LABEL version="2.0"
LABEL description="IQ Enterprise Assessment Platform"

# Remove default nginx site
RUN rm /etc/nginx/conf.d/default.conf

# Copy nginx config
COPY nginx.docker.conf /etc/nginx/conf.d/iq.conf

# Copy app files
COPY index.html     /usr/share/nginx/html/
COPY manifest.json  /usr/share/nginx/html/
COPY sw.js          /usr/share/nginx/html/
COPY icons/         /usr/share/nginx/html/icons/

# Healthcheck
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost/index.html | grep -q "IQ" || exit 1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
