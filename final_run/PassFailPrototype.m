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

for i =1:length(out.Position.Time)
    if or(out.Velocity.Data(:,:,i)>maxSpeed,out.Velocity.Data(:,:,i)<minSpeed)
        r5=false;
    end
    if out.stopped.Data(i)==1
        waitTime=waitTime+1;
    end
    if out.Direction.Data(i)==dir
        r3=true;
    end
    
    if out.detection.Data(i) & out.distance.Data(i)<dist
        r4=false;
    end
    
    if out.stopped.Data(i) && (out.Position.Data(:,2,i)>61.021 || out.Position.Data(:,2,i)<57.71)
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

if r5
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

if r2
    disp("Wait Time Passed")
else
    disp("Wait Time Failed")
end