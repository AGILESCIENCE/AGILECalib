# AGILECalib_H
The software suite for the production of the AGILE mission (Tavani et al. 2009) calibration matrix with energy channels 100-300 MeV and 300-1000 MeV.
Data inputs for the production of the H0025 release are also included.

For a full explanation of the whole procedure see V. Fioretti et al., "AGILE Scientific Analysis: Calibration matrix production", INAF/IASF – Bologna Technical Report 653/2015

## Setting the environment variables

Modify the profile according to your settings:
- CALIB_DATA = path to the input .flg and .dat files. On bash:

export CALIB_DATA=<path>

- CALIB_AE_RSP = path to the output .ae and .dat files. On bash:

export CALIB_AE_RSP =<path>

- ADC_PATH = path to the ADC scientific analysis pipeline:

export ADC_PATH=<path>

Load the profile:
. calib_profile_H

## Preliminary processing

cd /resp_ae_BAND

idl

IDL> .r AGILE_mat_ae_band_loop_H

% Compiled module: $MAIN$.

% - Simulation directory [0 = $CALIB_DATA, 1 = new directory]:0

/home/calib/VF_CALIB_TEST/INPUT_DATA

% - Enter calibration source [Vela or Crab]:Vela

Processing file ... SIM000000_3901_1_Vela_30_00_FT3ab.flg

....

The output files are generated in $CALIB_DATA:
- <filename>.ae
- <filename>.rsp
- <filename>.ps

## Effective area - Step 1

Create the directory to store the .ae and .rsp files and set the CALIB_AE_RSP variable.

mkdir AE_RSP_DIR

export CALIB_AE_RSP=<path-to>/AE_RSP_DIR

mkdir $CALIB_AE_RSP/aref

mkdir $CALIB_AE_RSP/resp

mv $CALIB_DATA/*.ae $CALIB_AE_RSP/aref

mv $CALIB_DATA/*.rsp $CALIB_AE_RSP/resp

cd eff_area/

idl

IDL> .r AGILE_mksar_loop_H

% Compiled module: $MAIN$.

% - .ae directory [0 = $CALIB_AE_RSP/aref, 1 = new directory]:0

...

## Effective area - Step 2

Input files:
-  AG_GRID_G0017_S0001_H0007_template.sar.gz
-  $CALIB_AE_RSP/aref/${filter}_${theta}_${phi}.txt

Output files:
- $CALIB_AE_RSP/sar/AG_GRID_G0017_S${filter}${eventtype}_H0025.sar.gz

cd $CALIB_AE_RSP/
mkdir sar

cp $CALIB_DATA/*H*sar* ./sar/.

cd ../eff_area/

idl

IDL> .r AGILE_write_all_sar_I0023

% Compiled module: READAEFF_I0023.

% Compiled module: INTERP_SAR_I0023.

% Compiled module: $MAIN$.

% - .sar.gz directory [0 = $CALIB_AE_RSP/sar, 1 = new directory]:0

% - .ae directory [0 = $CALIB_AE_RSP/aref, 1 = new directory]:0

...

## Energy dispersion

Input files:
- $CALIB_AE_RSP/edp/edptest_2.edp
- $CALIB_AE_RSP/resp/SIM000000_3901_1_Vela_${theta}_${phi}_${filter}.rsp

Output files:
- $CALIB_AE_RSP/AG_GRID_G0017_S${filter}${eventtype}_I0023.edp.gz

cd $CALIB_AE_RSP/

mkdir edp
 
cp $CALIB_DATA/*_H.edp* ./edp/

cd ../energy_disp/

idl

DL> .r AGILE_write_all_edp_H0025

% Compiled module: READEDP_H0025.

% Compiled module: INTERP_EDP_H0025.

% Compiled module: $MAIN$.

% - .edp directory [0 = $CALIB_AE_RSP/edp, 1 = new directory]:0

% - .rsp directory [0 = $CALIB_AE_RSP/respp, 1 = new directory]:0

% Compiled module: MRDFITS.

...

## Point Spread Function

Input files:
- $CALIB_DATA/*.flg
- $CALIB_DATA/*.dat

Output files:
- $CALIB_AE_RSP/psdfit/AG_GRID_G0017_SF*_H0025.psd.gz
- $CALIB_AE_RSP/psdfit/psdfit_F*_table.fits.gz
- $CALIB_DATA/ SIM000000_3901_1__${theta}_${phi}_${filter}.out

cd $CALIB_AE_RSP/

mkdir psdfit

cp $CALIB_DATA/*H*.psd.gz ./psdfit/

cd ../psf/

sh createpsd_H.sh 
