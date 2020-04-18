function [R,delta]=d4_6_1(Pu,D,eps)
% Pu��Դ����ʸ����Dʧ���Ⱦ���rxs�ף���eps�Ǿ���
% ��ԴUr������Vs
[r,s]=size(D); 
delta_min=sum(Pu.*min(D')); %delta����Сֵ�����ֲ
delta_max=min(Pu*D);
R=[]; delta=[];%������ʼֵ��%P(u,v)=P(V|U)
P=ones(r,s)/s; %�ŵ�ģ��
SS=100:-0.1:-100; SS=-exp(SS);
for S=SS %��������
    Pv=Pu*P;  Ed0=sum(Pu*(P.*D));
    Rs0=0;
    for u=1:r
        for v=1:s
            if P(u,v)~=0 & Pu(u)~=0
                Rs0 = Rs0 + Pu(u)*P(u,v)*log2(P(u,v)/Pv(v));
            end
        end
    end
    P=exp(S*D);
    for i=1:s
        P(:,i)=P(:,i)*Pv(i);
    end
    for i=1:r
        SumP=sum(P(i,:));   P(i,:)=P(i,:)/SumP;
    end
    Km=50000;
    for k=1:Km
        Pv=Pu*P;
        Edn=sum(Pu*(P.*D));
        Rsn=0;
        for u=1:r
            for v=1:s
                if P(u,v)~=0 & Pu(u)~=0
                    Rsn = Rsn + Pu(u)*P(u,v)*log2(P(u,v)/Pv(v));
                end
            end
        end
        P=exp(S*D);
        for i=1:s P(:,i)=P(:,i)*Pv(i);         end
        for i=1:r
            SumP=sum(P(i,:));
            P(i,:)=P(i,:)/SumP;
        end
        if abs(Edn - Ed0)<eps & abs(Rsn - Rs0)<eps
            break;
        end
        Ed0=Edn;
        Rs0=Rsn;
    end
    if k<Km
        R=[R,Rsn];
        delta=[delta,Edn];
    end
end
