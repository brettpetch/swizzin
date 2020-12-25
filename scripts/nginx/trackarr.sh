#!/usr/bin/env bash

. /etc/swizzin/sources/functions/utils
user=$(_get_master_username)
cat > /etc/nginx/apps/trackarr.conf << EOF
location /trackarr/ {
    proxy_pass              http://127.0.0.1:7337/trackarr;
    proxy_set_header        X-Forwarded-Host        \$http_host;
    auth_basic "What's the password?";
    auth_basic_user_file /etc/htpasswd.d/htpasswd.${user};
}
EOF

sed -i "s|baseurl: /$|baseurl: /trackarr|" /opt/trackarr/config.yaml
sed -i "s|host: 0.0.0.0|host: 127.0.0.1|" /opt/trackarr/config.yaml
