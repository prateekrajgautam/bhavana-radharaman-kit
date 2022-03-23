% editkmu

data=1:10
r=data
k=.01
rcap=rms(r.*r);
rho=r/rcap;
rvar=var(r.*r);
mu=(square(rcap)/rvar)*(((1+2*k))/(1+k)^2);%mu>=0
iv=1;%modified bressel fn of first kind
for ii=1:length(rho)
%     length(rho)
% rho
%     ii
    a=rho(1,ii);
    iv=besseli((real(mu)-1),(2*mu*(k*(1+k))^.5*a));
%     prho(1,i)=( (2*mu*(1+k)^((mu+1)/2))/((k^((mu-1)/2)*exp(k*mu))) )*(rho(1,i)^mu*exp(-mu*(1+k)*(rho(1,i))^2)*iv*(2*mu*(k*(1+k))^(1/2)*rho(1,i)))
    prho(1,ii)=( (2*mu*(1+k)^((mu+1)/2))/((k^((mu-1)/2)*exp(k*mu))) )*(rho(1,ii)^mu*exp(-mu*(1+k)*(rho(1,ii))^2)*iv);
end
prho;
prho1=prho.*randi([1,10],1,length(prho))/10;
out=data-prho
out1=prho1