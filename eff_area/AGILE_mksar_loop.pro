; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %          AGILE_mksar_loop.pro           %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Effective area production - step 1
; Reading:
; - SIM00000_3901_1_<source>_<theta>_<phi>_<filter>.ae
; Calling:
; - area.pro
; Output:
; <filter>_<theta>_<phi>.txt
; ---------------------------------------
; Authors:
; A. Chen (INAF/IASF Mi)
; ---------------------------------------
; Modification history:
; 13/11/2013: selecting the /aref directory (V. Fioretti)
; 6/11/2015: loading the environment variable (V. Fioretti)
; 6/10/2023: T class added (V. Fioretti)

ae_path = GETENV('CALIB_AE_RSP')
ae_path = ae_path+'/aref'
; .ae path keyword (0 = Default, 1 = enter new path) 
ae_path_key = 0

read, ae_path_key, PROMPT = '% - .ae directory [0 = $CALIB_AE_RSP/aref, 1 = new directory]:'
if ae_path_key EQ 1 then read, ae_path, PROMPT = '% - .ae directory (e.g. /home):'

spec='Vela'
str_theta=['01','30','35','45','50','60']
str_phi=['00','45']
filtro=['FT3ab', 'F4', 'FM']



nthetas = n_elements(str_theta)
nphis = n_elements(str_phi)
nfiltros = n_elements(filtro)
for t=0, nthetas-1 do begin
	for p=0, nphis-1 do begin
		for f=0, nfiltros-1 do begin


                        ener=[35,50,71,100,141,200,283,400,632,1000,1732,3000,5477,10000,20000]

                        ;if theta eq 1 then str_theta='01' else str_theta=strtrim(theta,2)
                        ;if phi eq 0 then str_phi='00' else str_phi=strtrim(phi,2)
                        if str_theta[t] eq '01' then phi = 0 else phi = fix(str_phi[p])

                        fileperandrew=ae_path+'/'+filtro[f]+'_'+str_theta[t]+'_'+str_phi[p]+'.txt'

                        openw,u,fileperandrew,width=1000,/get_lun
                        printf,u
                        printf,u,'       E        AeffG        AeffL        AeffS       AeffT'
                        printf,u

                        for i=0,n_elements(ener)-1 do begin
                                printf,u, ener[i], area(ae_path=ae_path, energ=ener[i], tip='G', theta=fix(str_theta[t]), phi=phi, filtro=filtro[f], spec=spec),   $
                                area(ae_path=ae_path, energ=ener[i], tip='L', theta=fix(str_theta[t]), phi=phi, filtro=filtro[f], spec=spec),   $
                                area(ae_path=ae_path, energ=ener[i], tip='S', theta=fix(str_theta[t]), phi=phi, filtro=filtro[f], spec=spec),   $
                                area(ae_path=ae_path, energ=ener[i], tip='T', theta=fix(str_theta[t]), phi=phi, filtro=filtro[f], spec=spec)

                        endfor
                        free_lun,u

                endfor
        endfor
endfor

end
