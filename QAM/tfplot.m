function tfplot(s, fs, name, plottitle)
% TFPLOT Time and frequency plot
%    TFPLOT(S, FS, NAME, TITLE) displays a figure window with two subplots.
%    Above, the signal S is plotted in time domain; below, the signal is plotted
%    in frequency domain. NAME is the "name" of the signal, e.g., if NAME is
%    's', then the labels on the y-axes will be 's(t)' and '|s_F(f)|',
%    respectively.  TITLE is the title that will appear above the two plots. 
%santosh shah, The LNM IIT Jaipur (India)(santosh.jnt@gmail.com) 20/04/07

% Compute the time and frequency scales
t = linspace(0, (length(s)-1) / fs, length(s));
f = linspace(-fs/2, fs/2, length(s));

% compute the FFT
s_f = fft(s);

figure;
% First plot: time
subplot(2,1,1); plot(t, s);
xlabel('t [s]'); ylabel(sprintf('%s(t)', name));
title(plottitle);

% Second plot: frequency
% We use fftshift to move the coefficients for negative frequencies to the left
subplot(2,1,2); plot(f, fftshift(abs(s_f)));
xlabel('f [Hz]'); ylabel(sprintf('|%s_F(f)|', name));
