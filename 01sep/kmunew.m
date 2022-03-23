function[out,pa]=kmunew(data,k,mu)
if nargin<2
    k=.5;
end

d1=real(data);
r=d1;
rcap=rms(r);


rho=(max(r/rcap));
rvar=var(r);
if nargin<3
    mu=(rcap^2/rvar)*(((1+2*k))/(1+k)^2)%mu>=0
end
    a=rho;
iv=besseli((real(mu)-1),(2*mu*(k*(1+k))^.5*a));
iv=1;%modified bressel fn of first kind asswmed 1
ii=1;


    a1=2*mu*(1+k);
    a2=(mu+1)/2;
    a3=(k^((mu-1)/2)*exp(k*mu));
    out1=r.*k;
    out=out1';
    a4=a^(mu);
    a5=exp((mu*(1+k)*(a)^2)*iv)^-1;
    pa=((a1^a2)/a3)*(a4)*(a5);
    out=data'.*pa;
end