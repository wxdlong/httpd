FROM centos:7
LABEL maintainer="wxdlong@qq.com"

ENV HTTP_VERSION=2.4.41
ENV APR_VERSION=1.7.0
ENV APR_UTIL_VERSION=1.6.1

WORKDIR /home/httpd

#install packages
RUN yum install -y gcc gcc-c++ make automake autoconf libtool doxygen libuuid-devel pcre-devel \
  rpm-build expat-devel postgresql-devel mysql-devel sqlite-devel tar wget \
  unixODBC-devel openldap-devel openssl-devel nss-devel which epel-release file \
  lua-devel libxml2-devel libdb-devel &&\
  yum install -y libdb4-devel libdb4-devel-static.x86_64
RUN wget "http://mirrors.tuna.tsinghua.edu.cn/apache//apr/apr-${APR_VERSION}.tar.bz2" &&\
  wget "http://mirrors.tuna.tsinghua.edu.cn/apache//apr/apr-util-${APR_UTIL_VERSION}.tar.bz2" &&\
  wget "http://mirrors.tuna.tsinghua.edu.cn/apache//httpd/httpd-${HTTP_VERSION}.tar.bz2"
COPY build_rpm.sh .
ENTRYPOINT ["/home/httpd/build_rpm.sh"]