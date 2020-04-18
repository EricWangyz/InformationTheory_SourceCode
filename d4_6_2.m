X=imread('lena512.bmp'); % 输入原始图片
[row,col]=size(X);
figure,imshow(X),title('原始图片')
para1=100; % 压缩图片质量
para2= 'lossy'; % 有损压缩
imwrite(X,'Compressed.jpg','JPEG','Quality',para1,'Mode',para2);
reX=imread('Compressed.jpg');
figure,imshow(reX),title('JPEG图片')
PSNR=10*log10(row*col*255^2/sum(sum(abs(reX-X).^2))) %计算PSNR