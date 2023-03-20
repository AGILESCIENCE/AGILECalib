; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %                area.pro                  %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Function called by mksar.pro
; Reading:
; - SIM00000_3901_1_<source>_<theta>_<phi>_<filter>.ae
; Output:
; <filter>_<theta>_<phi>.txt
; ---------------------------------------
; Authors:
; A. Chen (INAF/IASF Mi)
; ---------------------------------------
; Modification history:
; 13/11/2013: taking the /aref directory as input (V. Fioretti)



function area,ae_path=ae_path,theta=theta,phi=phi,energy=energy,tip=tip,spec=spec,filtro=filtro


if not keyword_set(spec) then spec='Vela'
if not keyword_set(tip) then tip='G'
if not keyword_set(theta) then theta=30
if not keyword_set(phi) then phi=0
if not keyword_set(filtro) then filtro='F4'

if theta eq 1 then str_theta='01' else str_theta=strtrim(theta,2)
if phi eq 0 then str_phi='00' else str_phi=strtrim(phi,2)

fileae=ae_path+'/SIM000000_3901_1_'+spec+'_'+str_theta+'_'+str_phi+'_'+filtro+'.ae'

                ;print,tip


af=mrdfits(fileae)

energie=af(0,*)

if tip eq 'G' then aree=af(1,*)
if tip eq 'L' then aree=af(2,*)
if tip eq 'S' then aree=af(3,*)
if tip eq 'T' then aree=af(4,*)

                ;print,aree

ae=interpol(alog10(aree),alog10(energie),alog10(energy))

return,10.^ae




end
