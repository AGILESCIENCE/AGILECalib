; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %             delta.pro               %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Delta energy between energy canals
; ---------------------------------------
; Authors:
; A. Giuliani, A. Chen (INAF/IASF Mi)
; ---------------------------------------
; Modification history:


function delta,v

delt=shift(v,-1)-v
del=delt(0:n_elements(delt)-2>0)

return,del

end
