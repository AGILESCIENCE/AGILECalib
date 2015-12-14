; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %             aeffi_H.pro               %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Effective area computation
; ---------------------------------------
; Authors:
; A. Giuliani, A. Chen (INAF/IASF Mi)
; ---------------------------------------
; Modification history:
; 24/10/2013: JPG removed, saving output in postscript (V. Fioretti)
; 13/12/2015: new Fermi-style energy bands (A. Chen)

pro aeffi_H,ee, a, run, fil, inde, bol

; fil='F4'
; tip='G'
; bol=1

; if bol then ono='' else omo=' NON '
; tit=fil+' - '+ono+tip

; fileflg=pickfile(filter='*'+fil+'*flg')

; c=STRSPLIT( fileflg ,'_F',/extract,/reg)
; filetelem=c(0)+'.dat'
; ;filetelem=pickfile(filter="*dat")

; ee=mrdfits(fileflg,/fsc,1)
; leggiv,a,filetelem


; Vuole ee, a, run, inde,  bol 


wg=where((ee.evstatus eq 'G') eq bol)
wl=where((ee.evstatus eq 'L') eq bol)
ws=where((ee.evstatus eq 'S') eq bol)
;w31=where((ee31.evstatus eq tip) eq bol)

cag=canali_H(a(1,wg)*1000)
cal=canali_H(a(1,wl)*1000)
cas=canali_H(a(1,ws)*1000)
;ca31=canali(a31(1,w31)*1000)

;canal=[10.,35,50,71,100,141,200,283,400,632,1000,1732,3000,5477,10000,20000,100000]
canal=[10.,35,50,71,100,173,300,548,1000,1732,3000,5477,10000,20000,100000]
numchannels = n_elements(canal)-1
;er=sqrt(canal*shift(canal,-1))
er = canal;

ndx=-(inde-1)
trig=59.0e6
flux=trig/(136.5^2.*!pi)
k=flux /(10.^(ndx) - 5e4^(ndx))

ff = k * (canal[0:numchannels-1]^ndx - canal[1:numchannels]^ndx)

set_plot,'ps'
device,file=run+'_'+fil+'_H.ps'
device,yoffset=8,ysize=13,xoffset=1.,xsize=18
device, /color, bits_per_pixel=8
loadct,5

RED   = [0, .5, 1, 0, 0, 1, 1, 0]
GREEN = [0, .5, 0, 1, 0, 1, 0, 1]
BLUE  = [0, 1., 0, 0, 1, 0, 1, 1]
TVLCT, 255 * RED, 255 * GREEN, 255 * BLUE

plot_oo,er,smooth(cag/ff,2) $
         ,psym=-3,yrange=[1,1000.],xrange=[10,100000.],xstyle=1,ystyle=1     $
         ,xtitle='Energy [MeV]',ytitle='Effective Area [cm!u2!n]',title='black:G, blue:L, red:S'

oplot,er,smooth(cal/ff,2),psym=-3,color=1, thick=3
oplot,er,smooth(cas/ff,2),psym=-3,color=2, thick=3
;oplot,er,smooth(ca31/ff,2),psym=-6,color=verde
oplot,er,smooth(cag/ff,2),psym=-3,color=0, thick=3


;legend,['F4','F2','FT3-0','FT3-1'],color=[nero,blu,rosso,verde],linestyle=[0,0,0,0],/bot,/rig

fits_write,run+'_'+fil+'_H.ae',[ transpose(er[0:numchannels-1]),    $
                           transpose(smooth(cag/ff,2)), $
                           transpose(smooth(cal/ff,2)), $
                           transpose(smooth(cas/ff,2))  ]



;fits_write,fileflg+'.aeG',smooth(cag/ff,2)
;fits_write,fileflg+'.aeL',smooth(cal/ff,2)
;fits_write,fileflg+'.aeS',smooth(cas/ff,2)

device,/close
end
