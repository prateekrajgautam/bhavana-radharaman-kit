function d = my_bi2de(b, msbflag)

%now i need to convert bit vector into decimal numbers. so my_bi2de is the
%function for that, d is the output decimal number, b is the binary vector,
%and msbflag is unlike my_de2bi function to check the msb position.

%santosh shah, The LNM IIT Jaipur (India)(santosh.jnt@gmail.com) 23/04/07

if nargin < 2 % by default msb bit is at the right side
    msbflag = 'right_msb'; 
end 

%checking the matrix containt wheter it has 1's or 0's or not.
if ~all(all(b==1 | b==0))
    error('matrix containt can not be other than 1 and 0');
end
    
%now i am going to check the matrix dimention

[nrow ncol] = size(b);
%computing decimal number
[nrows ncols] = size(b);
d = zeros(nrows, 1);
power_two = 2 .^ [0:ncols-1]; % computing in the form [1 2 4 8]

%checking the condition of msbflags 
switch(msbflag)
    case 'left_msb'
        b = fliplr(b);
    case 'right_msb'
        %leave as same
    otherwise
        error('Invalid value of MSBFLAG');
end
d = b * power_two';    

