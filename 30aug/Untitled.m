clear all
close all
load t1
a=ofdmsignal';
chdata=kmuchannel(a(1,2:10),kappa);
scatterplot(a(1,1:10));
scatterplot(chdata);
r=ofdmsignal;
rcap=rms(r);
rho=(max(r/rcap));
rvar=var(r);
% rvar=var(r.*r);
mu=(rcap^2/rvar)*(((1+2*k))/(1+k)^2);%mu>=0
iv=1;%modified bressel fn of first kind
ii=1;
% rho=max
% for ii=1:length(rho)
    a=rho(1,ii);
    iv=besseli((real(mu)-1),(2*mu*(k*(1+k))^.5*a));
    a1=2*mu*(1+k);
    a2=(mu+1)/2;
    a3=(k^((mu-1)/2)*exp(k*mu));
    out1=r*0.8;
    out=out1;
    a4=a^(mu);
    a5=exp((mu*(1+k)*(rho(1,ii))^2)*iv)^-1;
%     ((a1^a2)/a3)
    prho(1,ii)=((a1^a2)/a3)*(a4)*(a5);
    
% end
% out=prho;
end