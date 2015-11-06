; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %            readedp_I0023.pro             %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; ---------------------------------------
; Authors:
; A. Chen (INAF/IASF Mi)
; ---------------------------------------

pro readedp_I0023, filter, theta, phi, resp, directory = directory

if n_elements(directory) eq 0 then begin
  directory='${HOME}/Calib/resp/'
endif
  filename = directory + 'SIM000000_3901_1_Vela_' + theta + '_' +  phi + '_' + filter + '.rsp'
print,filename
resp = mrdfits(filename,0,head)
return

end


