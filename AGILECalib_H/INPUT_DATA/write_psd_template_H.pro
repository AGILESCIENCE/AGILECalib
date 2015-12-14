pro write_psd_template_H, infile, outfile

spawn, "rm "+outfile
head0 = headfits(infile)
dims = intarr(5)
for i=0,4 do begin
	dim = sxpar(head0,"NAXIS"+strn(i+1))
	dims[i] = dim
endfor
dims[2]=14
fxaddpar, head0, "NAXIS3", dims[2]
fxaddpar, head0, "DATE", '2015-12-14'
fxaddpar, head0, "FILE_ID", 'H0007'
fxaddpar, head0, "CREATOR", 'write_psd_template_H.pro'
psd_array = fltarr(dims)
writefits, outfile, psd_array, head0

head1 = headfits(infile, exten = 1)
fxaddpar, head1, "NAXIS3", dims[2]
fxaddpar, head0, "CREATOR", "write_psd_template_H.pro"
writefits, outfile, psd_array, head1, /append

head2 = headfits(infile, exten = 2)
naxis1 = sxpar(head2, "NAXIS1") - 8 ; 2 32-bit floats = 8 bytes less
fxaddpar, head2, "NAXIS1", naxis1, "width of table in bytes"
fxaddpar, head2, "TFORM3", '14E', "format of field"
array1 = (mrdfits(infile, 2)).rho
array2 = (mrdfits(infile, 2)).psi
array3 = [10.0,35,50,71,100,173,300,548,1000,1732,3000,5477,10000,20000]
array4 = (mrdfits(infile, 2)).polar_angle
array5 = (mrdfits(infile, 2)).azimuth_angle
;fxbaddcol, 2, head2, array3, 'POLAR_ANGLE', tunit = 'deg     '
;fxbaddcol, 3, head2, array4, 'AZIMUTH_ANGLE', tunit = 'deg     '
fxbcreate, u, outfile, head2
fxbwrite, u, array1, 1, 1
fxbwrite, u, array2, 2, 1
fxbwrite, u, array3, 3, 1
fxbwrite, u, array4, 4, 1
fxbwrite, u, array5, 5, 1
fxbfinish, u
spawn, "ftchecksum " + outfile + " update=yes"

end
