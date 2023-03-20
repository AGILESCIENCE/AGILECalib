; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %          AGILE_write_all_edp_I0023.pro           %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Energy dispersion
; Reading:
; - edptest_2.edp
; - SIM000000_3901_1_Vela_<theta>_<phi>_<filter>.rsp
; Calling:
; - readedp_I0023.pro, interp_edp6.pro, initheads.pro
; Output:
; AG_GRID_G0017_S<filter><eventtype>_I0023.edp.gz
; ---------------------------------------
; Authors:
; A. Chen (INAF/IASF Mi)
; ---------------------------------------
; Modification history:
; 13/11/2013: selecting the /Calib and /aref directory (V. Fioretti)
; 06/11/2015: loading the environment variables (V. Fioretti)

@readedp_I0023
@interp_edp6

edp_path = GETENV('CALIB_AE_RSP')
edp_path = edp_path + '/edp'
; .edp path keyword (0 = Default, 1 = enter new path) 
edp_path_key = 0

read, edp_path_key, PROMPT = '% - .edp directory [0 = $CALIB_AE_RSP/edp, 1 = new directory]:'
if edp_path_key EQ 1 then read, edp_path, PROMPT = '% - .edp directory (e.g. /home):'

rsp_path = GETENV('CALIB_AE_RSP')
rsp_path = rsp_path+'/resp'
; .rsp path keyword (0 = Default, 1 = enter new path) 
rsp_path_key = 0

read, rsp_path_key, PROMPT = '% - .rsp directory [0 = $CALIB_AE_RSP/resp, 1 = new directory]:'
if rsp_path_key EQ 1 then read, rsp_path, PROMPT = '% - .rsp directory (e.g. /home):'

template = edp_path+'/edptest_2.edp'
fileid = 'I0023'
table = mrdfits(template,0,head0)
flags = mrdfits(template,1,head1)
labels = mrdfits(template,2,head2)
initheads, head0, head1, head2, fileid

;help,table,flags,labels
;help,/str,table,flags,labels

filters = ['F4','FM','FT3ab']
status = ['G','L','S','T']
thetas = ['01','30','35','45','50','60']
nthetas = n_elements(thetas)
phis = ['00','45']
nphis = n_elements(phis)

thetamap = intarr(n_elements(labels.polar_angle))
for itheta = 1, nthetas - 1 do thetamap = thetamap + (labels.polar_angle ge thetas[itheta])
thetamap = thetamap + (labels.polar_angle ge 70.0)
; print, thetamap

; readedp6, filters[0], thetas[0], phis[0], resp
netrue = n_elements(labels.true_energy)
nerec = n_elements(labels.obs_energy_channel)
allresps = fltarr(n_elements(status), netrue, nerec, nthetas, nphis)

for ifilter = 0, n_elements(filters)-1 do $
   for istatus = 0, n_elements(status)-1 do begin
        stancon = 'S' + filters[ifilter] + status[istatus]
        filename = edp_path+'/AG_GRID_G0017_' + stancon + '_' + fileid + '.edp'
        sxaddpar, head0, 'STAN_CON', stancon
        sxaddpar, head0, 'EXTEND', 'T'
        for itheta = 0, nthetas - 1 do for iphi = 0, nphis - 1 do begin
            readedp_I0023, filters[ifilter], thetas[itheta], phis[iphi], resp, $
              dir = rsp_path+'/'
            allresps[*, *, *, itheta, iphi] = resp
        endfor
        interp_edp6, table, allresps, labels, thetas, phis, istatus
        mwrfits, table, filename, head0, /create
        mwrfits, flags, filename, head1
        mwrfits, labels, filename, head2
        spawn, 'ftchecksum '+filename+' update=yes datasum=yes chatter=0'
        spawn, 'gzip -fq '+filename
endfor 
end
