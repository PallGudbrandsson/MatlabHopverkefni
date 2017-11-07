function [yfilt]=filtering_data(x,W,Fs)
W=W/(Fs/2);

%Define a bandwidth filter
[bxy,cxy] = butter(4,W,'stop');

yfilt=filter(bxy,cxy,x);