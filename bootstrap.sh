#!/bin/bash

#
# TODO: melhorar o provisionamento do puppetserver
#

### vars
REPO="https://github.com/williancardoso/controlrepo.git"
REPO_PUPPETLABS="https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm"
ENVIRONMENT="production"

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
echo "/opt/puppetlabs/puppet/bin/r10k deploy environment $ENVIRONMENT -v debug --puppetfile"
/opt/puppetlabs/puppet/bin/r10k deploy environment $ENVIRONMENT -v debug --puppetfile

### "tapa" no VIM
/opt/puppetlabs/bin/puppet apply -e "class {'userprefs': editor => 'vim', shell => 'bash'}"

### puppet apply
/opt/puppetlabs/bin/puppet apply -e "include role::puppetserver" --hiera_config /etc/puppetlabs/code/hiera.yaml --environment $ENVIRONMENT
