#!/bin/sh

sed -i -e 's/^expose_php.*$/expose_php = Off/' /etc/php.ini

sed -i -e 's/AddDefaultCharset/#AddDefaultCharset/' /etc/httpd/conf/httpd.conf
sed -i -e 's/Options Indexes/Options/' /etc/httpd/conf/httpd.conf
sed -i -e 's/^\s*ScriptAlias/#ScriptAlias/' /etc/httpd/conf/httpd.conf

mv /etc/httpd/conf.d/userdir.conf /etc/httpd/conf.d/userdir.conf.org
mv /etc/httpd/conf.d/autoindex.conf /etc/httpd/conf.d/autoindex.conf.org
mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.org

cat <<EOT > /etc/httpd/conf.d/security.conf
ServerSignature Off
ServerTokens Prod
TraceEnable off
FileETag MTime Size
Header always set X-Content-Type-Options nosniff
#Header always set X-XSS-Protection "1; mode=block"
#Header always set X-Frame-Options SAMEORIGIN
#Header always set Content-Security-Policy "default-src 'self'"
EOT
