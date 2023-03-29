#!/bin/bash

gfortran -o a1 1-com-trdf-xy.f90 &
gfortran -o a2 1-com-trdf-yx.f90 &
wait
./a1 &
./a2 &
wait
  
####################non-zero-probability(+ 0. 0. 0. )############ 
grep -v "0.0000000000000000" <x-y-nd.dat >fort-a1.dat
grep -v "0.0000000000000000" <y-x-nd.dat >fort-a2.dat
cat >fort-2.dat << EOF
0. 0. 0.
EOF
cat fort-a1.dat fort-2.dat >fort-xy.dat
cat fort-a2.dat fort-2.dat >fort-yx.dat
#####################average density ################# 
gfortran -o b1 2-average-density-xy.f90 
gfortran -o b2 2-average-density-yx.f90 
wait
./b1 &
./b2
wait
#####################determine isochoric density profile ################# 
gfortran -o c1 3-isochoric-xy.f90
gfortran -o c2 3-isochoric-yx.f90
wait
./c1 &
./c2
wait
