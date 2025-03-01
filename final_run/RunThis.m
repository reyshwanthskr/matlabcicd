scenarioNames="SpStDsWt"; %List Of Scenarios Tested (Can only do 1 as of now)

%Initialize Behavioral Requirements
    
    %Upper and Lower Speed Bounds
    maxSpeed=18.3;
    
    waitTime=0; %Initialize Wait Time
    
    %Wait Time minimum and Maximum Requirements
    minWait=0;
    maxWait=7;
    
    %Turns Left
    dir="Left";
    
    %Minimum distance in meters between cars
    dist=5;

    %Reaction Time Bounds
    maxReact=2;
    minReact=-1;

%File Paths
rrInstallationPath = "/usr/local/RoadRunner_R2024b/bin/glnxa64";
rrProjectPath = "/adc"; %Project Path

for j=1:length(scenarioNames)
    %Open Roadrunner
    s = settings;
    s.roadrunner.application.InstallationFolder.PersonalValue = rrInstallationPath;
    rrApp = roadrunner(rrProjectPath);

    %Sets a running value to close apps when simulation finishes
    out.running=0;
    
    
    %Opens scenario inside the Roadrunner App
    scenarioName=scenarioNames(j); %Test Scenario File Name
    openScenario(rrApp,scenarioName)
    rrSim = createSimulation(rrApp);    
    

    %Sets Simulation Step Size and Maximum Run time of Scenario
    simStepSize = 0.1;                    %Simulation Step Size
    t=17;                                 %Roadrunner Simulation Duration
    set(rrSim,"StepSize",simStepSize);
    set(rrSim,"MaxSimulationTime",t);
    
    load("busDefinitionsForRRSim.mat") %Bus Definitions used for data structuring (Position, Velocity,Sensor Values)
    
    %Open Simulink Model
    modelName = 'rrScenarioSimWithSensors';
    open_system(modelName)
    
    %Run Simulation
    set(rrSim,"SimulationCommand","Start")
    
    while out.running==0
        pause(0.1)
    end
    
    %Close Roadrunner
    close(rrApp)
    
    
    %
    %  Pass-Fail Tests
    %
    
    r1=false; %Stopping Distance
    r2=false; %Wait Time
    r3=false; %Turns Left
    r4=true; %Distance from Obstacles
    r5=true; %Speed
    r6=true; %Reaction Time
    r7=true; %lane Change
    
        
    
    %Loops through Data per instance in time
    SSS=false;
    for i =1:length(out.Position.Time)
    
        %Tests if speed is in range
        if norm(out.Velocity.Data(:,:,i))>maxSpeed
            r5=false;
        end
    
        %Adds time to wait time in increments of "simStepSize"
        if out.stopped.Data(i)==1
            waitTime=waitTime+1;
        end
    
        %Checks if car turns the right direction at any moment
        if out.Direction.Data(i)==dir
            r3=true;
        end
        
        %checks if car is detected and above the set detection range 
        %(makes sure car is not too close)
        if out.detection.Data(i) && out.distance.Data(i)<dist
            r4=false;
        end
        
        %Distance from Stop Sign 
        %(Specific to "UnprotectedIntersection.rrscene")
        if out.stopped.Data(i) && (out.Position.Data(:,2,i)<61.021 && out.Position.Data(:,2,i)>57.71)&& ~SSS
            r1=true;
            SSS=true;
        end

        if out.changed.Data(i)
            r7=false;
        end
    end
    
    %Calculates the wait time and checks if the wait time is within bounds
    if and(waitTime*simStepSize<maxWait,waitTime*simStepSize>minWait)
        r2=true;
    end

    if or((waitTime*simStepSize)-1>maxReact,(waitTime*simStepSize)-1<minReact)
        r6=false;
    end
    
    %Test Results are "true" when all tests are passed
    testResults=r1&r2&r3&r4&r5&r6&r7;
    
    %Prints Test Results to command window
    disp(" ")
    nam=sprintf("Results for %s",scenarioNames(j));
    disp(nam)
    disp(" ")
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
    
    if r6
        disp("Reaction Time Passed")
    else
        disp("Reaction Time Failed")
    end

    if r7
        disp("Passed: Lane Keeping")
    else
        disp("Failed: Lane Keeping")
    end

    disp(' ')

end
%close_system
