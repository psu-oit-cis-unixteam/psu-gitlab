class gitlab5::phase1

# this is not needed if using RHN Classic or RH Satelitte
# I had this since I used the CentOS repos
#
#	exec { 'adding needed repo':
#	 command	=> '/usr/bin/rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm',
#}

# so, this isn't a good example how to do something for puppet. really, it's a horrible example 
# 
# what we need to do first is to install the base which gitlab5 needs
# we need this base since we need to compile git (the CentOS git doesn't work properly with gitlab5)
#
# then it's nice to update the OS and to ensure the redis is up and running (gitlab5 needs redis). 
# 

	exec { 'installing Development Tools':
	   command	=> '/usr/bin/yum -y groupinstall "Development Tools" ',
}

	exec { 'installing needed software':
	   command	=> '/usr/bin/yum -y devel libyaml-devel libxml2-devel gdbm-devel libffi-devel zlib \
			zlib-devel openssl-devel libyaml-devel readline readline-devel curl-devel openssl-devel \
			pcre-devel git memcached-devel valgrind-devel mysql-devel ImageMagick-devel ImageMagick \
			libicu libicu-devel libffi-devel make bzip2 autoconf automake libtool bison iconv-devel \
			redis perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker wget ruby',
} 
	exec { 'updating the OS':
	   command	=> '/usr/bin/yum update -y',
}

	service { "redis":
	   ensure => "running",
}
