; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %          AGILE_write_all_sar_H0026.pro           %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Description:
; Effective area production - step 2
; Reading:
; - AG_GRID_G0017_S0001_H0007_template.sar.gz
; - <filter>_<theta>_<phi>.txt
; Calling:
; - readaeff_I0026.pro, interp_sar_I0026.pro, initheads.pro
; Output:
; AG_GRID_G0017_S${filter}${eventtype}_H0026.sar.gz
; ---------------------------------------
; Authors:
; A. Chen (INAF/IASF Mi)
; ---------------------------------------
; Modification history:
; 6/10/2023: copied from AGILE_write_all_sar_H0025.pro (V. Fioretti)
; 6/10/2023: H0026 and T class added  (V. Fioretti)



@readaeff_I0026
@interp_sar_I0026

sar_path =  GETENV('CALIB_AE_RSP')
sar_path = sar_path+'/sar'

; .sar.gz path keyword (0 = Default, 1 = enter new path) 
sar_path_key = 0

read, sar_path_key, PROMPT = '% - .sar.gz directory [0 = $CALIB_AE_RSP/sar, 1 = new directory]:'
if sar_path_key EQ 1 then read, sar_path, PROMPT = '% - .sar.gz directory (e.g. /home):'

ae_path = GETENV('CALIB_AE_RSP')
ae_path = ae_path+'/aref'
; .ae path keyword (0 = Default, 1 = enter new path) 
ae_path_key = 0

read, ae_path_key, PROMPT = '% - .ae directory [0 = $CALIB_AE_RSP/aref, 1 = new directory]:'
if ae_path_key EQ 1 then read, ae_path, PROMPT = '% - .ae directory (e.g. /home):'

template = sar_path+'/AG_GRID_G0017_S0001_H0007_template.sar.gz'

fileid = 'H0026'
factor = [[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]]

table = mrdfits(template,0,head0)
flags = mrdfits(template,1,head1)
labels = mrdfits(template,2,head2)
initheads, head0, head1, head2, fileid

filters = ['F4','FM','FT3ab']
status = ['G','L','S', 'T']
thetas = ['01','30','35','45','50','60']
nthetas = n_elements(thetas)
phis = ['00','45']
nphis = n_elements(phis)

thetamap = intarr(n_elements(labels.polar_angle))
for itheta = 1, nthetas - 1 do thetamap = thetamap + (labels.polar_angle ge thetas[itheta])
thetamap = thetamap + (labels.polar_angle ge 70.0)

readaeff_I0025, ae_path, filters[0], thetas[0], phis[0], energies, areas
nenergies = n_elements(energies)
allareas = replicate(areas[0], nenergies, nthetas, nphis)

for ifilter = 0, n_elements(filters)-1 do $
   for istatus = 0, n_elements(status)-1 do begin
        stancon = 'S' + filters[ifilter] + status[istatus]
        filename = sar_path+'/AG_GRID_G0017_' + stancon + '_' + fileid + '.sar'
        sxaddpar, head0, 'STAN_CON', stancon
        sxaddpar, head0, 'EXTEND', 'T'
        for itheta = 0, nthetas - 1 do for iphi = 0, nphis - 1 do begin
            readaeff_I0025, ae_path, filters[ifilter], thetas[itheta], phis[iphi], energies, areas
            allareas[*, itheta, iphi] = areas
        endfor
        interp_sar_I0025, table, allareas, labels, energies, thetas, phis, istatus, factor = factor[*,ifilter]
        mwrfits, table, filename, head0, /create
        mwrfits, flags, filename, head1
        mwrfits, labels, filename, head2
        spawn, 'ftchecksum '+filename+' update=yes datasum=yes chatter=0'
        spawn, 'gzip -f '+filename
endfor 
end
