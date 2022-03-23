function[bin]=demodulate16am(syncheddata)
    dem_data= qamdemod(syncheddata,16);
    bin=de2bi(dem_data','left-msb');
    bin=bin';
end