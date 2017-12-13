function createAll(CElist, CSElist, outdir, sampleSizes)

    createTrimAndFill(CElist, CSElist, outdir, 'R');
    createTrimAndFill(CElist, CSElist, outdir, 'L');
    createTrimAndFill(CElist, CSElist, outdir, 'Q');
    
    createBeggsCorrelation(CElist, CSElist, outdir, 't');
    createBeggsCorrelation(CElist, CSElist, outdir, 'z');
    createBeggsCorrelation(CElist, CSElist, outdir, 'p');
    
    createRegress(CElist, CSElist, outdir, 'eu', 'i');
    createRegress(CElist, CSElist, outdir, 'eu', 's');
    createRegress(CElist, CSElist, outdir, 'eu', 'pi');

    createRegress(CElist, CSElist, outdir, 'ew', 'i');
    createRegress(CElist, CSElist, outdir, 'ew', 's');
    createRegress(CElist, CSElist, outdir, 'ew', 'pi');
        
%     createRegress(CElist, CSElist, outdir, 'm', 'i', sampleSizes);
%     createRegress(CElist, CSElist, outdir, 'm', 's', sampleSizes);
%     createRegress(CElist, CSElist, outdir, 'm', 'ps', sampleSizes);
%     
%     createHetMeasure(CElist, CSElist, outdir, 'I');
%     createHetMeasure(CElist, CSElist, outdir, 'Q');
%     createHetMeasure(CElist, CSElist, outdir, 'P');
    
end