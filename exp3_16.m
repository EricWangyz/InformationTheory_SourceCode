function exp3_16(P, e)
n=0;
C=0;
C_0=0;
C_1=0;
[r,s]=size(P);
for i=1:r    
    if(sum(P(i,:))~=1)%检测概率转移矩阵是否行和为1-        
        error('概率转移矩阵输入有误！！')        
        return;        
    end    
    for j=1:s        
        if(P(i,j)<0||P(i,j)>1)%检测概率转移矩阵是否负值或大于1            
            error('概率转移矩阵输入有误！！')            
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
    if (abs(C_0-C_1)<e) %满足迭代终止条件停止迭代        
        C=C_0;        
        fprintf('迭代次数: n=%d\n',n)        
        fprintf('信道容量: C=%f比特/符号\n',C)        
        break; %满足后输出结果并退出        
    else        
        X=(X.*A)/(X*A');        
        continue;       
    end    
end