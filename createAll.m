function createAll(CElist, CSElist, outdir, sampleSizes)

    masking.tm.tm_none = 1;
    masking.im = 1;
    masking.em = {''};
    
    createTrimAndFill(masking, CElist, CSElist, outdir);
    
    createBeggsCorrelation(masking, CElist, CSElist, outdir);
    
    createRegress(masking, CElist, CSElist, outdir, 'eu');
        
%     createRegress(CElist, CSElist, outdir, 'm', 'i', sampleSizes);
%     createRegress(CElist, CSElist, outdir, 'm', 's', sampleSizes);
%     createRegress(CElist, CSElist, outdir, 'm', 'ps', sampleSizes);
%     
%     createHetMeasure(CElist, CSElist, outdir, 'I');
%     createHetMeasure(CElist, CSElist, outdir, 'Q');
%     createHetMeasure(CElist, CSElist, outdir, 'P');
    
end