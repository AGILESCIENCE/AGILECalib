; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %             maris.pro               %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Writing response file (BAND)
; Calling:
; - matmake16.pro
; ---------------------------------------
; Authors:
; A. Giuliani, A. Chen (INAF/IASF Mi)
; ---------------------------------------





pro maris,ee,a,the,phi,run,fil


tipo=['G','L','S']
mmat=fltarr(4,16,16)

for j=0,2 do begin

    wc=where(ee.evstatus eq tipo(j))
    mat=matmake16(a(1,wc)*1000,ee(wc).energy)
    mmat(j,*,*)=mat
       
endfor

wc=where((ee.evstatus eq tipo(0)) and (ee.evstatus eq tipo(1)) and (ee.evstatus eq tipo(2)))
mat=matmake16(a(1,wc)*1000,ee(wc).energy)
mmat(3,*,*)=mat

;map,total(mmat(0,*,*),1),/scl

fits_write,run+'_'+fil+'.rsp',mmat


end
