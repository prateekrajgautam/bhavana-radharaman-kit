function[]=plotresult(BER,snr)
[d,c]=size(BER);
for col=1:c
    ber(1,col)=0;  
    for row=1:d;
        ber(1,col)=ber(1,col)+BER(row,col);
    end
end
ber=sum(BER)/100; 
figure
i=0:2:48;
semilogy(snr,ber);
title('BER vs SNR');
ylabel('BER');
xlabel('SNR (dB)');
grid on
end