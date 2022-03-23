function[out,out1]=kmuchannel(data,k)
% clc
% clear all
% % close all
% % data=randi([0,1],1,100);
% % k=.4; %assumed >=0

r=data;
rcap=rms(r.*r);
rho=r/rcap;
rvar=var(r.*r);


mu=(square(rcap)/rvar)*(((1+2*k))/(1+k)^2);%mu>=0
iv=1;%modified bressel fn of first kind
for i=1:length(rho)
    iv=besseli(real(mu)-1,(2*mu*(k*(1+k))^(1/2)*rho(1,i)));
%     prho(1,i)=( (2*mu*(1+k)^((mu+1)/2))/((k^((mu-1)/2)*exp(k*mu))) )*(rho(1,i)^mu*exp(-mu*(1+k)*(rho(1,i))^2)*iv*(2*mu*(k*(1+k))^(1/2)*rho(1,i)))
    prho(1,i)=( (2*mu*(1+k)^((mu+1)/2))/((k^((mu-1)/2)*exp(k*mu))) )*(rho(1,i)^mu*exp(-mu*(1+k)*(rho(1,i))^2)*iv);
end
prho;
prho1=prho.*randi([1,10],1,length(prho))/10;
out=prho;
out1=prho1;
% prho1db=20*log(prho1)
% prhodb=20*log(prho)
