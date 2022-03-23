function[r]=viterbidecoder(rx2,trellis)
%[r]=viterbidecoder(rx2)
    n=6;
    k=3;
    decodedata =vitdec(rx2,trellis,5,'trunc','hard'); 
    r=decodedata;
end