str='abda'; % �����������
disp(['The inputs are: ',num2str(str)]);
alph='abcd'; % ���������ĸ��
counts=[4 2 1 1]; % ��������ų��ֵĴ���
L_temp=1;counts_sum=sum(counts);
for i=1:length(str)
   L_temp=L_temp*counts(find(str(i)==alph))/counts_sum;
end
L=ceil(-log2(L_temp)); % ����������ֳ���
%%%%%%%%%%%%%%%%����%%%%%%%%%%%%%%%%%%
seq=double(str)-min(double(str))+1;
codes=arithenco(seq,counts); %��������
codes=codes(1:L);
disp(['The codes are: ',num2str(codes)]); % ���������
%%%%%%%%%%%%%%%%����%%%%%%%%%%%%%%%%%%
LEN=length(str); % �������г���
dseq=arithdeco(codes,counts,LEN); % ��������
decodes=char(dseq+min(double(str))-1);
disp(['The decodes are: ',decodes]); % �����������