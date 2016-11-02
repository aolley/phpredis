# Packages
yum -y install wget
wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
wget https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm
rpm -Uvh remi-release-7.rpm epel-release-7-8.noarch.rpm
yum update
yum install -y yum-utils gcc
yum-config-manager --enable remi-php70
yum update
yum install -y php php-devel php-pecl-igbinary-devel php-pecl-igbinary php-pear rpm-build
rm ./*.rpm
