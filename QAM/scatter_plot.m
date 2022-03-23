function scatter_plot(m, type_of_mod, fc, fs, d)

%this program is to test the QAM and PSK modulation and demodulation
%techniques, with csatter plot and input / output signals. here
%type_of_modulation may be QAM or PSK, m is the type of M. fc is carrier
%and fs is sampling frequency and, d is the signal duration.

%santosh shah, The LNM IIT Jaipur (India)(santosh.jnt@gmail.com) 25/04/07

%==================MODULATION========================================
if nargin < 5
    d = .01; % default for 0.1 second signal duration
end
if nargin < 4
    fs = 100e3 ; % default value of sampling frequency 100kHz
end
if nargin < 3
    fc = 500; % default value of carrier frequency
end

t= linspace(0, d, d*fs);

%signal selection for mod / demod.
xin = sin(2*pi*fc*t);
x= floor(m/2 + m/2*xin);
subplot(2, 1, 1);plot(t,xin), title('original signal');
grid on ;

if (type_of_mod == 'qam')
y = my_qammod(x, m) ;
elseif (type_of_mod == 'psk')
    y = my_pskmod(x, m) ;
end


%==================DEMODULATION===================================
if (type_of_mod == 'qam')
z = my_qamdemod(y, m);
elseif (type_of_mod == 'psk')
    z = my_pskdemod(y, m);
end

subplot(2, 1, 2);
plot(t, (2*z/m) ), title('Recovered signal');
grid on;

%==================SCATTER PLOT===================================
scale = modnorm(y,'peakpow',1);
y = scale*y; % Scale the constellation.
scatterplot(y); % Plot the scaled constellation.
grid on;


%tfplot(z, fs, 'Vin','modulated signal');



