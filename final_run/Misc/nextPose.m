function nextPose  = fcn(currPose, wayPointPos,simStepSize,speed)

egoSpeed  = speed;

wayPointPos = reshape(wayPointPos(wayPointPos~=0),[],2);

nWPP=wayPointPos(1,:);
currPoint = [currPose.Pose(1,4) currPose.Pose(2,4)];
delXY = nWPP-currPoint;
dist = norm(delXY);

hAngle = atan2d(delXY(2),delXY(1))-90;
nextPose = currPose;
if dist<=(egoSpeed*simStepSize)
    nextPose.Pose(1,4) = nWPP(1);
    nextPose.Pose(2,4) = nWPP(2);
else
    nextPose.Pose(1,4) = nextPose.Pose(1,4)+egoSpeed*simStepSize*cosd(hAngle);
    nextPose.Pose(2,4) = nextPose.Pose(2,4)+egoSpeed*simStepSize*sind(hAngle);
end
nextPose.Pose(1:3,1:3) = [cosd(hAngle) -sind(hAngle) 0;...
                          sind(hAngle) cosd(hAngle) 0;...
                          0 0 1];
nextPose.Velocity=[egoSpeed*cosd(hAngle) egoSpeed*sind(hAngle) 0];
end
