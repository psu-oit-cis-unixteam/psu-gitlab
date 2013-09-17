class gitlab::needed_software.pp {

# this is not needed if using RHN Classic or RH Satelitte
# I had this since I used the CentOS repos
#
#	exec { 'adding needed repo':
#	 command	=> '/usr/bin/rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm',
#}

# this could be a better example. let's hope so. using arrays and puppet commands instead of just commands
# 
# what we need to do first is to install the base which gitlab5 needs
# we need this base since we need to compile git (the CentOS git doesn't work properly with gitlab5)
#
# then it's nice to update the OS and to ensure the redis is up and running (gitlab5 needs redis). 
# 

# this may not be needed as well since it seems that the CentOS setup, using the RH repos comes
# with the compiler tools already installed
#
#	exec { 'installing Development Tools':
#	 command	=> '/usr/bin/yum -y groupinstall "Development Tools" ',
#	}

	$software1 = [ "libyaml-devel", "libxml2-devel", "gdbm-devel", "libffi-devel", "zlib" ]
	$software2 = [ "zlib-devel", "openssh-devel", "readline", "readline-devel", "curl-devel" ]
	$software3 = [ "pcre-devel", "git", "memcached-devel", "valgrind-devel", "mysql-devel", "ImageMagick-devel" ]
	$software4 = [ "ImageMagick", "libicu", "libicu-devel", "libffi-devel", "make", "bzip2", "autoconf" ]
	$software5 = [ "automake", "libtool", "bison", "iconv-devel", "redis", "perl-ExtUtils-CBuilder" ]
	$software6 = [ "perl-ExtUtils-MakeMaker", "wget", "ruby" ]

	package { $software1: ensure => "installed" }
	package { $software2: ensure => "installed" }
	package { $software3: ensure => "installed" }
	package { $software4: ensure => "installed" }
	package { $software5: ensure => "installed" }
	package { $software6: ensure => "installed" }

	service { "redis":
	   ensure => "running",
	}
}
