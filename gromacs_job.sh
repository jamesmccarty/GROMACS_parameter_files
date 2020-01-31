#!/bin/bash

source /cluster/research-groups/mccarty/bin/bin/GMXRC

mpirun -v -n 2 gmx_mpi mdrun -v -deffnm nvt -ntomp 12

# gmx_mpi mdrun -v -deffnm nvt
