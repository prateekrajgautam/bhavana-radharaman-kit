function[out]=qam16mod(in)
global plotmodulateddata
%[QAMENCODEDDATA]=qam16mod(interleaveddata)
    dec=bi2de(in','left-msb');
    M=16;
    out = qammod(dec,M);
    if plotmodulateddata==1
        scatterplot(out)
    end
end