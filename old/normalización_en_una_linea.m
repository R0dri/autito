X= [15 80; 10 100; 20 110; 40 200];
M= (X-(repmat(mean(X), 4,1)))./repmat((max(X)- min(X)), 4,1)