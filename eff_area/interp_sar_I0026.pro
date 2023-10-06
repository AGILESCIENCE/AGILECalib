; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %            interp_sar_I0026              %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; ---------------------------------------
; Authors:
; A. Chen (INAF/IASF Mi)
; ---------------------------------------
; Modification History:
; 06/10/2023: copied from interp_sar_I0023.pro (V. Fioretti)

pro interp_sar_I0026, table, allareas, labels, energies, thetas, phis, istatus, factor = factor

nthetas = n_elements(thetas)
nphis = n_elements(phis)
thetamap = intarr(n_elements(labels.polar_angle))
for itheta = 1, nthetas - 1 do thetamap = thetamap + (labels.polar_angle ge thetas[itheta])
thetamap = thetamap + (labels.polar_angle gt 90.0)
nenergies = n_elements(energies)
        for ietab = 0, n_elements(labels.energy) - 1 do $
           for ittab = 0, n_elements(labels.polar_angle) - 1 do $
              for iaztab = 0, n_elements(labels.azimuth_angle) - 1 do begin
                 if thetamap[ittab] gt (nthetas - 1) then table[ietab, ittab, iaztab] = 0 $
                 else begin
                      t0 = 10.0d ^ interpol(alog10(allareas[*, thetamap[ittab], iaztab mod 2].(istatus)), alog10(energies), alog10(labels.energy[ietab]))
                      if thetamap[ittab]+1 gt (nthetas - 1) then begin
;                          print, t0
                        t1 = t0
                        endif else $
                        t1 = 10.0d ^ interpol(alog10(allareas[*, thetamap[ittab]+1, iaztab mod 2].(istatus)), alog10(energies), alog10(labels.energy[ietab]))
                      if (thetamap[ittab]+1 lt nthetas) then $
                        table[ietab, ittab, iaztab] = interpol([t0,t1], double(thetas[thetamap[ittab]:thetamap[ittab]+1]), labels.polar_angle[ittab])  $
                      else $
                        table[ietab, ittab, iaztab] = interpol([t0,t1], double([thetas[thetamap[ittab]],thetas[thetamap[ittab]]+40.0]), labels.polar_angle[ittab])
                  endelse
                  table[ietab, ittab, iaztab] = factor[ittab] * table[ietab, ittab, iaztab]
             endfor

end
