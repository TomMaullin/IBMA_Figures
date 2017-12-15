%==========================================================================
% Get FDR thresholds for image.
%==========================================================================

function fdrImage(image)
    
    %Read in image
    volume = spm_vol(image);
    voxels = spm_read_vols(volume);  
    
    %Get voxels that aren't zero or nan
    voxels = voxels(voxels~=0);
    voxels = voxels(~isnan(voxels));
    
    pvals = 10.^-voxels;
    
    histogram(pvals)
    disp(min(pvals))
    length(pvals)
    length(unique(pvals))
    
    %Obtain thresholds
    [thr1, thr2] = FDR(pvals, 0.19);
    
    disp(thr1)
    disp(-log10(thr1))
    

end 