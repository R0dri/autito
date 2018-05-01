clear all
clc
more off
pkg load image

%% Setup of images for training
path = "~/Downloads/train/"

x_size=50;
y_size=50;


%% Read images
l = glob([path "Izquierda/*"] )(2:end-1); % Left
f = glob([path "Adelante/*"]  )(2:end-1); % Front
r = glob([path "Derecha/*"]   )(2:end-1); % Right

b = glob([path "Retroceder/*"])(2:end-1); % Back



%% Create X
iterations = double(uint16(numel(l)/100)*100)
disp("Reading left, Progress[/10]: ")

for i = 1:numel(l)
  X(i,:) = imresize(rgb2gray(imread(strjoin(l(i)))), [x_size y_size])(:)';

  progress = i*10/iterations;
  if(progress==uint16(progress))
    fprintf('%d ',progress);
  end
end
disp("")


iterations = double(uint16(numel(f)/100)*100)
disp("Reading front, Progress[/10]: ")

for i = numel(l)+1:numel(l)+numel(f)
  X(i,:) = imresize(rgb2gray(imread(strjoin(f((i-numel(l)))))), [x_size y_size])(:)';

  progress = (i-numel(l))*10/iterations;
  if(progress==uint16(progress))
    fprintf('%d ',progress);
  end
end
disp("")



iterations = double(uint16(numel(r)/100)*100)
disp("Reading right, Progress[/10]: ")

for i = numel(l)+numel(f)+1:numel(r)+numel(l)+numel(f)
  X(i,:) = imresize(rgb2gray(imread(strjoin(r((i-numel(l)-numel(f)))))), [x_size y_size])(:)';

  progress = (i-numel(l)-numel(f))*10/iterations;
  if(progress==uint16(progress))
    fprintf('%d ',progress);
  end
end
disp("")


iterations = double(uint16(numel(b)/100)*100)
disp("Reading back, Progress[/10]: ")

for i = numel(l)+numel(f)+numel(r)+1:numel(b)+numel(r)+numel(f)+numel(l)
  X(i,:) = imresize(rgb2gray(imread(strjoin(b((i-numel(l)-numel(f)-numel(r)))))), [x_size y_size])(:)';

  progress = (i-numel(l)-numel(f)-numel(r))*10/iterations;
  if(progress==uint8(progress))
    fprintf('%d ',progress);
  end
end

%% Create Y                         l f r b
Y(1:numel(l), :)          = repmat([1 0 0 0], numel(l), 1);
Y(numel(l)+1:numel(f)+numel(l), :) = repmat([0 1 0 0], numel(f), 1);
Y(numel(f)+numel(l)+1:numel(r)+numel(f)+numel(l), :) = repmat([0 0 1 0], numel(r), 1);
Y(numel(r)+numel(f)+numel(l)+1:numel(b)+numel(f)+numel(l)+numel(r), :) = repmat([0 0 0 1], numel(b), 1);

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
