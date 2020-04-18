C=0;
p=0:0.01:1;
C=1-[-p.*log2(p)-(1-p).*log2(1-p)];
plot(p,C,'--rs'); 
title('Capacity');
xlabel('the error probability p');
ylabel('the Capacity C');