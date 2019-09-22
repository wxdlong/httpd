#!/bin/bash
set -e

APR_VERSION=${APR_VERSION:-1.7.0}
HTTP_VERSION=${HTTP_VERSION:-2.4.41}
APR_UTIL_VERSION=${APR_UTIL_VERSION:-1.6.1}
RPM_HOME=/root/rpmbuild/RPMS/x86_64


echo "=============================================="
env
echo "=============================================="

sysctl -w net.ipv6.conf.all.disable_ipv6=0
if [ $? -ne 0 ]; then
	{
		echo "APR need enable IPV6, otherwise will test failed."
		echo "Docker container don't have privileged!"
	}
fi

rpmbuild -tb apr-${APR_VERSION}.tar.bz2 | tee arp.log
rpmbuild -tb apr-util-${APR_UTIL_VERSION}.tar.bz2 | tee arp-util.log
rpm -ivh ${RPM_HOME}/apr-*
rpm -ivh ${RPM_HOME}/apr-util-*
rpmbuild -tb httpd-${HTTP_VERSION}.tar.bz2 > ${APACHE_SRC}/httpd.log | tee http.log
ls -lth ${RPM_HOME}