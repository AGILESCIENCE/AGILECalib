#!/usr/bin/env bash

# fitpsf_H.sh
# 
#
# Created by Andrew Chen on 6/12/10.
# Copyright 2010 __MyCompanyName__. All rights reserved.

dataprefix="${CALIB_DATA}/SIM000000_3901_1_Vela"
for theta in 30 35 45 50 60 ; do
	for phi in 00 45 ; do
		outfile=${dataprefix}_H_${theta}_${phi}.out
		$ADC_PATH/scientific_analysis/bin/AG_fitpsfarray3_H dataprefix=$dataprefix theta=$theta phi=$phi &> $outfile
	done
done
$ADC_PATH/scientific_analysis/bin/AG_fitpsfarray3_H dataprefix=$dataprefix theta=01 phi=00 &> ${dataprefix}_H_01_00.out

