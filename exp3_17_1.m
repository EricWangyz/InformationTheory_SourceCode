function output=exp3_17_1(SNR,M,corr,value,XPD,alpha,output) 
%SNR is signal-to-noise ratio in dBs 
%M -> number of antennas (M x M) system 
%corr -> 1 if with correlation, 0 if uncorrelated (for a 2x2 system only) 
%value -> correlation coefficient value from 0 ->1 
%XPD -> 1 if antenna XPD is to be investigated, 0 if not (for a 2x2 system 
%only) 
%alpha -> XPD value 
%output -> defined by 'erg' and 'out' for ergodic capacity or outage 
%capacity respectively 
SNR=10^(0.1*SNR); 
%10000 Monte-Carlo runs 
for K=1:10000 
   T=randn(M,M)+j*randn(M,M); 
   T=0.707*T; 
  if corr 
      T=[1 value;value 1]; 
      T=chol(T); 
  elseif XPD 
      T=[1 alpha;alpha 1]; 
      T=chol(T); 
  end 
   I=eye(M); 
   a=(I+(SNR/M)*T*T'); 
   a=det(a); 
   y(K)=log2(a);     
end 
[n1 x1]=hist(y,40) 
n1_N=n1/max(K); 
a=cumsum(n1_N); 
b=abs(x1); 
if output == 'erg' 
    output=interp1q(a,b',0.5);   %ergodic capacity 
elseif output == 'out' 
    output=interp1q(a,b',0.1);   %outage capacity  
end  
end
