FROM nginx:alpine

# Install unzip to extract your SSL bundle
RUN apk add --no-cache unzip

# Create directory for SSL certs
RUN mkdir -p /etc/nginx/ssl

# Copy your SSL zip and index.html into the image
COPY Server_conf/shorturl.run.place.n102rh4m.zip /tmp/certs.zip
COPY index.html /usr/share/nginx/html/index.html

# Unzip the certs into /etc/nginx/ssl
RUN unzip /tmp/certs.zip -d /etc/nginx/ssl && \
    rm /tmp/certs.zip

# Copy our custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Expose HTTP and HTTPS
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
