function f = my_rrc(fd, fs, beta, delay)
% MY_RRC Produces the impulse response of a root raised cosine filter
%    F = MY_RRC(Fd, Fs, BETA, DELAY) is the impulse response of a root
%    raised cosine FIR filter with rolloff factor BETA and delay DELAY. 

% $Id: my_rrc.m 457 2006-11-09 08:29:13Z kleiner $

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
