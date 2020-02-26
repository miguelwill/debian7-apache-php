#!/bin/bash


sed '11s/AllowOverride\ None/AllowOverride\ All/' /etc/apache2/sites-enabled/000-default > /tmp/la
cat /tmp/la > /etc/apache2/sites-enabled/000-default
sed '12s/AllowOverride\ None/AllowOverride\ All/' /etc/apache2/sites-enabled/default-ssl > /tmp/le
cat /tmp/le > /etc/apache2/sites-enabled/default-ssl
#echo "CustomLog /proc/self/fd/1" > /etc/apache2/conf.d/other-vhosts-access-log
rm -f /etc/apache2/conf.d/other-vhosts-access-log

sed -i '/output_buffering = 4096/c output_buffering = Off' /etc/php5/apache2/php.ini
#sed -i '/SecRuleEngine DetectionOnly/c SecRuleEngine On' /etc/modsecurity/modsecurity.conf
#sed -i '/SecRequestBodyLimit 13107200/c SecRequestBodyLimit 131072000' /etc/modsecurity/modsecurity.conf
#sed -i '/SecRequestBodyNoFilesLimit 131072/c SecRequestBodyNoFilesLimit 1310720' /etc/modsecurity/modsecurity.conf
#sed -i '/SecRequestBodyInMemoryLimit 131072/c SecRequestBodyInMemoryLimit 1310720' /etc/modsecurity/modsecurity.conf
#sed -i '/SecPcreMatchLimit 1000/c SecPcreMatchLimit 10000' /etc/modsecurity/modsecurity.conf
#sed -i '/SecPcreMatchLimitRecursion 1000/c SecPcreMatchLimitRecursion 10000' /etc/modsecurity/modsecurity.conf
#sed -i '/SecResponseBodyLimit 524288/c SecResponseBodyLimit 5242880' /etc/modsecurity/modsecurity.conf

if [ -n "$RELAY_HOST" ]
then
        postconf -e relayhost=$RELAY_HOST
fi


/etc/init.d/memcached start

rm -f /var/run/apache2.pid && exec apache2 -DFOREGROUND
