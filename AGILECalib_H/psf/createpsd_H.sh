#!/usr/bin/env bash

ADC=$ADC_PATH

PSDFIT=$CALIB_AE_RSP/psdfit

./fitpsf_H.sh
rm $PSDFIT/psdfit_*_table.fits.gz
$ADC/scientific_analysis/bin/AG_createpsd3 dataprefix=${CALIB_DATA}/SIM000000_3901_1_Vela_H outprefix=$PSDFIT/psdfit_H
for filter in FT3ab F4 FM ; do 
   for eventtype in S L G ; do 
      rm $PSDFIT/AG_GRID_G0017_S${filter}${eventtype}_H0025.psd.gz
      $ADC/scientific_analysis/bin/AG_createpsd outfile=$PSDFIT/AG_GRID_G0017_S${filter}${eventtype}_H0025.psd.gz psdtemplate=$PSDFIT/AG_GRID_G0017_SFMG_H0007.psd.gz paramfile=$PSDFIT/psdfit_H_${filter}${eventtype}_table.fits.gz
   done
done

