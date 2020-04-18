function output=exp3_17_2(SNR,M) 
% SNR is signal-to-noise ratio 
% M -> number of antennas for a M x M system 
% output -> the ergodic capacity in case this program is required to work 
snr=10^(0.1*SNR); 
for K=1:10000 
      T=randn(M,M)+j*randn(M,M); 
      T=0.707.*T; 
         I=eye(M); 
         eigen=eig(T*T'); %extract eigenvalues 
         gamma=zeros(M,1); 
         r=M;%set rank = number of antennas (full rank) 
         p=1;%initial count 
     for i=1:r 
         mu=getmu(r,SNR,T,p,M);%determine mu value (see eqn- (1-30)) 
         gamma(i)=mu-(M/snr)*(1/eigen(i)); %calculate gamma 
         if gamma(i)<0 
             gamma(i)=0;% if gamma < 0, set it to zero i-e- discard it 
             p=p+1;% increment count 
             mu=0;%clear register 
         else 
            mu=0; % if gamma >0 store it and clear register 
         end 
    end 
%solve eqn (1-26)using the determinant form 
    a=I+(snr/M)*diag(gamma).*diag(eigen); 
     a=det(a); 
     y(K)=log2(a);    
end 
    [n1 x1]=hist(y,40); 
    n1_N=n1/max(K); 
    a=cumsum(n1_N); 
    b=abs(x1); 
output=interp1q(a,b',0.5);     
end