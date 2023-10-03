; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %             maris_H.pro               %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Writing response file (BAND)
; Calling:
; - matmake16.pro
; ---------------------------------------
; Authors:
; A. Giuliani, A. Chen (INAF/IASF Mi)
; ---------------------------------------
; 13/12/2015: new Fermi-style energy bands (A. Chen)
; 03/10/2023: T class added (V. Fioretti)




pro maris_H,ee,a,the,phi,run,fil


tipo=['G','L','S']
mmat=fltarr(4,14,14)

for j=0,2 do begin

    wc=where(ee.evstatus eq tipo(j))
    mat=matmake14(a(1,wc)*1000,ee(wc).energy)
    mmat(j,*,*)=mat
       
endfor

;map,total(mmat(0,*,*),1),/scl

fits_write,run+'_'+fil+'_H.rsp',mmat


end
