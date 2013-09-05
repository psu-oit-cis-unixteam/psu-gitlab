
# now the git user needs to be created. 
# all of the gitlab5 files are located in /home/git/
#
# then a ssh key for git needs to be made, so that files
# can be uploaded to the gitlab box
#

class gitlab5::user {
   user { 'git' :
	ensure		=> present, 
	comment		=> 'Git Version Control',
	groups		=> 'git',
	system		=> true,
	managehome	=> true,
}

# the next step is adding the ssh key (for git transfers)
# this process makes the ssh
   exec { '/usr/bin/ssh-keygen -q -N "" -t rsa -f /home/git/.ssh.id_rsa':
	user		=> 'git',
	creates		=> '/home/git/.ssh/id_rsa',
	require		=> User['git'],
	logoutput	=> on_failure,
}

# we need now to copy the id_rsa.pub to /home/git/.ssh/authorized_keys

   exec { 'copying id_rsa.pub to authorized_keys':

	command => '/usr/bin/cp /home/git/.ssh/id_rsa.pub /home/git/.ssh/authorized_keys',
}
