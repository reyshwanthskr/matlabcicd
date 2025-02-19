numPoints=length(out.Position.Data);
x1=zeros([1,numPoints]);
x2=zeros([1,numPoints]);
y1=zeros([1,numPoints]);
y2=zeros([1,numPoints]);
for i=1:numPoints
    x1(i)=out.Position.Data(:,1,i);
    y1(i)=out.Position.Data(:,2,i);
    x2(i)=out.obstaclePosition.Data(:,1,i);
    y2(i)=out.obstaclePosition.Data(:,2,i);
end

plot(x1,y1)
hold on
plot(x2,y2)
hold off

