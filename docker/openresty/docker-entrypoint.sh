#!/bin/sh
set -e

# Substitute environment variables into the nginx config template
envsubst '${DOMAIN}' < /etc/openresty/nginx.conf.template > /usr/local/openresty/nginx/conf/nginx.conf

echo "Starting OpenResty with DOMAIN=${DOMAIN}"

exec /usr/local/openresty/bin/openresty -g "daemon off;"
