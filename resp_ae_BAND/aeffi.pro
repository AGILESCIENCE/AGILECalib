; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %             aeffi.pro               %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Effective area computation
; ---------------------------------------
; Authors:
; A. Giuliani, A. Chen (INAF/IASF Mi)
; ---------------------------------------
; Modification history:
; 24/10/2013: JPG removed, saving output in postscript (V. Fioretti)

pro aeffi,ee, a, run, fil, inde, bol

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

cag=canali(a(1,wg)*1000)
cal=canali(a(1,wl)*1000)
cas=canali(a(1,ws)*1000)
;ca31=canali(a31(1,w31)*1000)

canal=[10.,35,50,71,100,141,200,283,400,632,1000,1732,3000,5477,10000,20000,100000]
;er=sqrt(canal*shift(canal,-1))
er = canal;

ndx=-(inde-1)
trig=59.0e6
flux=trig/(136.5^2.*!pi)
k=flux /(10.^(ndx) - 5e4^(ndx))

f1= k * (10.^(ndx) - 35.^(ndx))
f2= k * (35.^(ndx) - 50.^(ndx))
f3= k * (50.^(ndx) - 71.^(ndx))
f4= k * (71.^(ndx) - 100.^(ndx))
f5= k * (100.^(ndx) - 141.^(ndx))
f6= k * (141.^(ndx) - 200.^(ndx))
f7= k * (200.^(ndx) - 283.^(ndx))
f8= k * (283.^(ndx) - 400.^(ndx))
f9= k * (400.^(ndx) - 632.^(ndx))
f10= k * (632.^(ndx) - 1000.^(ndx))
f11= k * (1000.^(ndx) - 1732.^(ndx))
f12= k * (1732.^(ndx) - 3000.^(ndx))
f13= k * (3000.^(ndx) - 5477.^(ndx))
f14= k * (5477.^(ndx) - 10000.^(ndx))
f15= k * (10000.^(ndx) - 20000.^(ndx))
f16= k * (20000.^(ndx) - 100000.^(ndx))

ff=[f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16]

set_plot,'ps'
device,file=run+'_'+fil+'.ps'
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

fits_write,run+'_'+fil+'.ae',[ transpose(er(0:15)),    $
                           transpose(smooth(cag/ff,2)), $
                           transpose(smooth(cal/ff,2)), $
                           transpose(smooth(cas/ff,2))  ]



;fits_write,fileflg+'.aeG',smooth(cag/ff,2)
;fits_write,fileflg+'.aeL',smooth(cal/ff,2)
;fits_write,fileflg+'.aeS',smooth(cas/ff,2)

device,/close
end
