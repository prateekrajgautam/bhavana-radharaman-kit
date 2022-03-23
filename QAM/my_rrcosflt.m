function y = my_rrcosflt(x, fd, fs, beta, delay, fsflag)
% MY_RRCOSFLT Filter the input signal using a root raised cosine filter.
%    Y = MY_RRCOSFLT(X, Fd, Fs, BETA, DELAY) filters the input signal X
%    using a root raised cosine FIR filter. The sample frequency for the
%    input, X, is Fd (Hz). The sample frequency for the output, Y, is
%    Fs (Hz). Fs must be an integer multiple of Fd. The rolloff factor BETA
%    determines the width of the transition band of the filter. DELAY is
%    the time delay from the beginning of the filter to the peak of the
%    impulse response, expressed as the number of input sample periods,
%    i.e., the delay in seconds is DELAY/Fd. 
%
%    BETA, the rolloff factor, specifies the excess bandwidth of the
%    filter. BETA must be in the range [0,1]. For example, BETA = .5 means
%    that the bandwidth of the filter is 1.5 times the input sampling
%    frequency, Fd. This also means that the transition band of the filter
%    extends from .5 * Fd to 1.5 * Fd. Typical values for BETA are between
%    0.2 to 0.5. 
%
%    DELAY determines the length of the filter impulse response used to
%    filter X. This length is Fs/Fd * (2 * DELAY) + 1. 
%
%    Y is the output of the upsamled, filtered input stream X. The length
%    of the vector Y is
%        Fs/Fd * (length(X) + 2 * DELAY).
%
%    Y = MY_RRCOSFLT(X, Fd, Fs, BETA, DELAY, 'Fs') assumes that the input
%    signal X is already at sampling frequency Fs.  
%
%    The input X can be a row or a column vector, the output Y is always a
%    column vector. 

%santosh shah, The LNM IIT Jaipur (India)(santosh.jnt@gmail.com) 25/04/07

% Check arguments
if (fs / fd ~= floor(fs/fd))
    error('Fs/Fd must be an integer.');
else
    upfactor = fs / fd;
end

if beta < 0 || beta > 1
    error('The rolloff factor BETA must be in the range [0,1].');
end

if (delay < 0) || delay ~= floor(delay)
    error('DELAY must be a positive integer.');
end

if nargin >= 6
    if strcmpi(fsflag, 'Fs')
        fsflag = true;
    else
        error('Invalid value for FSFLAG');
    end
else
    fsflag = false;
end

% Upsample input signal unless fsflag is set
if fsflag
    xup = x;
else
    xup = upsample(x, upfactor);
end

% Create the filter
f = my_rrc(fd, fs, beta, delay);

% Filter the input signal and convert to column vector
y = conv(xup, f);
y = y(:);

end



function f = my_rrc(fd, fs, beta, delay)
% MY_RRC Produces the impulse response of a root raised cosine filter
%    F = MY_RRC(Fd, Fs, BETA, DELAY) is the impulse response of a root
%    raised cosine FIR filter with rolloff factor BETA and delay DELAY. 

BETA = beta;
DELAY = delay;
FD = fd;
FS = fs;

% time vector
Td = 1/FD;

% Length of actual filter coefficients (rest is zero)
rrclen = FS/FD * DELAY * 2 + 1;

% Create vector of time instants (make it a column vector to behave as the
% MATLAB function rcosflt)
t = linspace(-DELAY*Td, DELAY*Td, rrclen)';

rrc_num = 4*BETA / (pi*sqrt(Td)) * ...
    (cos((1+BETA)*pi*t/Td) + (1-BETA)*pi/(4*BETA) * ...
    sinc((1 - BETA)*t/Td));

rrc_denom = (1 - (4*BETA * t/Td).^2);
rrc = rrc_num ./ rrc_denom;

% Determine if there is a singularity (at positions t = +/- 1/(4*BETA))
% The value at these points can be obtained by the De l'Hopital rule.
ind = find(abs(t) == Td/(4*BETA));
if ~isempty(ind)
    rrc(ind) = 4*BETA / (pi * sqrt(Td)) * ...
        ( (-2 + pi)*cos(pi / (4*BETA)) + ...
        (2+pi) * sin(pi / (4*BETA))) / (4*sqrt(2));
end

% Normalize
f = rrc / sqrt(FS);

end
