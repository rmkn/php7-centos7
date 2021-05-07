FROM rmkn/centos7
LABEL maintainer "rmkn"

RUN yum -y install httpd cronolog

RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-remi
RUN yum -y install --enablerepo=remi,remi-php74 php php-mbstring
RUN sed -i -e '/^;date.timezone/cdate.timezone = Asia/Tokyo' /etc/php.ini

COPY security.sh /tmp/
RUN /tmp/security.sh

COPY vhost.conf /etc/httpd/conf.d/

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

