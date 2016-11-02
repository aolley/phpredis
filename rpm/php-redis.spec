%global php_apiver  %((echo 0; php -i 2>/dev/null | sed -n 's/^PHP API => //p') | tail -1)
%global php_extdir  %(php-config --extension-dir 2>/dev/null || echo "undefined")
%global php_version %(php-config --version 2>/dev/null || echo 0)

# after igbinary
%if "%{php_version}" < "5.6"
%global ini_name    redis.ini
%else
# after 40-igbinary
%global ini_name    50-redis.ini
%endif

Name:           php-redis
Version:        3.0.0netspot1
Release:        1%{?dist}
Summary:        The phpredis extension provides an API for communicating with the Redis key-value store.

Group:          Development/Languages
License:        PHP
URL:            https://github.com/aolley/phpredis
Source0:        https://github.com/aolley/phpredis/archive/php7ns.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildRequires:  php-devel
Requires:       php(zend-abi) = %{php_zend_api}
Requires:       php(api) = %{php_apiver}

%description
The phpredis extension provides an API for communicating with the Redis key-value store.

%prep
%setup -q -n phpredis-php7ns

%build
%{_bindir}/phpize
%configure \
    --enable-redis \
    --enable-redis-session \
    --enable-redis-igbinary \
    --with-php-config=%{_bindir}/php-config
make %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT
make install INSTALL_ROOT=$RPM_BUILD_ROOT

# install configuration
%{__mkdir} -p $RPM_BUILD_ROOT%{_sysconfdir}/php.d
install -D -m 644 rpm/redis.ini $RPM_BUILD_ROOT%{_sysconfdir}/php.d/%{ini_name}

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%doc CREDITS
%config(noreplace) %{_sysconfdir}/php.d/%{ini_name}
%{php_extdir}/redis.so

%changelog
* Wed Nov 02 2016 Adam Olley <adam.olley@blackboard.com> - 3.0.0netspot1
- Supports clusters with a single master
- Fixes a memory leak in RedisCluster that occured on all reads.
