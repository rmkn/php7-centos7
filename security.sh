#!/bin/sh

sed -i.org -e '/^expose_php/cexpose_php = Off' /etc/php.ini

sed -i.org -e 's/AddDefaultCharset/#AddDefaultCharset/' /etc/httpd/conf/httpd.conf
sed -i -e '/Options/s/\s*Indexes//' /etc/httpd/conf/httpd.conf
sed -i -e '/^\s*ScriptAlias/s/ScriptAlias/#ScriptAlias/' /etc/httpd/conf/httpd.conf

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
