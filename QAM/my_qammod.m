function y = my_qammod(x, m)

%here y is the QAM modulated output in vector form like x+jy, x is the
%input vector which is in the range of 0 to M-1, where M is the type of M-QAM
%which is proportional to the power of 2 (2 =2^1, 4 =2^2, 8 = 2^3..)

%santosh shah, The LNM IIT Jaipur (India)(santosh.jnt@gmail.com) 23/04/07

%i have to check if M is equal to the power of 2 and x is in between 0 to
%M-1 so..
if log2(sqrt(m))~= floor(log2(sqrt(m)))
    error('Please check the value of m that you have provided for type M-QAM.');
end

% i need to remove (x == floor(x)), if we want the value of x is in between anywhere 0 to M-1
if ~all(x >= 0 & x < m & x == floor(x))
    error('Please check the messege vector it must be in between 0 to M-1.');
end

%now generating the cancellation points

k = sqrt(m);
r = 2*(0:k-1) - k + 1;
[xi, yi] = meshgrid(r);
c = xi + j*flipud(yi);

% now calling the corresponding element from vector c as x.
y = c(x+1);


