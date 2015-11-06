#!/usr/bin/env bash

# fitpsf3.sh
# 
#
# Created by Andrew Chen on 6/12/10.
# Copyright 2010 __MyCompanyName__. All rights reserved.

for theta in 01 30 35 45 50 60 ; do
	for phi in 00 45 ; do
		dataprefix="$CALIB_DATA/SIM000000_3901_1_Vela"
		outfile=${dataprefix}_${theta}_${phi}.out
		$ADC_PATH/scientific_analysis/bin/AG_fitpsfarray3 dataprefix=$dataprefix theta=$theta phi=$phi > $outfile 
                
	done
done
