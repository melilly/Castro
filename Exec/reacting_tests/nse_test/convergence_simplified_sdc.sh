#!/bin/bash

# echo the commands
set -x

EXEC=./Castro2d.gnu.MPI.SMPLSDC.ex
RUNPARAMS="
castro.time_integration_method=3
"

mpiexec -n 8 ${EXEC} inputs.64 ${RUNPARAMS} >& /dev/null
mpiexec -n 8 ${EXEC} inputs.128 ${RUNPARAMS} >& /dev/null
mpiexec -n 16 ${EXEC} inputs.256 ${RUNPARAMS} >& /dev/null

RichardsonConvergenceTest2d.gnu.ex coarFile=nse_test_64_plt00125 mediFile=nse_test_128_plt00250 fineFile=nse_test_256_plt00500  >& nse_convergence_simple_sdc_lo.out

mpiexec -n 16 ${EXEC} inputs.512 ${RUNPARAMS} >& /dev/null

RichardsonConvergenceTest2d.gnu.ex coarFile=nse_test_128_plt00250 mediFile=nse_test_256_plt00500 fineFile=nse_test_512_plt01000 >& nse_convergence_simple_sdc_hi.out


