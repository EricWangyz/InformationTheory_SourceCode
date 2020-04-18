function exp3_16(P, e)
n=0;
C=0;
C_0=0;
C_1=0;
[r,s]=size(P);
for i=1:r    
    if(sum(P(i,:))~=1)%������ת�ƾ����Ƿ��к�Ϊ1-        
        error('����ת�ƾ����������󣡣�')        
        return;        
    end    
    for j=1:s        
        if(P(i,j)<0||P(i,j)>1)%������ת�ƾ����Ƿ�ֵ�����1            
            error('����ת�ƾ����������󣡣�')            
            return;            
        end        
    end    
end
X=ones(1,r)/r;
A=zeros(1,r);
B=zeros(r,s);
while(1)    
    n=n+1;    
    for i=1:r        
        for j=1:s            
            B(i,j)=log(P(i,j)/(X*P(:,j))+eps);            
        end        
        A(1,i)=exp(P(i,:)*B(i,:)');        
    end    
    C_0=log2(X*A');    
    C_1=log2(max(A));    
    if (abs(C_0-C_1)<e) %���������ֹ����ֹͣ����        
        C=C_0;        
        fprintf('��������: n=%d\n',n)        
        fprintf('�ŵ�����: C=%f����/����\n',C)        
        break; %��������������˳�        
    else        
        X=(X.*A)/(X*A');        
        continue;       
    end    
end