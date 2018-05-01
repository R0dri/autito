clear all
clc
more off

disp("Entrenamiento de Red Neuronal, cargando archivos...")
load('X.mat') %nombre del archivo .mat que contenga X
load('Y.mat')
in=double(X/255);
out=Y;


path = "~/Downloads/train/";
l = glob([path "Izquierda/*"] )(2:end-1); % Left
f = glob([path "Adelante/*"]  )(2:end-1); % Front
r = glob([path "Derecha/*"]   )(2:end-1); % Right
b = glob([path "Retroceder/*"])(2:end-1); % Back

disp("Numero de Muestras total:")
disp(["Izquierda: "  num2str(numel(l))])
disp(["Adelante: "   num2str(numel(f))])
disp(["Derecha: "    num2str(numel(r))])
disp(["Retroceder: " num2str(numel(b))])

alpha=0.1;
[m n]=size(in)
disp(["Training examples: " num2str(m)])
hidden_layer_size=10;
output_layer_size=size(out,2);
X=[ones(m,1) in];

if(yes_or_no("load old weights to retrain? "))
  load('weight_1.mat')
  load('weight_2.mat')
else
  weight_1=rand(hidden_layer_size,n+1)*4.8/n-2.4/n;
  weight_2=rand(output_layer_size,hidden_layer_size+1)*4.8/hidden_layer_size-2.4/hidden_layer_size;
end

iterations = input("Select the number of iterations (5000): ")
muestras = double(uint16(m/100)*100)
disp("Progress[%]:")
tic
for iter = 1:iterations
  for foto = 1:m
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

    progress = ((iter-1)*muestras+foto)*100/(muestras*iterations);
    if(progress==floor(progress))
      fprintf('%d ',progress);
    end
  end
end

disp("")
disp("")
disp("")
disp("Resultados")

tim = toc;
h = floor(tim/60/60);
m = floor(tim/60)-h*60;
s = floor(tim-h*60*60-m*60);
disp(["Total run-time: " num2str(h) ":" num2str(m) "." num2str(s)])

YF=zeros(size(out));
for iter=1:m
                                %forward propagation
  a_1=X(iter,:);
  Z_1=1./(1+exp(-weight_1*a_1'));
  a_2=[1 Z_1'];
  Z_2=1./(1+exp(-weight_2*a_2'));
  YF(iter,:)=Z_2;
end


err_abs = sum(abs(Y-(YF>0.6)));
disp(["Total error [ABS]: " num2str(err_abs)])

err = err_abs./[numel(l) numel(f) numel(r) numel(b)];
err*= 100;
err = uint16(err);
disp(["Total error [rel]: " num2str(err) "\t%"])

adj = 1-err;
disp(["Ajuste a los Datos: " num2str(adj) "\t%"])

disp("")

csvwrite('weight_1.mat',weight_1)
csvwrite('weight_1.csv',weight_1)
csvwrite('weight_2.mat',weight_2)
csvwrite('weight_2.csv',weight_2)

