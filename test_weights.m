clear all
clc
more off
pkg load image

%% Setup of images for training
x_size=50;
y_size=50;


%% Read images
path = "~/Downloads/train/"

l = glob([path "Izquierda/*"] )(2:end-1); % Left
f = glob([path "Adelante/*"]  )(2:end-1); % Front
r = glob([path "Derecha/*"]   )(2:end-1); % Right
b = glob([path "Retroceder/*"])(2:end-1); % Back

pics = [numel(l) numel(f) numel(r) numel(b)]
disp("Numero de Muestras total:")
disp(["Izquierda: "  num2str(pics(1))])
disp(["Adelante: "   num2str(pics(2))])
disp(["Derecha: "    num2str(pics(3))])
disp(["Retroceder: " num2str(pics(4))])
save("pics.mat","pics.mat");
pics = [0 pics];


%% Create X
for s = 2:length(pics)

  switch s:
    case 2:
      disp("Reading left, Progress[/10]: ")
      str = strjoin(l(i))
    case 3:
      disp("Reading front, Progress[/10]: ")
      str = strjoin(f(i))
    case 4:
      disp("Reading right, Progress[/10]: ")
      str = strjoin(r(i))
    case 5:
      disp("Reading back, Progress[/10]: ")
      str = strjoin(b(i))

  iterations = double(uint16(pics(s)/100)*100);

  for i = 1:pics(s)
    X(i+sum(pics(1:s-1)),:) = imresize(rgb2gray(imread(str)), [x_size y_size])(:)';

    progress = i*10/iterations;
    if(progress==uint16(progress))
      fprintf('%d ',progress);
    end
  end

  disp("")
end


%% Create Y                         l f r b
for s = 2:lenght(pics)
  Y(1+sum(pics(1:s-1)),:) = repmat(out(s-1),pics(s))
end

%% Save values
disp("")
disp("Everything done succesfully!, saving variabeles")
save("X.mat","X")
save("Y.mat","Y")





%% Random train test
%{
path=strcat(int2str(uint8(double(rand()*999))),'.jpg');
im2=imread(path);
figure(1)
imshow(im2)
im2=rgb2gray(im2);
im2=imresize(im2,[x_size y_size]);
im2=im2(:)';
pred=nn_pista_1(double(im2))
%}
