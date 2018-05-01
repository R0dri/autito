clear all
clc
x1= [0;0;1;1];
x2= [0;1;0;1];
Yd= [0;0;0;1];

t=0.2;
alpha=0.1;
w1=0.3;
w2=-0.1;

for j=1:4

    for i=1:4

    Y=(w1*x1(i))+(w2*x2(i))-t+eps
    if(Y<0)
        Y1=0;
    end
    if(Y>=0)
      Y1=1;
    end

    e=Yd(i)-Y1+eps
    delta1=alpha*x1(i)*e
    delta2=alpha*x2(i)*e
    w1=w1+delta1
    w2=w2+delta2

    end
end
