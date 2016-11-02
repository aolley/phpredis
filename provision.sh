# Packages
sudo su
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

# Build Env
su vagrant
mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
cd ~/rpmbuild/SOURCES
wget http://github.com/aolley/phpredis/archive/php7ns.tar.gz
tar -xzvf ~/rpmbuild/SOURCES/php7ns.tar.gz -C ~/rpmbuild/SPECS phpredis-php7ns/rpm/php-redis.spec --strip-components 2
echo "Ready to build. Just run \"rpmbuild -bb SPECS/php-redis.spec\" from the rpmbuild dir"
