# Get the latest portstree (needed for virtualbox to be on 4.x)
portsnap fetch update

#First install sudo
cd /usr/ports/security/sudo
make install -DBATCH

#We prefer bash to be there
cd /usr/ports/shells/bash
make install -DBATCH


#Off to rubygems to get first ruby running
cd /usr/ports/devel/ruby-gems
make install -DBATCH

#Gem chef - does install chef 9.12 (latest in ports?)
cd /usr/ports/sysutils/rubygem-chef
make install -DBATCH

#Get wget
cd /usr/ports/ftp/wget
make install -DBATCH

#Installing vagrant keys
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
/usr/local/bin/wget --no-check-certificate 'http://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub' -O authorized_keys
chown -R vagrant /home/vagrant/.ssh

# The iso from virtualbox will only install windows/solaris or linux, no BSD
# Research is on it's way to have 4.x in the main portstree
# http://www.listware.net/201102/freebsd-ports/65201-call-for-testers-virtualbox-404.html
# Virtualbox additions - http://wiki.freebsd.org/VirtualBox
# Currently this will only work for 4.0.4 
cd /tmp
wget http://home.bluelife.at/ports/virtualbox-cft-20110218.tar.gz
cd /usr/ports
tar -xzvf /tmp/virtualbox-cft-20110218.tar.gz

# This requires libtool >= 2.4
cd /usr/ports/devel/libtool
make clean
make install -DBATCH

cd /usr/ports/emulators/virtualbox-ose-additions
make install -DBATCH

echo 'vboxguest_enable="YES"' >> /etc/rc.conf
echo 'vboxservice_enable="YES"' >> /etc/rc.conf

# Restore correct sudo permissions
# I'll leave that up to the reader :)
