H=0; %����ֵ
e=0:0.01:1; %���ñ���p��ֵ��������С
H=-e.*log2(e)-(1-e).*log2(1-e);%���㹫ʽ
plot(e,H,'--rs'); %ͼ��ʾ
title('Entropy');
xlabel('the probability e');
ylabel('the entropy H');