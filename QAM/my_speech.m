function my_speech(M, type_of_mod, fc, fs)

% here i am going to test my speech through various QAM, and PSK mod-demod
% techniques

%santosh shah, The LNM IIT Jaipur (India)(santosh.jnt@gmail.com) 25/04/07

if nargin < 4
    fs = 128e3 ; % default value of sampling frequency 100kHz
end
if nargin < 3
    fc = 20e3; % default value of carrier frequency
end

Down_samp = 2; 
test_data = 'E:\MATLAB\SDR_course\November7\my_speech.wav';
siz = wavread(test_data, 'size');
[data, fcar] = wavread(test_data);
x = [data]' ; % coulnm to row vector conversion
sound(x, fcar);
tfplot(x, fs,' Voice', 'speech signal');
s_data = round((M-1)/2*(x + 1)) ;

%converting this decimal data into binary data
%b= my_de2bi(s_data1, 'right_msb',4);
%s_data= my_bi2de(b,'right_msb');

%============================MODULATION===============================
if (type_of_mod == 'qam')
y1 = my_qammod(s_data, M) ;
elseif (type_of_mod == 'psk')
    y1 = my_pskmod(s_data, M) ;
end

%tfplot(y, fs,' Voice', 'modulated signal');

%==================CHANNEL==========================================

y = awgn(y1,20);


%==================DEMODULATION===================================
if (type_of_mod == 'qam')
z = my_qamdemod(y, M);
elseif (type_of_mod == 'psk')
    z = my_pskdemod(y, M);
end
z1 = (z - (M-1)/2) / M ; 
%filtering................
orig_sp = my_rrcosflt(z1, fcar, fs, .22, 3, 'fs');
sound(orig_sp, fcar);

%==================SCATTER PLOT===================================
scale = modnorm(y,'peakpow',1);
y = scale*y; % Scale the constellation.
scatterplot(y); % Plot the scaled constellation.
grid on;

tfplot(orig_sp, fs,' Voice', 'de-modulated signal');









