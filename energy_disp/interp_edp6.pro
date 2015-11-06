; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %            interp_edp6.pro               %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; ---------------------------------------
; Authors:
; A. Chen (INAF/IASF Mi)
; ---------------------------------------

pro interp_edp6, table, allresps, labels, thetas, phis, istatus
nthetas = n_elements(thetas)
nphis = n_elements(phis)
thetamap = intarr(n_elements(labels.polar_angle))
for itheta = 1, nthetas - 1 do thetamap = thetamap + (labels.polar_angle ge thetas[itheta])
thetamap = thetamap + (labels.polar_angle gt 90.0)
           for ittab = 0, n_elements(labels.polar_angle) - 1 do $
              for iaztab = 0, n_elements(labels.azimuth_angle) - 1 do begin
                      table[*,*,ittab,iaztab] = allresps[istatus,*,*, thetamap[ittab], iaztab mod 2]
             endfor

end
