x=zeros(0);
y=zeros(0);

for i=1:121
    x(i)=i;
    a=out.m(:,:,i);
    y(i)=sqrt(a(4)^2+a(5)^2);
end

plot(x,y)