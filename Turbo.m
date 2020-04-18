M=16; % ���ƽ���
EbNo=-5:-1; % ����ȷ�Χ
frmLen=500; % ֡��
ber=zeros(size(EbNo));
enc=comm.TurboEncoder('InterleaverIndicesSource','Input port'); % ����������
dec=comm.TurboDecoder('InterleaverIndicesSource','Input port', ...
  'NumIterations',4); % ����������
mod=comm.RectangularQAMModulator('ModulationOrder',M, ...
  'BitInput',true,'NormalizationMethod','Average power'); % ����QAM������
demod=comm.RectangularQAMDemodulator('ModulationOrder',M, ...
  'BitOutput',true,'NormalizationMethod','Average power', ...
  'DecisionMethod','Log-likelihood ratio', ...
  'VarianceSource','Input port'); % ����QAM������
chan=comm.AWGNChannel('EbNo',EbNo,'BitsPerSymbol',log2(M)); 
% ����AWGN�ŵ�
errorRate = comm.ErrorRate;
for k = 1:length(EbNo)
  errorStats = zeros(1,3); 
  noiseVar = 10^(-EbNo(k)/10)*(1/log2(M));
  chan.EbNo = EbNo(k);
  while errorStats(2) < 100 && errorStats(3) < 1e7
      data = randi([0 1],frmLen,1); % �����������������
      intrlvrInd = randperm(frmLen); % ��֯
      encodedData = step(enc,data,intrlvrInd); % Turbo����
      modSignal = step(mod,encodedData); % ����
      receivedSignal = step(chan,modSignal); % AWGN�ŵ�
      demodSignal = step(demod,receivedSignal,noiseVar); % ���
      receivedBits = step(dec,-demodSignal,intrlvrInd); % ����
      errorStats = step(errorRate,data,receivedBits); % ͳ�Ʋ��
  end
  ber(k) = errorStats(1);
  reset(errorRate)
end
semilogy(EbNo,ber,'r-o')
grid
xlabel('Eb/No (dB)')
ylabel('�������')
uncodedBER = berawgn(EbNo,'qam',M); % δ�����BER
hold on
semilogy(EbNo,uncodedBER,'b-')
legend('Turbo����','δ����')