class gitlab5::rvm

# here's yet another example of how not to do a puppet thing
#
# what we need to do there is to install rvm in git's directory
# this is needed since gitlab5 needs ruby 1.9.3
# puppet 2.7 will continue to use ruby 1.8.7 
#
# after rvm/ruby has been installed, git needs to be downloaded/compiled/installed
#
# last step: the .bash_profile/.bashrc/.profile needs to be copied over
#


# firstly, install rvm into /home/git/.rvm 
   exec { 'installing rvm into /home/git':
	path	=> '/usr/bin:/usr/sbin:/bin',
	command => 'cd /home/git',
	command => 'su -u git -H \curl -L https://get.rvm.io | bash',
}

# need to install ruby 1.9.3 in the /home/git/.rvm 

   exec { 'installing ruby 1.9.3 in /home/git/.rvm':
	path    => '/usr/bin:/usr/sbin:/bin',
	command => 'cd /home/git',
	command => 'su - git',
	command => 'source .bash_profile',
	command => 'rvm requirements',
	command => 'rvm install 1.9.3',
	command => 'rvm use 1.9.3 --default", 
}


# need to install git into /home/git/git/ 

   exec { 'installing later version of git':
	path    => '/usr/bin:/usr/sbin:/bin',
	command => 'cd /home/git',
	command => 'su - git',
	command => 'mkdir temp && cd temp',
	command => 'wget -c https://git-core.googlecode.com/files/git-1.8.2.3.tar.gz',
	command => 'tar xf git.1.8.2.3.tar.gz',
	command => 'cd git-1.8.2.3',
	command => './configure --prefix=/home/git/git',
	command => 'make && make install && make clean',
}

# need to copy the .bash_profile and the .bashrc/.profile over 
# the git path needs to include first the rvm ruby (1.9.3) and git's more recent version of git
# the CentOS 6.4 version of git is out of date for GitLab 5 

   file { "/home/git/.bash_profile":
	ensure => present,
	owner => git, 
	group => git,
	source => "puppet:///modules/.bash_profile"
}

   file { "/home/git/.bashrc": 
	ensure => present,
	owner => git, 
	group => git, 
	source => "puppet:///modules/.bashrc"
}

   file { "/home/git/.profile":
	ensure => present,
	owner => git,
	group => git, 
	source => "puppet:///modules/.profile"
}



	


# next part -- installing the gitlab-shell 
# copy over the files from the templates dir 

