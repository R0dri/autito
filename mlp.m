clear all
clc
more off

                                % Load Parameters
disp("Entrenamiento de Red Neuronal, cargando archivos...")
%% Input
load('vars/X.mat')
in=double(X/255);
[m n]=size(in);
X=[ones(m,1) in];
%% Load Samples Size
disp(["Training examples: " num2str(m)])
disp(["Sample size: " num2str(n)])
load('vars/pics.mat')
disp("\nNumero de Muestras total:")
disp(["Izquierda: "  num2str(pics(1))])
disp(["Adelante: "   num2str(pics(2))])
disp(["Derecha: "    num2str(pics(3))])
disp(["Retroceder: " num2str(pics(4))])
disp("")
%% Output
load('vars/Y.mat')
out=Y;
output_layer_size = size(out,2);
%% Load weights
if(yes_or_no("load old weights to retrain?"))
  load('vars/weight_1.mat')
  load('vars/weight_2.mat')
  hidden_layer_size = size(weight_1,1)
  disp(["Hidden Layer Size: " num2str(hidden_layer_size)])
else
  hidden_layer_size = input("Set Hidden Layer Size (Neurons -> 10) ");
  weight_1=rand(hidden_layer_size,n+1)*4.8/n-2.4/n;
  weight_2=rand(output_layer_size,hidden_layer_size+1)*4.8/hidden_layer_size-2.4/hidden_layer_size;
end

do
  %% Setup iterations
  disp("")
  iterations = input("Select the number of iterations (5000): ");
  alpha=input("Set learning Rate (0.1): ");
  muestras = double(uint16(m/100)*100);
  disp("\n\nProgress[%]:")
                                % Training
  tic  % Set Runtime start
  for iter = 1:iterations
    for foto = 1:m
      %% Forward propagation
      a_1=X(iter,:);
      Z_1=1./(1+exp(-weight_1*a_1'));
      a_2=[1 Z_1'];
      Z_2=1./(1+exp(-weight_2*a_2'));

      e=out(iter,:)-Z_2';
      %% Back propagation
      %% errores de gradiente y correciones de peso
      e_grad_out=Z_2.*(1-Z_2).*e';
      delta_w2=alpha*e_grad_out*a_2;
      e_grad_hidden=Z_1'.*(1-Z_1').*(e_grad_out'*weight_2(:,(2:end)));
      delta_w1=alpha*(e_grad_hidden'*a_1);
      weight_1=weight_1+delta_w1;
      weight_2=weight_2+delta_w2;

      %% Show actual progress
      progress = ((iter-1)*muestras+foto)*100/(muestras*iterations);
      if(progress==floor(progress))
        fprintf('%d ',progress);
      end
    end
  end
  tim = toc; % End of Runtime

                                % Results
  %% Test with forward
  YF=zeros(size(out));
  for iter=1:m
    %% Forward propagation
    a_1=X(iter,:);
    Z_1=1./(1+exp(-weight_1*a_1'));
    a_2=[1 Z_1'];
    Z_2=1./(1+exp(-weight_2*a_2'));
    YF(iter,:)=Z_2;
  end

  disp("")
  disp("")
  disp("")
  disp("Resultados")

  %% Runtime
  h = floor(tim/60/60);
  min = floor(tim/60)-h*60;
  s = floor(tim-h*60*60-m*60);
  disp(["Total run-time: " num2str(h) ":" num2str(min) "." num2str(s)])
  disp(["Output Count:   " num2str(sum(round(YF)))])
  disp(["Expected Count: " num2str(sum(Y))])

  %% Absolute Error
  err_abs = sum(abs(Y-(YF>0.6)));
  disp(["Total error [ABS]: " num2str(err_abs)])
  %% Relative Error
  err = uint16(err_abs*100./pics);
  disp(["Total error [rel]:  " num2str(err) "\t%"])
  %% Data Adjustment
  adj = 1-err;
  disp(["Ajuste a los Datos: " num2str(adj) "\t%"])

  disp("")

                                % End program
  %% Save Weights
  if(yes_or_no("Save weights?"))
    %% Saving weights
    save('vars/weight_1.mat','weight_1')
    save('vars/weight_2.mat','weight_2')
    csvwrite('vars/weight_1.csv',weight_1)
    csvwrite('vars/weight_2.csv',weight_2)
  endif

until (!yes_or_no("want to retrain now?"))

disp("Closing program\n ")
