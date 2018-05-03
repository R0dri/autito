clear all
clc
load('X.mat') %nombre del archivo .mat que contenga X y Y
load('Y.mat')
in=X;
in=in/255;
out=Y;
alpha=0.1;
[m n]=size(in)
hidden_layer_size=10;
output_layer_size=size(out,2);
X=[ones(m,1) in];
weight_1=rand(hidden_layer_size,n+1)*4.8/n-2.4/n;
weight_2=rand(output_layer_size,hidden_layer_size+1)*4.8/hidden_layer_size-2.4/hidden_layer_size;

tic
for l=1:1:5000
  for iter=1:1:m
                                %forward propagation
    a_1=X(iter,:);
    Z_1=1./(1+exp(-weight_1*a_1'));
    a_2=[1 Z_1'];
    Z_2=1./(1+exp(-weight_2*a_2'));

    e=out(iter,:)-Z_2';
                                %back propagation
                                %errores de gradiente y correciones de peso
    e_grad_out=Z_2.*(1-Z_2).*e';
    delta_w2=alpha*e_grad_out*a_2;
    e_grad_hidden=Z_1'.*(1-Z_1').*(e_grad_out'*weight_2(:,(2:end)));
    delta_w1=alpha*(e_grad_hidden'*a_1);
    weight_1=weight_1+delta_w1;
    weight_2=weight_2+delta_w2;

  end
end
a=toc
YF=zeros(size(out));
for iter=1:1:m
    %forward propagation
a_1=X(iter,:);
Z_1=1./(1+exp(-weight_1*a_1'));
a_2=[1 Z_1'];
Z_2=1./(1+exp(-weight_2*a_2'));
YF(iter,:)=Z_2;
end

sum(abs(Y-(YF>0.6)))
