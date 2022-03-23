function[cext_data]=addcp(ifftdata)
    cext_data=zeros(80,1);
    cext_data(1:16)=ifftdata(49:64);
    for i=1:64
        cext_data(i+16)=ifftdata(i);
    end
end