%==========================================================================
%Generate niftis for display.
%
% type - 'het' for heterogeneity, 'pub' for publication bias.
%
%Authors: Thomas Maullin
%==========================================================================

function temp = genFile(type)
    
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
    
    if type == 'pub'
        xyz = [42, 49, 49]
        temp = biasSelect(contrasts, contrastSEs, xyz)

        createAll(temp{1}, temp{2}, fullfile(pwd, 'Results_biased'))
        createAll(temp{3}, temp{4}, fullfile(pwd, 'Results_unbiased'))
        createRef(xyz)

        masking.tm.tm_none = 1;
        masking.im = 1;
        masking.em = {''};


        preprocessed_bias = readAndPreprocess(temp{1}, temp{2}, masking)
        preprocessed_unbias = readAndPreprocess(temp{3}, temp{4}, masking)

        funnelPlot(preprocessed_bias, xyz)
        funnelPlot(preprocessed_unbias, xyz)
        disp('Beggs')
        fdrImage('Results_biased/pBeggsCorrelationMap.nii')        
        disp('Egger')
        fdrImage('Results_biased/eupiRegressionMap.nii')
    end
    if type == 'het'
        createAllHet({contrasts{1:21}}, {contrastSEs{1:21}}, fullfile(pwd, 'Results_Het'))
        disp('Het')
        fdrImage('Results_het/pHeterogeneityMap.nii')
    end
    
end