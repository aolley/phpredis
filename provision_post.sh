# Build Env
rm -rf ~/rpmbuild
mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
cd ~/rpmbuild/SOURCES
wget http://github.com/aolley/phpredis/archive/php7ns.tar.gz
tar -xzvf ~/rpmbuild/SOURCES/php7ns.tar.gz -C ~/rpmbuild/SPECS phpredis-php7ns/rpm/php-redis.spec --strip-components 2
echo "Ready to build. Just run \"rpmbuild -bb SPECS/php-redis.spec\" from the rpmbuild dir"
