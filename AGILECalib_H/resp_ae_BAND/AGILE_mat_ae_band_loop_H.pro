@maris_H
@canali_H
@aeffi_H
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %          AGILE_mat_ae_band_loop_H.pro           %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Main LOOP script for response matrix and effective area production
; of band energy canals. It loops over a defined set of filter,
; theta and phi values.
; Reading:
; - SIM00000_3901_1_<source>_<theta>_<phi>_<filter>.flg
; - SIM00000_3901_1_<source>_<theta>_<phi>.dat
; Calling:
; - leggiv.pro
; - aeffi.pro
; - maris.pro
; Output:
; <filename>_H.ae
; <filename>_H.rsp
; <filename>.ps
; ---------------------------------------
; Authors:
; A. Giuliani, A. Chen (INAF/IASF Mi), V. Fioretti(INAF/IASF Bo)
; ---------------------------------------
; Creation date: 10/1/2014
; Modification history:
; VF (06/11/2015): $CALIB_DATA envionment variable added
; 13/12/2015: new Fermi-style energy bands (A. Chen)


; Default directory of the AGILE simulations
sim_path = GETENV('CALIB_DATA')

; Simulation path keyword (0 = $CALIB_DATA, 1 = enter new path) 
sim_path_key = 0
read, sim_path_key, PROMPT = '% - Simulation directory [0 = $CALIB_DATA, 1 = new directory]:'
if sim_path_key EQ 1 then read, sim_path, PROMPT = '% - Simulation directory (e.g. /home):'

; Calibration source
spec='Vela'  

bol=1


read, spec, PROMPT='% - Enter calibration source [Vela or Crab]:'

if spec eq 'Vela' then inde=1.7 
if spec eq 'Crab' then inde=2.2

fil=['FT3ab','F4','FM']
the=['30','35','45','50','60','01']
phi=['00','45']


for phiind = 0,(n_elements(phi)-1) do for theind = 0, (n_elements(the)-1) do for filind = 0,(n_elements(fil)-1) do begin
	if theind eq 5 then phiphiind = phi[0] else phiphiind = phi[phiind]
	
        fileflg=(findfile( sim_path+'/*'+spec+'*'+the[theind]+'_'+phiphiind+'*'+fil[filind]+'*flg'))[0]
	
	print, 'Processing file ... SIM000000_3901_1_'+spec+'_'+the[theind]+'_'+phiphiind+'_'+fil[filind]+'.flg'

	c=STRSPLIT( fileflg ,'_F',/extract,/reg)
	run=c[0]
	filetelem=run+'.dat'

	ee=mrdfits(fileflg,/fsc,1)
	
	leggiv,a,filetelem
 	aeffi_H,ee, a, run, fil[filind], inde, bol
 	maris_H,ee, a,fix(the[theind]),fix(phiphiind),run,fil[filind]

print,'Fatto:',run

endfor
end
