FROM rmkn/centos7
MAINTAINER rmkn

RUN yum -y install httpd cronolog

RUN rpm --import https://rpms.remirepo.net/RPM-GPG-KEY-remi
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum -y install --enablerepo=remi,remi-php72 php php-mbstring

COPY security.sh /tmp/
RUN /tmp/security.sh

COPY vhost.conf /etc/httpd/conf.d/

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

