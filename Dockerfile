FROM  centos:6
LABEL maintainer https://github.com/CentOS/sig-cloud-instance-images
LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.name="CentOS Base Image" \
    org.label-schema.vendor="CentOS" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date="20181006"
RUN yum update -y
RUN yum install -y epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-6.rpm
RUN yum-config-manager -y --enable remi-php54
RUN yum install -y httpd php php-gd php-pdo php-mbstring php-mcrypt PyGreSQL bzip2 wget perl mod_ssl
RUN chkconfig httpd on
RUN wget -O IBSng-A1.24.tar.bz2  https://sourceforge.net/projects/ibsng/files/latest/download
RUN tar xvfj IBSng-A1.24.tar.bz2 -C /usr/local/
RUN rm -f IBSng-A1.24.tar.bz2
RUN sed  -i '1i #!/usr/bin/python' /usr/local/IBSng/core/lib/IPy.py
RUN sed  -i '2i # -*- coding:utf-8 -*-' /usr/local/IBSng/core/lib/IPy.py
RUN sed  -i '1i #!/usr/bin/python' /usr/local/IBSng/core/lib/mschap/des_c.py
RUN sed  -i '2i # -*- coding:utf-8 -*-' /usr/local/IBSng/core/lib/mschap/des_c.py
RUN sed  -i 's/;date.timezone =/date.timezone ="Asia\/\Tehran"/g' /etc/php.ini
RUN cp /usr/local/IBSng/addons/logrotate/IBSng /etc/logrotate.d/IBSng
RUN cp /usr/local/IBSng/init.d/IBSng.init.redhat /etc/init.d/IBSng
CMD ["/bin/bash"]
