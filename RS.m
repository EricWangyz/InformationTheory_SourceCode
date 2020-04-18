M=8;           % 调制阶数
bps=log2(M);    % 每个符号所含比特数
N=7;           % RS码长
K=3;           % RS信息位长度
mod=comm.PSKModulator('ModulationOrder',M,'BitInput',false); 
% 创建调制器(8PSK调制方式)
demod=comm.PSKDemodulator('ModulationOrder',M,'BitOutput',false); 
% 创建解调器
chan=comm.AWGNChannel('BitsPerSymbol',bps); % 创建AWGN信道
err=comm.ErrorRate; 
enc=comm.RSEncoder('BitInput',false,'CodewordLength',N,'MessageLength',K); 
% 创建编码器
dec=comm.RSDecoder('BitInput',false,'CodewordLength',N,'MessageLength',K); 
% 创建译码器
ebnoVec = (3:0.5:8)'; % 信噪比
errorStats = zeros(length(ebnoVec),3);
for n=1:length(ebnoVec)
  chan.EbNo=ebnoVec(n);
  reset(err)
  while errorStats(n,2) < 100 && errorStats(n,3) < 1e7
      data = randi([0 2],1500,1);             % 生成随机数据
      encData = step(enc,data);              % RS编码
      modData = step(mod,encData);         % 调制
      rxSig = step(chan,modData);           % 通过AWGN信道
      rxData = step(demod,rxSig);           % 解调
      decData = step(dec,rxData);            % RS译码
      errorStats(n,:) = step(err,data,decData);   % 错误统计
  end
end
berCurveFit = berfit(ebnoVec,errorStats(:,1)); % 曲线拟合
berNoCoding = berawgn(ebnoVec,'psk',8,'nondiff'); % 未编码
semilogy(ebnoVec,errorStats(:,1),'b*',ebnoVec,berCurveFit,'c-',ebnoVec,berNoCoding,'r')
ylabel('错误率')
xlabel('Eb/No (dB)')
legend('RS编码的仿真数据','拟合曲线','未编码')
grid