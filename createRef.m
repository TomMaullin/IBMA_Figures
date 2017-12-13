function createRef(xyz)
    vol       = spm_vol(fullfile(pwd, 'Results', 'eupiRegressionMap.nii'));

    for k=1:vol.dim(3)
        img      = spm_slice_vol(vol,spm_matrix([0 0 k]),vol.dim(1:2),0);;
        for i=1:vol.dim(1)
            for j=1:vol.dim(2)
                if ~isnan(img(i, j))

                    if i<(xyz(1)+2) & j<(xyz(2)+2) & k<(xyz(3)+2) &...
                            i>(xyz(1)-2) & j>(xyz(2)-2) & k>(xyz(3)-2)
                        finalMap2(i, j, k) = 1;
                    else
                        finalMap2(i, j, k) = 0.2;
                    end

                else
                    finalMap2(i, j, k) = NaN;
                end
            end
        end
    end

    newVol       = vol;
    %Create the filename.
    filename = ['testData', '.nii'];

    newVol.fname = fullfile(pwd, 'Results', filename);
    newVol       = spm_create_vol(newVol);
    %Read in slices.
    for i=1:vol.dim(3)
        img2 = squeeze(finalMap2(:, :, i));
        newVol       = spm_write_plane(newVol,img2,i);
    end
end