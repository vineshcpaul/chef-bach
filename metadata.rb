name             'bach_wrapper'
maintainer       'Bloomberg LP'
maintainer_email 'compute@bloomberg.net'
license          'All rights reserved'
description      'Top-level chef-bach wrapper'
long_description 'Top-level chef-bach wrapper'
version          '2.0.3'

depends 'bach_common', '= 2.0.3'
depends 'bach_krb5', '= 2.0.3'
depends 'bach_spark', '= 2.0.3'
depends 'bcpc', '= 2.0.3'
depends 'bcpc-hadoop', '= 2.0.3'
depends 'bcpc_jmxtrans', '= 2.0.3'
depends 'hannibal', '= 2.0.3'
depends 'java','>= 1.41.0'
depends 'kafka-bcpc', '= 2.0.3'

# Transitive dependencies specified to retain Chef 11.x compatibility.
depends 'apt', '= 2.4.0'
depends 'build-essential', '= 3.2.0'
depends 'chef-client', '= 4.2.4'
depends 'chef-vault', '= 1.3.0'
depends 'database'
depends 'krb5', '= 2.0.0'
depends 'line'
depends 'logrotate', '~> 1.9.2'
depends 'maven', '= 2.1.1'
depends 'ntp', '= 1.10.1'
depends 'ohai', '= 3.0.1'
depends 'poise', '= 1.0.12'
depends 'sysctl', '= 0.7.5'
depends 'windows', '= 1.36.6'
