# AGILECalib
The software suite for the production of the AGILE mission (Tavani et al. 2009) calibration matrix.
Data inputs for the production of the I0023 release is also included.

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
. calib_profile

## Preliminary processing

cd /resp_ae_BAND

idl

IDL> .r AGILE_mat_ae_band_loop

% Compiled module: $MAIN$.

% - Simulation directory [0 = $CALIB_DATA, 1 = new directory]:0

/home/calib/VF_CALIB_TEST/INPUT_DATA

% - Enter calibration source [Vela or Crab]:Vela

Processing file ... SIM000000_3901_1_Vela_30_00_FT3ab.flg


