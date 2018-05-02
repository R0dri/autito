clear all; clc; more off; pkg load image

%% Setup of images for training
x_size=50;
y_size=50;

%% Read images
path = "~/Downloads/train/"
disp("")

l = glob([path "Izquierda/*"] )(2:end-1); % Left
f = glob([path "Adelante/*"]  )(2:end-1); % Front
r = glob([path "Derecha/*"]   )(2:end-1); % Right
b = glob([path "Retroceder/*"])(2:end-1); % Back

pics = [numel(l) numel(f) numel(r) numel(b)];
disp("Numero de Muestras total:")
disp(["Izquierda: "  num2str(pics(1))])
disp(["Adelante: "   num2str(pics(2))])
disp(["Derecha: "    num2str(pics(3))])
disp(["Retroceder: " num2str(pics(4))])
save("pics.mat","pics");
pics = [0 pics];

                                % Create X
for s = 2:length(pics)
  disp("")
  %% Select clasified set
  switch s
    case 2
      disp("Reading left, Progress[/10]: ")
      str = l;
    case 3
      disp("Reading front, Progress[/10]: ")
      str = f;
    case 4
      disp("Reading right, Progress[/10]: ")
      str = r;
    case 5
      disp("Reading back, Progress[/10]: ")
      str = b;
  endswitch

  iterations = double(uint16(pics(s)/100)*100);

  %% Iterate batch
  for i = 1:pics(s)
    X(i+sum(pics(1:s-1)),:) = imresize(rgb2gray(imread(strjoin(str(i)))), [x_size y_size])(:)';

    %% Show progress
    progress = i*10/iterations;
    if(progress==uint16(progress))
      fprintf('%d ',progress);
    end
  end
end
                                % Create Y
%%     l f r b
out = [1 0 0 0;
       0 1 0 0;
       0 0 1 0;
       0 0 0 1];

for s = 2:length(pics)
  Y(1+sum(pics(1:s-1)):sum(pics(1:s)),:) = repmat(out(s-1,:),pics(s),1);
end
                                % Save values
disp("")
disp("Everything done succesfully!, saving variabeles")
save("X.mat","X")
save("Y.mat","Y")
