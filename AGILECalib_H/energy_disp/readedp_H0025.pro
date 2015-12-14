; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %            readedp_H0025.pro             %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; ---------------------------------------
; Authors:
; A. Chen (INAF/IASF Mi)
; ---------------------------------------
; 13/12/2015: new Fermi-style energy bands (A. Chen)

pro readedp_H0025, filter, theta, phi, resp, directory = directory

if n_elements(directory) eq 0 then begin
  directory='${HOME}/Calib/resp/'
endif
  filename = directory + 'SIM000000_3901_1_Vela_' + theta + '_' +  phi + '_' + filter + '_H.rsp'
print,filename
resp = mrdfits(filename,0,head)
return

end


