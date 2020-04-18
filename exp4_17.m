str='abda'; % 输入符号序列
disp(['The inputs are: ',num2str(str)]);
alph='abcd'; % 输入符号字母表
counts=[4 2 1 1]; % 输入各符号出现的次数
L_temp=1;counts_sum=sum(counts);
for i=1:length(str)
   L_temp=L_temp*counts(find(str(i)==alph))/counts_sum;
end
L=ceil(-log2(L_temp)); % 计算编码码字长度
%%%%%%%%%%%%%%%%编码%%%%%%%%%%%%%%%%%%
seq=double(str)-min(double(str))+1;
codes=arithenco(seq,counts); %算术编码
codes=codes(1:L);
disp(['The codes are: ',num2str(codes)]); % 输出的码字
%%%%%%%%%%%%%%%%译码%%%%%%%%%%%%%%%%%%
LEN=length(str); % 符号序列长度
dseq=arithdeco(codes,counts,LEN); % 算术译码
decodes=char(dseq+min(double(str))-1);
disp(['The decodes are: ',decodes]); % 输出的译码结果