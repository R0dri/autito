clear all;
clc;
x_size=50;
y_size=50;
m=2000;
X=zeros(m,x_size*y_size);

for i=1:1:m
    path=strcat(int2str(i),'.jpg');
    im=imread(path);
    im=rgb2gray(im);
    im=imresize(im,[x_size y_size]);
    X(i,:)=im(:)';
end

%Y=[1 0 0; 1 0 0; 0 1 0; 0 1 0; 0 0 1; 0 0 1];
Y(1:104,:)=repmat([1 0 0],104,1);
Y(105:400,:)=repmat([0 0 1],296,1);
Y(400:544,:)=repmat([0 1 0],145,1);
Y(545:864,:)=repmat([0 0 1],320,1);
Y(865:968,:)=repmat([1 0 0],104,1);
Y(967:999,:)=repmat([0 0 1],33,1);
Y(1000:1122,:)=repmat([1 0 0],123,1);
Y(1123:1474,:)=repmat([0 1 0],352,1);
Y(1475:1590,:)=repmat([0 0 1],116,1);
Y(1591:1960,:)=repmat([0 1 0],370,1);
Y(1961:2000,:)=repmat([1 0 0],40,1)

path=strcat(int2str(uint8(double(rand()*999))),'.jpg');
im2=imread(path);
figure(1)
imshow(im2)
im2=rgb2gray(im2);
im2=imresize(im2,[x_size y_size]);
im2=im2(:)';
pred=nn_pista_1(double(im2))
