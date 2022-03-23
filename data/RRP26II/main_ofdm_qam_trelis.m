%main ofdm with qam and trelis error detection/correcton
close all
clear all
clc
global plotmodulateddata
plotmodulateddata=0; % set it 1 to display scattered plot it will slow execution
kmuuse=0;
datalen=9600;
t_data=randi([0,1],1,datalen);
x=1;
si=1; %for BER rows
dmax=100;
step=datalen/dmax;
for d=1:dmax
    data=t_data((d-1)*step+1:d*step);
    
    %% transmitter
    
    x=x+96;k=3;n=6;s1=step;%size(data,2);  % Size of input matrix
    j=s1/k;
    [codedata,trellis]=convencoder(data);%trellis encoder
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
        snr1
        if kmuuse==1
            kappa=.5;
            chdata=kmuchannel(ofdmsignal,kappa);
        end       
        
        %% reciever

        [rxd]=removecp(chdata);% remove cyclic prefix
        ffsignal=fft(rxd,64); % fft
        syncheddata=synchpilot(ffsignal);% synch data stream using pilot 
        rx1=demodulate16am(syncheddata); % qam demod
        rx2=deinterleav(rx1); %deinterleaved
        recieveddata=viterbidecoder(rx2,trellis); %correct error using viterbi decoding based on convoulational encoder
        
        %% compare 
        [ber1,err1]=finderror(data,recieveddata);
        BER(d,o)=ber1;
        o=o+1;
    end
    
end

plotresult(BER,snr)


