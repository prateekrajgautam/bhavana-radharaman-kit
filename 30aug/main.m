%main ofdm with qam and trelis error detection/correcton
close all
clear all
clc
global plotmodulateddata
plotmodulateddata=0; % set it 1 to display scattered plot it will slow execution
kmuuse=1;
datalen=9600;
t_data=randi([0,1],1,datalen);
x=1;
si=1; %for BER rows
dmax=100;
step=datalen/dmax;
lno=1;

for kmuuse=[0,1]%=[0,1]0 to ignore kmu fading 1 to account kmu  fading
for xx=[1,2]%=[1,2] 1 for trellis 2 for without trellis
    
    
    
for d=1:dmax
    data=t_data((d-1)*step+1:d*step);
    
    %% transmitter
    
    x=x+96;k=3;n=6;s1=step;%size(data,2);  % Size of input matrix
    j=s1/k;
    if xx==2
        codedata=[data,zeros(1,96)];
    end
    if xx==1
        [codedata,trellis]=convencoder(data);%trellis encoder
    end
    interleaveddata=interleaver(codedata);%interleaver
    qamdata=qam16mod(interleaveddata);% modulate data to 16qam and show plot
    datawithpilot=addpilot(qamdata); % add pilot used for synch
    ifftdata=ifft(datawithpilot',64); %ifft
    dataifftwithcp=addcp(ifftdata); % add cyclic prefix
    txd=dataifftwithcp;
    
    %% channel
    
    o=1;
    for snr1=0:2:50
        snr(1,o)=snr1;
        
        ofdmsignal=awgn(txd,snr1,'measured'); % Adding white Gaussian Noise
        
        if kmuuse==0
            chdata=ofdmsignal;
        end
        if kmuuse==1
            kappa=.58;
            save t1
            chdata=kmuchannel(ofdmsignal',kappa);
        end       
        
        %% reciever

        [rxd]=removecp(chdata);% remove cyclic prefix
        ffsignal=fft(rxd,64); % fft
        syncheddata=synchpilot(ffsignal);% synch data stream using pilot 
        rx1=demodulate16am(syncheddata); % qam demod
        rx2=deinterleav(rx1); %deinterleaved
        if xx==2
            recieveddata=rx2(1,1:96);
        end
        if xx==1
            recieveddata=viterbidecoder(rx2,trellis); %correct error using viterbi decoding based on convoulational encoder
        end
        
        %% compare 
        [ber1,err1]=finderror(data,recieveddata);
        BER(d,o)=ber1;
        o=o+1;
    end
    
end
if xx==2
    lname{lno}=['ofdm 16qam without trellis'];
end
if xx==1
    lname{lno}=['ofdm 16qam with trellis'];
end
ber11(lno,:)=sum(BER);
if kmuuse==0
    lname{lno}=[lname{lno},' without KMU'];
end
if kmuuse==1
    lname{lno}=[lname{lno},' with KMU'];
end
lno=lno+1;
end
end
plotresult(ber11,snr,lname)
hold on

