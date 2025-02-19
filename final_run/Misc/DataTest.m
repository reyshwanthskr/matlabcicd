if out.PathPoints.Data(:,:,1)== out.PathPoints.Data(:,:,2)
    a=true;
end

b=reshape(out.PathPoints.Data(out.PathPoints.Data(:,:,1)~=0),[],2)
size(b)


x=zeros();
y=zeros();
for i=1:length(b)
    x(i)=b(i,1);
    y(i)=b(i,2);
end

plot(x,y)