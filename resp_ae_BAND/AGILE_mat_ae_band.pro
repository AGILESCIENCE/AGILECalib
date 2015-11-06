; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %          AGILE_mat_ae_band.pro           %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Main script for response matrix and effective area production
; of band energy canals
; Reading:
; - SIM00000_3901_1_<source>_<theta>_<phi>_<filter>.flg
; - SIM00000_3901_1_<source>_<theta>_<phi>.dat
; Calling:
; - leggiv.pro
; - aeffi.pro
; - maris.pro
; Output:
; <filename>.ae
; <filename>.rsp
; <filename>.ps
; ---------------------------------------
; Authors:
; A. Giuliani, A. Chen (INAF/IASF Mi), V. Fioretti(INAF/IASF Bo)
; ---------------------------------------
; Creation date: 10/1/2014



; Default directory of the AGILE simulations
sim_path = '/data1/agile/AGILE_SIM/Calib/Kali08/dati'
; Simulation path keyword (0 = Default, 1 = enter new path) 
sim_path_key = 0
; Filter type 
fil_key=0
; Calibration source
spec='Vela'  
; Theta angle (deg.)
the=30
; Phi angle (deg.)
phi=0

bol=1

read, sim_path_key, PROMPT = '% - Simulation directory [0 = /data1/agile/AGILE_SIM/Calib/Kali08, 1 = new directory]:'
if sim_path_key EQ 1 then read, sim_path, PROMPT = '% - Simulation directory (e.g. /home):'

read, fil_key, PROMPT='% - Enter filter type [0 = FM, 1 = F4, 2 = FT3ab]:'

if fil_key EQ 0 then fil = 'FM'
if fil_key EQ 1 then fil = 'F4'
if fil_key EQ 2 then fil = 'FT3ab' 

read, spec, PROMPT='% - Enter calibration source [Vela or Crab]:'
read, the, PROMPT='% - Enter theta [e.g. 30]:'
read, phi, PROMPT='% - Enter phi [e.g. 0]:'

if spec eq 'Vela' then inde=1.7 
if spec eq 'Crab' then inde=2.2

fileflg=pickfile(filter='*'+spec+'*'+strtrim(the,2)+'_'+strtrim(phi,2)+'*'+fil+'*flg', $
                 path=sim_path, /READ)

c=STRSPLIT( fileflg ,'_F',/extract,/reg)
run=c(0)
filetelem=run+'.dat'

ee=mrdfits(fileflg,/fsc,1)
leggiv,a,filetelem

aeffi,ee, a, run, fil, inde, bol
;piesef,ee, a,the,phi,run,fil
maris,ee, a,the,phi,run,fil

print,'Fatto:',run

end
