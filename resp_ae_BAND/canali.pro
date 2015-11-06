; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %             canali.pro               %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Energy canals
; ---------------------------------------
; Authors:
; A. Giuliani, A. Chen (INAF/IASF Mi)
; ---------------------------------------
; Modification history:


function canali,en

; Divide in canali

canal_erec=[10,35,50,71,100,141,200,283,400,632,1000,1732,3000,5477,10000,20000,100000]
;canal_erec=[10,50,100,200,400,1000,3000,10000,100000]


can=fltarr(n_elements(canal_erec)-1)

for j=0,n_elements(canal_erec)-2 do begin

wr=where(en ge canal_erec(j) and  en lt canal_erec(j+1),nw)
can(j)=nw

endfor
 

;can=fltarr(8)
;if total(where(en lt 50)) ne -1 then can(0)=n_elements(where(en lt 50))
;if total(where(en ge 50 and en lt 100)) ne -1 then can(1)=n_elements(where(en ge 50 and en lt 100))
;if total(where(en ge 100 and en lt 200)) ne -1 then can(2)=n_elements(where(en ge 100 and en lt 200))
;if total(where(en ge 200 and en lt 400)) ne -1 then can(3)=n_elements(where(en ge 200 and en lt 400))
;if total(where(en ge 400 and en lt 1000)) ne -1 then can(4)=n_elements(where(en ge 400 and en lt 1000))
;if total(where(en ge 1000 and en lt 3000)) ne -1 then can(5)=n_elements(where(en ge 1000 and en lt 3000))
;if total(where(en ge 3000 and en lt 10000)) ne -1 then can(6)=n_elements(where(en ge 3000 and en lt 10000))
;if total(where(en ge 10000)) ne -1 then can(7)=n_elements(where(en ge 10000))


return,can

end
