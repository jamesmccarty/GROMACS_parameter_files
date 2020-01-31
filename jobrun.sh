#!/bin/bash

source /cluster/research-groups/mccarty/Software/plumed2/sourceme.sh

cp2krun='/cluster/research-groups/mccarty/Software/cp2k/exe/local/cp2k.popt'
mympirun='/cluster/research-groups/mccarty/Software/cp2k/tools/toolchain/install/openmpi-4.0.1/bin/mpirun'

unset DISPLAY
export PATH=/cluster/share/support/bin:$PATH
export MPI_MCA_mca_base_component_show_load_errors=0
export PMIX_MCA_mca_base_component_show_load_errors=0


export PLUMED_KERNEL="/cluster/research-groups/mccarty/bin/lib/libplumedKernel.so"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cluster/research-groups/mccarty/bin/lib

PATH="/cluster/research-groups/mccarty/bin/bin:$PATH"




_CONDOR_PROCNO=$_CONDOR_PROCNO
_CONDOR_NPROCS=$_CONDOR_NPROCS

CONDOR_SSH=`condor_config_val libexec`
CONDOR_SSH=$CONDOR_SSH/condor_ssh

SSHD_SH=`condor_config_val libexec`
SSHD_SH=$SSHD_SH/sshd.sh

. $SSHD_SH $_CONDOR_PROCNO $_CONDOR_NPROCS

# If not the master process, just sleep forever, to let the
# sshds run
if [ $_CONDOR_PROCNO -ne 0 ]
then
                wait
                sshd_cleanup
                exit 0
fi

CONDOR_CONTACT_FILE=$_CONDOR_SCRATCH_DIR/contact
export CONDOR_CONTACT_FILE
#cp $CONDOR_CONTACT_FILE condor.txt

# The second field in the contact file is the machine name
# that condor_ssh knows how to use
sort -n -k 1 < $CONDOR_CONTACT_FILE | awk '{print $2}' > machines

# Call mpirun if we are the master process
$mympirun -n $_CONDOR_NPROCS -hostfile machines $cp2krun em.inp > em.out $@

