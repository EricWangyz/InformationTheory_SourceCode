M=16; % 调制阶数
EbNo=-5:-1; % 信噪比范围
frmLen=500; % 帧长
ber=zeros(size(EbNo));
enc=comm.TurboEncoder('InterleaverIndicesSource','Input port'); % 创建编码器
dec=comm.TurboDecoder('InterleaverIndicesSource','Input port', ...
  'NumIterations',4); % 创建译码器
mod=comm.RectangularQAMModulator('ModulationOrder',M, ...
  'BitInput',true,'NormalizationMethod','Average power'); % 创建QAM调制器
demod=comm.RectangularQAMDemodulator('ModulationOrder',M, ...
  'BitOutput',true,'NormalizationMethod','Average power', ...
  'DecisionMethod','Log-likelihood ratio', ...
  'VarianceSource','Input port'); % 创建QAM译制器
chan=comm.AWGNChannel('EbNo',EbNo,'BitsPerSymbol',log2(M)); 
% 创建AWGN信道
errorRate = comm.ErrorRate;
for k = 1:length(EbNo)
  errorStats = zeros(1,3); 
  noiseVar = 10^(-EbNo(k)/10)*(1/log2(M));
  chan.EbNo = EbNo(k);
  while errorStats(2) < 100 && errorStats(3) < 1e7
      data = randi([0 1],frmLen,1); % 创建二进制随机数据
      intrlvrInd = randperm(frmLen); % 交织
      encodedData = step(enc,data,intrlvrInd); % Turbo编码
      modSignal = step(mod,encodedData); % 调制
      receivedSignal = step(chan,modSignal); % AWGN信道
      demodSignal = step(demod,receivedSignal,noiseVar); % 解调
      receivedBits = step(dec,-demodSignal,intrlvrInd); % 译码
      errorStats = step(errorRate,data,receivedBits); % 统计差错
  end
  ber(k) = errorStats(1);
  reset(errorRate)
end
semilogy(EbNo,ber,'r-o')
grid
xlabel('Eb/No (dB)')
ylabel('误比特率')
uncodedBER = berawgn(EbNo,'qam',M); % 未编码的BER
hold on
semilogy(EbNo,uncodedBER,'b-')
legend('Turbo编码','未编码')