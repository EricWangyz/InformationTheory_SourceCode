symbols=[1:7]; % 输入符号字母表                               
prob=[0.2 0.19 0.18 0.17 0.15 0.1 0.01]; % 输入各符号出现的概率
[dict,avglen] = huffmandict(symbols,prob); % 计算哈夫曼编码字典
disp(['Binary Huffman code dictionary: ']); % 显示哈夫曼编码字典
for i=1:length(symbols)
disp(['x',num2str(dict{i,1}),':  ',num2str(dict{i,2})]);
end
disp(['Average codeword length: ',num2str(avglen)]); % 显示哈夫曼编码平均码长