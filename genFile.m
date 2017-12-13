%==========================================================================
%Generate display.
%
%Authors: Thomas Maullin
%==========================================================================

function genFile()
    
%     for i=1:21
%         datapath = fullfile(pwd, ['pain', num2str(i, '%02.f')]);
%         mkdir(datapath) 
%         websave(fullfile(datapath,'tmp.zip'), ['https://neurovault.org/collections/1425/pain_', num2str(i, '%02.f'), '.nidm.zip']);
%         unzip(fullfile(datapath, 'tmp.zip'), fullfile(datapath, '.'));
%     end
    
    for i=1:21
        datapath = fullfile(pwd, ['pain', num2str(i, '%02.f')]);
        if exist(fullfile(datapath, ['Contrast_T001.nii.gz']), 'file')
            contrasts{i} = fullfile(datapath, ['Contrast_T001.nii']);
            contrastSEs{i} = fullfile(datapath, ['ContrastStandardError_T001.nii']);
            gunzip(fullfile(datapath, ['Contrast_T001.nii.gz']));
            gunzip(fullfile(datapath, ['ContrastStandardError_T001.nii.gz']));
        elseif exist(fullfile(datapath, ['Contrast.nii.gz']), 'file')
            contrasts{i} = fullfile(datapath, ['Contrast.nii']);
            contrastSEs{i} = fullfile(datapath, ['ContrastStandardError.nii']);
            gunzip(fullfile(datapath, ['Contrast.nii.gz']));
            gunzip(fullfile(datapath, ['ContrastStandardError.nii.gz']));
        else
        end
    end 
    xyz = [70, 29, 46]
    temp = biasSelect(contrasts, contrastSEs, xyz)
    
    createAll(temp{1}, temp{2}, fullfile(pwd, 'Results_biased'))
    print('done')
    createAll(temp{3}, temp{4}, fullfile(pwd, 'Results_unbiased'))
    createRef(xyz)
    
end