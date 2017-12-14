function createAllHet(CElist, CSElist, outdir)
    
    masking.tm.tm_none = 1;
    masking.im = 1;
    masking.em = {''};
    
    createHetMeasure(masking, CElist, CSElist, outdir);
    
end