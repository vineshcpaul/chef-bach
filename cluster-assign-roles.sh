#!/bin/bash
#
# This shell stub invokes the cluster_assign_roles.rb script using the
# binary gems pre-installed in vendor/bootstrap.
#
# See cluster_assign_roles.rb for a detailed description.
#
export PATH=/opt/chefdk/embedded/bin:/usr/bin:/bin

REPO_DIR="`dirname ${BASH_SOURCE[0]}`"
cd $REPO_DIR
bundle exec --keep-file-descriptors ./cluster_assign_roles.rb $*
