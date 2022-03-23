function[]=plotresult(BER,snr,lname)
[d,c]=size(BER);
for col=1:c
    ber(1,col)=0;  
    for row=1:d;
        ber(1,col)=ber(1,col)+BER(row,col);
    end
end
ber(1,:)=ber(1,:);
ber=BER/100; 
figure
i=0:2:48;
semilogy(snr,ber,'-*');
title('BER vs SNR');
ylabel('BER');
xlabel('SNR (dB)');
grid on
legend(lname)
saveas(gcf,'result.jpg','jpg')
saveas(gcf,'result.pdf','pdf')
saveas(gcf,'result.fig','fig')
end