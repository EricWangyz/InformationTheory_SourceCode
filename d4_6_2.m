X=imread('lena512.bmp'); % ����ԭʼͼƬ
[row,col]=size(X);
figure,imshow(X),title('ԭʼͼƬ')
para1=100; % ѹ��ͼƬ����
para2= 'lossy'; % ����ѹ��
imwrite(X,'Compressed.jpg','JPEG','Quality',para1,'Mode',para2);
reX=imread('Compressed.jpg');
figure,imshow(reX),title('JPEGͼƬ')
PSNR=10*log10(row*col*255^2/sum(sum(abs(reX-X).^2))) %����PSNR