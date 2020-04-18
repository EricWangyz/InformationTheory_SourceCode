M=8;           % ���ƽ���
bps=log2(M);    % ÿ����������������
N=7;           % RS�볤
K=3;           % RS��Ϣλ����
mod=comm.PSKModulator('ModulationOrder',M,'BitInput',false); 
% ����������(8PSK���Ʒ�ʽ)
demod=comm.PSKDemodulator('ModulationOrder',M,'BitOutput',false); 
% ���������
chan=comm.AWGNChannel('BitsPerSymbol',bps); % ����AWGN�ŵ�
err=comm.ErrorRate; 
enc=comm.RSEncoder('BitInput',false,'CodewordLength',N,'MessageLength',K); 
% ����������
dec=comm.RSDecoder('BitInput',false,'CodewordLength',N,'MessageLength',K); 
% ����������
ebnoVec = (3:0.5:8)'; % �����
errorStats = zeros(length(ebnoVec),3);
for n=1:length(ebnoVec)
  chan.EbNo=ebnoVec(n);
  reset(err)
  while errorStats(n,2) < 100 && errorStats(n,3) < 1e7
      data = randi([0 2],1500,1);             % �����������
      encData = step(enc,data);              % RS����
      modData = step(mod,encData);         % ����
      rxSig = step(chan,modData);           % ͨ��AWGN�ŵ�
      rxData = step(demod,rxSig);           % ���
      decData = step(dec,rxData);            % RS����
      errorStats(n,:) = step(err,data,decData);   % ����ͳ��
  end
end
berCurveFit = berfit(ebnoVec,errorStats(:,1)); % �������
berNoCoding = berawgn(ebnoVec,'psk',8,'nondiff'); % δ����
semilogy(ebnoVec,errorStats(:,1),'b*',ebnoVec,berCurveFit,'c-',ebnoVec,berNoCoding,'r')
ylabel('������')
xlabel('Eb/No (dB)')
legend('RS����ķ�������','�������','δ����')
grid