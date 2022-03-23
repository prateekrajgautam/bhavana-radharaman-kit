function b= my_de2bi(d, msbflag, n)

%This is the function to convert decimal to binary. here b is the binary
%output where non-negative decimal vector d is the input data. Each row of
%the binary matrix b is corresponds to the one element of d. The first
%element in the row of b signifies LSB. If d is the matrix rather than row
%and coulmn vector then, convert to coulmn vector. 

% here two optional parameter i am using msbflag and n. msbflag determines
% the output orientation, it has two possible values right_msb and
% left_msb. if the left_msb id given then the orientation of the bits are
% just flip i.e. display the msb to the left and right_msb is for the default.
% n defines how many digits(coulmn) are output.

%santosh shah, The LNM IIT Jaipur (India)(santosh.jnt@gmail.com) 23/04/07

%process for decibel to binary conversion

if nargin < 2
    msbflag = 'right_msb'; 
end % by default msb bit is at the right side

% Convert d to column if necessary
d = d(:);

% Find minimum number of digits needed to represent the input. If n is
% specified, use it but only if its >= the required minimum; otherwise
% raise an error. 
nmax = ceil(log2(max(d)));
if (nargin < 3)
    n = nmax;
elseif n < nmax
    error('Specified number of columns in output matrix is too small.');
end

%checking wheter d is integer or not.
if ~all(d == floor(d))
    error('messege data should be a +ve integer.');
end

%allocating space for output data
b = zeros(length(d),n) ;

% Convert to binary. Loop over the entries of d, and for each entry, first
% get the lsb, and then keep right shifting by dividing by 2 until the
% number is zero.
for k = 1:length(d)
    x = d(k);
    l = 1;      % Indicates the bit we are currently looking at
    
    while x > 0
        
        % Extract lsb, shift x to the right and update index
        b(k, l) = bitand(x, 1);
        x = floor(x / 2);
        l = l + 1;
    end
end


%checking the condition of msbflags 
switch(msbflag)
    case 'left_msb'
        b = fliplr(b);
    case 'right_msb'
        %leave as same
    otherwise
        error('Invalid value of MSBFLAG');
end


