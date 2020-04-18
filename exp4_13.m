symbols=[1:7]; % ���������ĸ��                               
prob=[0.2 0.19 0.18 0.17 0.15 0.1 0.01]; % ��������ų��ֵĸ���
[dict,avglen] = huffmandict(symbols,prob); % ��������������ֵ�
disp(['Binary Huffman code dictionary: ']); % ��ʾ�����������ֵ�
for i=1:length(symbols)
disp(['x',num2str(dict{i,1}),':  ',num2str(dict{i,2})]);
end
disp(['Average codeword length: ',num2str(avglen)]); % ��ʾ����������ƽ���볤