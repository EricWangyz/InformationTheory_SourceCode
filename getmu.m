
function mu=getmu(r,snr,H,p,M) 
 
eigen=eig(H*H'); 
 
temp2=0; 
for i=1:r-p+1 
    temp1=1/eigen(i); 
    temp2=temp2+temp1; 
    temp1=0; 
end 
if r-p+1~=0 
mu=(M/(r-p+1))*(1+(1/snr)*temp2); 
else  
mu=0; 
end 

end

