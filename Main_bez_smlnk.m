clc,clear

MW = F3D.World('WestPoint');

initialize(MW, [0.1, 0.1, 0.04], [0 0 0]);

MW.AngleUnits = 'deg';
MW.DistanceUnits = 'mm';

Robot = addChild(MW.Root,'Robot');
load(Robot,'robot_sestaven_2.f3d');
Robot.Location = [0 0 10];
%Robot.CenterOfMass = 2;

MW.UserData.MovesCounter = 0;
VP = MW.Viewports.Main;
VP.Button1 = F3D.Type.Button([0 0 0], 'IR','Import Rotations',@ImportRotations);
VP.Button2 = F3D.Type.Button([0 0 0], 'IC','Import Coordinates',@ImportCoordinates);
VP.Button5 = F3D.Type.Button([0 0 0], 'R','Reset',@Reset);
VP.Button6 = F3D.Type.Button([0 0 0], 'F', 'Forward', @MoveForward);

MW.UserData.OnlyOnce = true;
Init(MW);

%VP.UserData.assd = F3D.Aux.Trivia.isInteractive;
function ImportRotations(World,~)
%     Init(World);
    World.UserData.assd = F3D.Aux.Trivia.isInteractive;
    if World.UserData.assd == 1
        [ok, answ] = World.Viewports.Main.question("Set angel:","var = angel");
        if ok
            answ = strtrim(strsplit(answ, '='));
            World.UserData.Part = answ{1};
            World.UserData.Angel = str2double(answ{2});
            AddAngelToVar(World);
        else
            return
        end
    end
    SetRotations(World);
end
function ImportCoordinates(World,~)
    World.UserData.assd = F3D.Aux.Trivia.isInteractive;
    if World.UserData.assd == 1
        [ok, answ] = World.Viewports.Main.question("Set coordinates:","var/Coord = num");
        if ok
            answ = strtrim(strsplit(answ, '='));
            if answ{1} == "Coord"
                World.UserData.Part = answ{1};
                newstr = strtrim(strsplit(answ{2},' '));
                World.UserData.Coord = str2double(newstr);
            else
                World.UserData.Part = answ{1};
                World.UserData.Angel = str2double(answ{2});
            end
            AddCoord(World);
        else
            return
        end
    end
    TransformCoord(World);
end

% WA = F3D.WorldApp.ApplyMenu()
% MW.WorldApp

function MoveForward(World, ~)
    stLegMove(World);
    ndLegMove(World);
    rdLegMove(World);
    thLegMove(World);
end
function Reset(World,~)
    evalin('base', 'fds;');
end

%% Basic Leg Move
function stLegMove(World,~)
    MaxPeriod = 90;

    World.UserData.MovesCounter = World.UserData.MovesCounter + 1;
    stJoint = findBy(World.Root, 'Name', 'stLeg_stJoint', 'first');
    ndJoint = findBy(World.Root, 'Name', 'stLeg_ndJoint', 'first');
    
    for i = 0:3:MaxPeriod
        stJoint.Rotation(3) = sind(i)*20;
        ndJoint.Rotation(2) = sind(i*2)*(-5)-30;
        keepRate(World, 10);
    end
    World.UserData.MovesCounter = World.UserData.MovesCounter - 1;
end
function ndLegMove(World,~)
    MaxPeriod = 90;
    
    World.UserData.MovesCounter = World.UserData.MovesCounter + 1;
    stJoint = findBy(World.Root, 'Name', 'ndLeg_stJoint', 'first');
    ndJoint = findBy(World.Root, 'Name', 'ndLeg_ndJoint', 'first');
    for i = 0:3:MaxPeriod
        stJoint.Rotation(3) = sind(i)*(-20)+90;
        ndJoint.Rotation(2) = sind(i*2)*(-5)-30;
        keepRate(World, 10);
    end
    World.UserData.MovesCounter = World.UserData.MovesCounter - 1;
end
function rdLegMove(World,~)
     MaxPeriod = 90;
    
    World.UserData.MovesCounter = World.UserData.MovesCounter + 1;
    stJoint = findBy(World.Root, 'Name', 'rdLeg_stJoint', 'first');
    ndJoint = findBy(World.Root, 'Name', 'rdLeg_ndJoint', 'first');
    for i = 0:3:MaxPeriod
        stJoint.Rotation(3) = sind(i)*(20)+180;
        ndJoint.Rotation(2) = sind(i*2)*(-5)-30;
        keepRate(World, 10);
    end
    World.UserData.MovesCounter = World.UserData.MovesCounter - 1;
end
function thLegMove(World,~)
    MaxPeriod = 90;
    
    World.UserData.MovesCounter = World.UserData.MovesCounter + 1;
    stJoint = findBy(World.Root, 'Name', 'thLeg_stJoint', 'first');
    ndJoint = findBy(World.Root, 'Name', 'thLeg_ndJoint', 'first');
    for i = 0:3:MaxPeriod
        stJoint.Rotation(3) = sind(i)*(-20)-90;
        ndJoint.Rotation(2) = sind(i*2)*(-5)-30;
        keepRate(World, 10);
    end
    World.UserData.MovesCounter = World.UserData.MovesCounter - 1;
end

%% Import rotation fce
function Init(World,~)
%% Zero level joint rotations
if World.UserData.OnlyOnce
    World.UserData.stLJ = 0;
    World.UserData.stLndJ = 0;
    World.UserData.stLrdJ = 0;
        
    World.UserData.ndLstJ = 0;
    World.UserData.ndLJ = 0;
    World.UserData.ndLrdJ = 0;
    
    World.UserData.rdLstJ = 0;
    World.UserData.rdLndJ = 0;
    World.UserData.rdLJ = 0;
    
    World.UserData.thLstJ = 0;
    World.UserData.thLndJ = 0;
    World.UserData.thLrdJ = 0;
    World.UserData.OnlyOnce = false;

    World.UserData.x = 0;
    World.UserData.y = 0;
    World.UserData.z = 0;
    World.UserData.JointCoord = [0,0,0];
end
%% Base joint rotations
    World.UserData.BRstLJ = [0 0 0];
    World.UserData.BRstLndJ = [0 -30 0];
    World.UserData.BRstLrdJ = [0 90 0];
        
    World.UserData.BRndLstJ = [0 0 90];
    World.UserData.BRndLJ = [0 -30 0];
    World.UserData.BRndLrdJ = [0 90 0];
    
    World.UserData.BRrdLstJ = [0 0 180];
    World.UserData.BRrdLndJ = [0 -30 0];
    World.UserData.BRrdLJ = [0 90 0];
    
    World.UserData.BRthLstJ = [0 0 -90];
    World.UserData.BRthLndJ = [0 -30 0];
    World.UserData.BRthLrdJ = [0 90 0];
%% find leg property
    World.UserData.stLeg_stJoint = findBy(World.Root, 'Name', 'stLeg_stJoint', 'first');
    World.UserData.stLeg_ndJoint = findBy(World.Root, 'Name', 'stLeg_ndJoint', 'first');
    World.UserData.stLeg_rdJoint = findBy(World.Root, 'Name', 'stLeg_rdJoint', 'first');

    World.UserData.ndLeg_stJoint = findBy(World.Root, 'Name', 'ndLeg_stJoint', 'first');
    World.UserData.ndLeg_ndJoint = findBy(World.Root, 'Name', 'ndLeg_ndJoint', 'first');
    World.UserData.ndLeg_rdJoint = findBy(World.Root, 'Name', 'ndLeg_rdJoint', 'first');

    World.UserData.rdLeg_stJoint = findBy(World.Root, 'Name', 'rdLeg_stJoint', 'first');
    World.UserData.rdLeg_ndJoint = findBy(World.Root, 'Name', 'rdLeg_ndJoint', 'first');
    World.UserData.rdLeg_rdJoint = findBy(World.Root, 'Name', 'rdLeg_rdJoint', 'first');

    World.UserData.thLeg_stJoint = findBy(World.Root, 'Name', 'thLeg_stJoint', 'first');
    World.UserData.thLeg_ndJoint = findBy(World.Root, 'Name', 'thLeg_ndJoint', 'first');
    World.UserData.thLeg_rdJoint = findBy(World.Root, 'Name', 'thLeg_rdJoint', 'first');

end
function SetRotations(World,~)
  
    World.UserData.stLeg_stJoint.Rotation(3) = World.UserData.BRstLJ(3) + World.UserData.stLJ;
    World.UserData.stLeg_ndJoint.Rotation(2) = World.UserData.BRstLndJ(2) + World.UserData.stLndJ;
    World.UserData.stLeg_rdJoint.Rotation(2) = World.UserData.BRstLrdJ(2) + World.UserData.stLrdJ;
    
    World.UserData.ndLeg_stJoint.Rotation(3) = World.UserData.BRndLstJ(3) + World.UserData.ndLstJ;
    World.UserData.ndLeg_ndJoint.Rotation(2) = World.UserData.BRndLJ(2) + World.UserData.ndLJ;
    World.UserData.ndLeg_rdJoint.Rotation(2) = World.UserData.BRndLrdJ(2) + World.UserData.ndLrdJ;

    World.UserData.rdLeg_stJoint.Rotation(3) = World.UserData.BRrdLstJ(3) + World.UserData.rdLstJ;
    World.UserData.rdLeg_ndJoint.Rotation(2) = World.UserData.BRrdLndJ(2) + World.UserData.rdLndJ;
    World.UserData.rdLeg_rdJoint.Rotation(2) = World.UserData.BRrdLJ(2) + World.UserData.rdLJ;

    World.UserData.thLeg_stJoint.Rotation(3) = World.UserData.BRthLstJ(3) + World.UserData.thLstJ;
    World.UserData.thLeg_ndJoint.Rotation(2) = World.UserData.BRthLndJ(2) + World.UserData.thLndJ;
    World.UserData.thLeg_rdJoint.Rotation(2) = World.UserData.BRthLrdJ(2) + World.UserData.thLrdJ;

end
function AddAngelToVar(World,~)
    switch World.UserData.Part
        case 'stLJ'
            World.UserData.stLJ = World.UserData.Angel;
        case 'stLndJ'
            World.UserData.stLndJ = World.UserData.Angel;
        case 'stLrdJ'
            World.UserData.stLrdJ = World.UserData.Angel;
        case 'ndLstJ'
            World.UserData.ndLstJ = World.UserData.Angel;
        case 'ndLJ'
            World.UserData.ndLJ = World.UserData.Angel;
        case 'ndLrdJ'
            World.UserData.ndLrdJ = World.UserData.Angel;
        case 'rdLstJ'
            World.UserData.rdLstJ = World.UserData.Angel;
        case 'rdLndJ'
            World.UserData.rdLndJ = World.UserData.Angel;
        case 'rdLJ'
            World.UserData.rdLJ = World.UserData.Angel;
        case 'thLstJ'
            World.UserData.thLstJ = World.UserData.Angel;
        case 'thLndJ'
            World.UserData.thLndJ = World.UserData.Angel;
        case 'thLrdJ'
            World.UserData.thLrdJ = World.UserData.Angel;
    end

end

%% Import Coord to walk fce
function AddCoord(World,~)
    switch World.UserData.Part
        case 'x'
            World.UserData.x = World.UserData.Angel;
            World.UserData.Coord(1) = World.UserData.x;
        case 'y'
            World.UserData.y = World.UserData.Angel;
            World.UserData.Coord(2) = World.UserData.y;
        case 'z'
            World.UserData.z = World.UserData.Angel;
            World.UserData.Coord(3) = World.UserData.z;
        case 'Coord'
           World.UserData.x = World.UserData.Coord(1);
           World.UserData.y = World.UserData.Coord(2);
           World.UserData.z = World.UserData.Coord(3);
    end
end
%% Use elbow transformations
function TransformCoord(World,~)
L1 = 75;
L2 = 75;
L3 = 98.845;

x = World.UserData.x;
y = World.UserData.y;
z = World.UserData.z; 

q1 = atan(y/x);
L = sqrt(x^2+y^2)-L1;
q2 = acos((L3^2-L2^2-L^2-z^2)/(-2*L2*sqrt(L^2-z^2))) - atan(z/L);
q3 = acos((L^2+z^2-L3^2-L2^2)/(-2*L2*L3))-pi/2;
World.UserData.JointCoord = [q1,q2,q3];
end
