function[rxd]=removecp(ofdmsignal)
    for i=1:64
        rxd(i)=ofdmsignal(i+16);
    end
end