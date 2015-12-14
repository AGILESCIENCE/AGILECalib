; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %             readaeff_I0025.pro           %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Routine called by AGILE_write_all_sar_I0025.pro
; Reading:
; - <filter>_<theta>_<phi>.txt
; ---------------------------------------
; Authors:
; A. Chen (INAF/IASF Mi)
; ---------------------------------------
; Modification history:
; 13/11/2013: adding /aref directory in the input parameters (V. Fioretti)
; 13/12/2015: new Fermi-style energy bands (A. Chen)

pro readaeff_I0025, ae_path, filter, theta, phi, energies, area, directory = directory

if n_elements(directory) eq 0 then begin
  directory=ae_path+'/'
  filename = directory + filter + '_' + theta + '_' +  phi + '_H.txt'
endif


e = 0.0d & ag = 0.0d & al = 0.0d & as = 0.0d
earr = [0.0d,10.0d] & agarr = [0.0d,0.1d] & alarr = [0.0d,0.1d] & asarr = [0.0d,0.1d]
dummy = ''

openr, u, filename, /get_lun
for i = 0, 2 do readf, u, dummy
while not eof(u) do begin
    readf, u, e, ag, al, as
    earr = [earr, e]
    	factor = 1.0
    agarr = [agarr, ag / factor]
    alarr = [alarr, al / factor]
    asarr = [asarr, as / factor]
endwhile
free_lun, u
num = n_elements(earr)-1
energies = earr[1:num]
area = replicate({G: 0.0d, L:0.0d, S:0.0d}, num)
area.G = agarr[1:num]
area.L = alarr[1:num]
area.S = asarr[1:num]

end


