; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %             matmake16.pro               %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Making the response matrix (BAND)
; Calling:
; - delta.pro
; ---------------------------------------
; Authors:
; A. Giuliani, A. Chen (INAF/IASF Mi)
; ---------------------------------------
; Modification history:


function matmake16,e_true,e_rec


canal_etrue=[10,35,50,71,100,141,200,283,400,632,1000,1732,3000,5477,10000,20000,100000]
canal_erec=[0,35,50,71,100,141,200,283,400,632,1000,1732,3000,5477,10000,20000,100000]


mat=fltarr(n_elements(canal_erec)-1,n_elements(canal_etrue)-1)

for i=0,n_elements(canal_etrue)-2 do begin

w=where(e_true ge canal_etrue(i) and  e_true lt canal_etrue(i+1))

   if total(w) ne -1 then begin
   
   ;de_true=e_true(w)
   de_rec=e_rec(w)
   nde=n_elements(w)*1.

      for j=0,n_elements(canal_erec)-2 do begin
      
      wr=where(de_rec ge canal_erec(j) and  de_rec lt canal_erec(j+1))
      if total(wr) ne -1 then mat(i,j)=n_elements(wr)/nde
 
      endfor
   endif
endfor

return,mat

end
