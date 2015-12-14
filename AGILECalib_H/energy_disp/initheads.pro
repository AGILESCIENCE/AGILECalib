; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %              initheads.pro               %
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; ---------------------------------------
; Authors:
; A. Chen (INAF/IASF Mi)
; ---------------------------------------

pro initheads, head0, head1, head2, fileid
caldat, systime(/jul),month,day,year,hour,minute,second
sxaddpar, head0, 'DATE', strn(year)+'-'+strn(month)+'-'+strn(day)
sxdelpar, head0, 'EXTNAME'
sxdelpar, head0, 'EXTVER'
sxaddpar, head0, 'FILETYPE', 'EFF_AREA'
sxaddpar, head0, 'CREATOR', 'write_all_sar'
sxaddpar, head1, 'CREATOR', 'write_all_sar'
sxaddpar, head0, 'AUTHOR', 'Andrew Chen'
sxaddpar, head0, 'FILE_ID', fileid
end
