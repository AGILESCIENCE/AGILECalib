; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %             leggiv.pro               %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Reading ASCII file .dat
; ----------------------------------------
; Versione: 1.0     Data: 06/09/2001
; Autore: Andrea Giuliani - IASF/CNR
; giuliani@mi.iasf.cnr.it
; ---------------------------------------
; Modification history:
; 24/10/2013: JPG removed, saving output in postscript (V. Fioretti)

pro leggiv,a,filex



  if n_params() le 1 then begin
  ;print,' Voglio il file con i vertici ! ! ' 
  filex=dialog_pickfile() & if filex eq '' then return
  endif
  
  a=0.
  
  strut=read_ascii(filex,count=n_righe) 
  
  nomi=tag_names(strut) & print,nomi
  
  if nomi(0) eq 'FIELD001' then  a=strut.field001
  if nomi(0) eq 'FIELD01' then  a=strut.field01
  if nomi(0) eq 'FIELD1' then  a=strut.field1

end
