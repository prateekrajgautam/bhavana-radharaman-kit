%main
clc
clear all
close all
data=randi([0,1],1,10);
k=.7; %assumed >=0
[out,out1]=kmuchannel(data,k)%call kmu channel with data and suitable value of k
