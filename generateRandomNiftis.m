%==========================================================================
%Generates test data for publication bias detection. This takes in the
%following arguments;
%
%cube - the random cube that will show 'activation'.
%outdir - the output directory.
%n - the number of desired files.
%
%Authors: Thomas Maullin, Camille Maumet.
%==========================================================================

function studySizes = generateRandomNiftis(cube, outdir, vol, n, xyz)

    vol       = spm_vol(vol);
    
    x0 = cube.x0;
    x1 = cube.x1;
    y0 = cube.y0;
    y1 = cube.y1;
    z0 = cube.z0;
    z1 = cube.z1;
    
    %Read in slices.
    for j=1:vol.dim(3)
        img      = spm_slice_vol(vol,spm_matrix([0 0 j]),vol.dim(1:2),0);
        conDataStructure(:,:,j) = img;  
    end
    
    studySizes = [];
    for m = 1:n
        disp(m);
        studySize = randi(90, 1) + 10;
        studySizes = [studySizes studySize];
        studyVar = 12*rand(1, 1)/sqrt(studySize);
        studyVar2 = 12*rand(1, 1)/sqrt(studySize);
        actVal = normrnd(3, studyVar);
        
        dx = 0.2*rand(1, 1)-0.1;
        dy = 0.2*rand(1, 1)-0.1;
        dz = 0.2*rand(1, 1)-0.1;
      
        for k=1:vol.dim(3)
            img      = conDataStructure(:,:,k);
            for i=1:vol.dim(1)
                for j=1:vol.dim(2)
                    if ~isnan(img(i, j))
                        if x0<i & i<x1 & y0<j & j<y1 & z0<k & k<z1
                            finalMap(i, j, k) = actVal + (i-x0)*dx +...
                                                         (j-y0)*dy +...
                                                         (k-z0)*dz;
                            finalMap2(i, j, k) = 0.2;
                        else
                            finalMap(i, j, k) = normrnd(0, studyVar2);
                            finalMap2(i, j, k) = 0.2;
                        end
                                               
                        if i<(xyz(1)+2) & j<(xyz(2)+2) & k<(xyz(3)+2) &...
                                i>(xyz(1)-2) & j>(xyz(2)-2) & k>(xyz(3)-2)
                            finalMap2(i, j, k) = 1;
                        end
                        
                    else
                        finalMap(i, j, k) = NaN;
                        finalMap2(i, j, k) = NaN;
                    end
                end
            end
        end

        newVol       = vol;
        newVol2       = vol;

        %Create the filename.
        filename = ['testData', num2str(m), '.nii'];

        newVol.fname = fullfile(outdir, 'contrasts', filename);
        newVol       = spm_create_vol(newVol);

        newVol2.fname = fullfile(outdir, 'contrastSEs', filename);
        newVol2       = spm_create_vol(newVol2);

        %Read in slices.
        for i=1:vol.dim(3)
            img = squeeze(finalMap(:, :, i));
            newVol       = spm_write_plane(newVol,img,i);
            img2 = squeeze(finalMap2(:, :, i));
            newVol2       = spm_write_plane(newVol2,img2,i);
        end
    
end