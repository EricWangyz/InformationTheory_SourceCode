M=2; 
corr=1; 
value=0.5; 
XPD=1; 
alpha=0.5; 
output = 'erg'; 
%vary SNR through 20 dB 
SNR=0:1:20;%SNR is signal-to-noise ratio in dBs 
temp2=[]; 
temp3=[];
for i=1:length(SNR) 
    temp1(i)=exp3_17_1(SNR(i),M,corr,value,XPD,alpha,output);
    temp2=[temp2 temp1(i)]; 
    temp1(i)=exp3_17_2(SNR(i),M);   
    temp3=[temp3 temp1(i)];
    temp1(i)=0; 
end 
plot(SNR,temp2,'b-^'); 
hold on
plot(SNR,temp3,'r-^');
grid; 
xlabel('SNR'); 
ylabel('Capacity (Bits/sec)'); 
title('Ergodic Capacity Variation with SNR for Corr = 0-5 and XPD = 0-5'); 