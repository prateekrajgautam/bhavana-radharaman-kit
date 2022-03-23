function[ber1,err1]=finderror(data,recieveddata)
    c=xor(data,recieveddata);
    err1=nnz(c);
    ber1=err1/numel(data);
end
    