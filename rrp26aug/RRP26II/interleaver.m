function[intlvddata]=interleaver(codedata)
%[intlvddata]=interleaver(codedata)
    s2=size(codedata,2);
    j=s2/4;
    matrix=reshape(codedata,j,4);

    intlvddata = matintrlv(matrix',2,2)';
    intlvddata=intlvddata';
end