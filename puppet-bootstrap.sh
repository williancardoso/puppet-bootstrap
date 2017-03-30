#!/bin/bash

#
# TODO: preparar script para instalar o puppetserver
#
#

### vars
REPO="https://wvcardoso@gitlab.com/wvcardoso/pcp-controlrepo.git"
REPO_PUPPETLABS="https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm"

### install puppet repos
yum install $REPO_PUPPETLABS -y --nogpgcheck

### Install puppet-agent
yum install puppet -y --nogpgcheck

### abstrai se yum ou apt-get
/opt/puppetlabs/bin/puppet resource package git ensure=present
/opt/puppetlabs/bin/puppet resource package vim-enhanced ensure=present

### configure hiera
cat > /etc/puppetlabs/code/hiera.yaml <<EOF
---
:backends:
  - yaml
:yaml:
  :datadir: "/etc/puppetlabs/code/environments/%{environment}/hieradata"
:hierarchy:
  - "nodes/%{::trusted.certname}"
  - "%{::osfamily}"
  - common
EOF

mkdir -p /etc/puppetlabs/code/environments/production/hieradata/nodes/
cat > /etc/puppetlabs/code/environments/production/hieradata/nodes/puppetserver.yaml <<EOF
---
puppetserver::install::version: '2.7.2'

EOF

### install r10k
/opt/puppetlabs/puppet/bin/gem install r10k

### configure r10k
mkdir -p /etc/puppetlabs/r10k
cat > /etc/puppetlabs/r10k/r10k.yaml <<EOF
---
:cachedir: /opt/puppetlabs/server/data/puppetserver/r10k
:sources:
  puppet:
    basedir: /etc/puppetlabs/code/environments
    remote: $REPO
EOF

### r10k 
/opt/puppetlabs/puppet/bin/r10k deploy environment production -v debug --puppetfile

### puppet apply
/opt/puppetlabs/bin/puppet apply -e "include role::puppetmaster" --hiera_config /etc/puppetlabs/code/hiera.yaml
