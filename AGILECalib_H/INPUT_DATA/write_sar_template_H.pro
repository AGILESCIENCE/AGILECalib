pro write_sar_template_H, infile, outfile

spawn, "rm "+outfile
spawn, "ftcopy "+infile+"+0[1:14,*,*] "+outfile+" copyall=NO"
spawn, "ftappend "+infile+"+1[1:14,*,*] "+outfile

fxbopen, u2, infile, 2, head2
;fxbread, u2, array1, 1, 1
fxbclose, u2
naxis1 = sxpar(head2, "NAXIS1") - 8 ; 2 32-bit floats = 8 bytes less
fxaddpar, head2, "NAXIS1", naxis1, "width of table in bytes"
fxaddpar, head2, "TFORM1", '14E', "format of field"
sxdelpar, head2, "CHECKSUM"
sxdelpar, head2, "DATASUM"
array1 = [10.0,35,50,71,100,173,300,548,1000,1732,3000,5477,10000,20000]
array3 = (mrdfits(infile, 2)).polar_angle
array4 = (mrdfits(infile, 2)).azimuth_angle
;fxbaddcol, 2, head2, array3, 'POLAR_ANGLE', tunit = 'deg     '
;fxbaddcol, 3, head2, array4, 'AZIMUTH_ANGLE', tunit = 'deg     '
fxbcreate, u, outfile, head2
fxbwrite, u, array1, 1, 1
fxbwrite, u, array3, 2, 1
fxbwrite, u, array4, 3, 1
fxbfinish, u

end
