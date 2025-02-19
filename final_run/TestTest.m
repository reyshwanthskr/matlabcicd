load("TestData.mat")
simStepSize=0.1;
r1=true; %Stopping Distance
r2=false; %Wait Time
r3=false; %Turns Left
r4=true; %Distance from Obstacles
r5=true; %Speed

minSpeed=17.5;
maxSpeed=18.3;

waitTime=0;
minWait=4;
maxWait=7;

dir="Left";

dist=5;

for i =1:length(Position.Time)
    if or(Velocity.Data(:,:,i)>maxSpeed,Velocity.Data(:,:,i)<minSpeed)
        r5=false;
    end
    if stopped.Data(i)==1
        waitTime=waitTime+1;
    end
    if Direction.Data(i)==dir
        r3=true;
    end
    
    if distance.Data(i)<dist
        r4=false;
    end
    
    if stopping.Data(i) && (Position.Data(:,2,i)>61.021 || Position.Data(:,2,i)<57.71)
        r1=false;
    end
end

if and(waitTime*simStepSize<maxWait,waitTime*simStepSize>minWait)
    r2=true;
end

testResults=r1&r2&r3&r4&r5;

if r1
    disp("Stopping Distance Passed")
else
    disp("Stopping Distance Failed")
end

if r2
    disp("Speed Test Passed")
else
    disp("Speed Test Failed")
end

if r3
    disp("Turning Left Passed")
else
    disp("Turning Left Failed")
end

if r4
    disp("Distance from Obstacle Passed")
else
    disp("Distance from Obstacle Failed")
end

if r5
    disp("Stopping Distance Passed")
else
    disp("Stopping Distance Failed")
end