H=0; %赋初值
e=0:0.01:1; %设置变量p初值和增量大小
H=-e.*log2(e)-(1-e).*log2(1-e);%计算公式
plot(e,H,'--rs'); %图显示
title('Entropy');
xlabel('the probability e');
ylabel('the entropy H');