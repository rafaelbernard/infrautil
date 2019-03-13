#!/bin/sh
set -x

monit_installed=0

# @todo - check operational system
# @todo - write install for more OSs (debian-based)

centos_install () {
  echo "Installing monit"
  yum install -y monit
}

if rpm -q monit
then
    monit_installed=1
fi

if [ $monit_installed -ne 1 ] ; then
  centos_install
fi

# @todo improve this check
monit_intalled=0
if rpm -q monit
then
    monit_installed=1
fi

if [ $monit_installed -ne 1 ] ; then
  exit 0
fi

cd /etc/monit.d/
# @todo create a way to link to default system config / available-config-folder
ln -sf /usr/local/git/infra/config-available/monit/monit.d
ln -sf monit.d/system
systemctl enable monit
systemctl start monit
