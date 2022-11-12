
MW = F3D.World(mfilename);

initialize(MW, [0.04, -0.04, 0.04], [0 0 0]);

VP = MW.Viewports.Main;
VP.Title = 'WestPoint';
Path = fileparts(which(mfilename));

MW.AngleUnits = 'deg';
MW.DistanceUnits = 'mm';

Floor = F3D.Geometry.templateFloor(MW.Root, [200 200 0.1]);

frictionVar = 0.9;

Body = addChild(MW.Root,'Body');
load(Body, 'Telo_sestaveno.stl');
Body.Location = [50 50 3];
Body.Mass = 0.4;
Body.Restitution = 0;
Body.Friction = frictionVar;
Body.Force = 0;
Body.Torque = 0;
Body.CenterOfMass = true;
% Body.Gravity = true;
% Body.Collisions = true;
% Body.Physics = true;

%% first leg
stLeg_stJoint = addChild(Body,'stLeg_stJoint');
load(stLeg_stJoint,'noha_1_sestava.stl');
stLeg_stJoint.Location = [8 0 2];
stLeg_stJoint.Rotation = [0 0 0];
stLeg_stJoint.Color = [1 0 0];
stLeg_stJoint.Mass = 0.12;
stLeg_stJoint.Restitution = 0;
stLeg_stJoint.Friction = frictionVar;
stLeg_stJoint.Force = 0;
stLeg_stJoint.Torque = 0;
stLeg_stJoint.Joint = F3D.Type.Joint('zrevolute');
stLeg_stJoint.Joint.PivotOffset = [0 0 0.8]; 
  
stLeg_ndJoint = addChild(stLeg_stJoint,'stLeg_ndJoint');
load(stLeg_ndJoint,'noha_2_sestava.stl');
stLeg_ndJoint.Location = [7.5 0 0];
stLeg_ndJoint.Rotation = [0 -30 0];
stLeg_ndJoint.Mass = 0.1;
stLeg_ndJoint.Restitution = 0;
stLeg_ndJoint.Friction = frictionVar;
stLeg_ndJoint.Force = 0;
stLeg_ndJoint.Torque = 0;
stLeg_ndJoint.Joint = F3D.Type.Joint('yrevolute');
% stLeg_ndJoint.Gravity = true;
% stLeg_ndJoint.Physics = true;
% stLeg_ndJoint.Collisions = true;

stLeg_rdJoint = addChild(stLeg_ndJoint,'stLeg_rdJoint');
load(stLeg_rdJoint,'noha_3_sestava.stl');
stLeg_rdJoint.Location = [7.5 0 0];
stLeg_rdJoint.Rotation = [0 90 0];
stLeg_rdJoint.Mass = 0.08;
stLeg_rdJoint.Restitution = 0;
stLeg_rdJoint.Friction = frictionVar;
stLeg_rdJoint.Force = 0;
stLeg_rdJoint.Torque = 0;
stLeg_rdJoint.Joint = F3D.Type.Joint('yrevolute');
% stLeg_rdJoint.Gravity = true;
% stLeg_rdJoint.Physics = true;
% stLeg_rdJoint.Collisions = true;
% Body.Physics = true;

stLeg_paw = addChild(stLeg_rdJoint,'stLeg_paw', 'PreciseContacts', true);
load(stLeg_paw,'packa_sestava.stl');
stLeg_paw.Location = [8 0 0.5];
stLeg_paw.Rotation = [0 -60 0];
stLeg_paw.Mass = 0.05;
stLeg_paw.Restitution = 0;
stLeg_paw.Friction = frictionVar;
stLeg_paw.Force = 0;
stLeg_paw.Torque = 0;
stLeg_paw.Joint = F3D.Type.Joint('fixed');
% stLeg_paw.Gravity = true;
% stLeg_paw.Physics = true;
% stLeg_paw.Collisions = true;

%% second leg
ndLeg_stJoint = addChild(Body,'ndLeg_stJoint');
load(ndLeg_stJoint,'noha_1_sestava.stl');
ndLeg_stJoint.Location = [0 8 2];
ndLeg_stJoint.Rotation = [0 0 90];
ndLeg_stJoint.Color = [0 1 0];
ndLeg_stJoint.Mass = 0.12;
ndLeg_stJoint.Restitution = 0;
ndLeg_stJoint.Friction = frictionVar;
ndLeg_stJoint.Force = 0;
ndLeg_stJoint.Torque = 0;
ndLeg_stJoint.Joint = F3D.Type.Joint('zrevolute');
% ndLeg_stJoint.Gravity = false;
% ndLeg_stJoint.Physics = true;
% ndLeg_stJoint.Collisions = true;

ndLeg_ndJoint = addChild(ndLeg_stJoint,'ndLeg_ndJoint');
load(ndLeg_ndJoint,'noha_2_sestava.stl');
ndLeg_ndJoint.Location = [7.5 0 0];
ndLeg_ndJoint.Rotation = [0 -30 0];
ndLeg_ndJoint.Mass = 0.1;
ndLeg_ndJoint.Restitution = 0;
ndLeg_ndJoint.Friction = frictionVar;
ndLeg_ndJoint.Force = 0;
ndLeg_ndJoint.Torque = 0;
ndLeg_ndJoint.Joint = F3D.Type.Joint('yrevolute');
% ndLeg_ndJoint.Gravity = true;
% ndLeg_ndJoint.Physics = true;
% ndLeg_ndJoint.Collisions = true;

ndLeg_rdJoint = addChild(ndLeg_ndJoint,'ndLeg_rdJoint');
load(ndLeg_rdJoint,'noha_3_sestava.stl');
ndLeg_rdJoint.Location = [7.5 0 0];
ndLeg_rdJoint.Rotation = [0 90 0];
ndLeg_rdJoint.Mass = 0.08;
ndLeg_rdJoint.Restitution = 0;
ndLeg_rdJoint.Friction = frictionVar;
ndLeg_rdJoint.Force = 0;
ndLeg_rdJoint.Torque = 0;
ndLeg_rdJoint.Joint = F3D.Type.Joint('yrevolute');
% ndLeg_rdJoint.Gravity = true;
% ndLeg_rdJoint.Physics = true;
% ndLeg_rdJoint.Collisions = true;

ndLeg_paw = addChild(ndLeg_rdJoint,'ndLeg_paw', 'PreciseContacts', true);
load(ndLeg_paw,'packa_sestava.stl');
ndLeg_paw.Location = [8 0 0.5];
ndLeg_paw.Rotation = [0 -60 0];
ndLeg_paw.Mass = 0.05;
ndLeg_paw.Restitution = 0;
ndLeg_paw.Friction = frictionVar;
ndLeg_paw.Force = 0;
ndLeg_paw.Torque = 0;
ndLeg_paw.Joint = F3D.Type.Joint('fixed');
% ndLeg_paw.Gravity = true;
% ndLeg_paw.Physics = true;
% ndLeg_paw.Collisions = true;

%% Third leg
rdLeg_stJoint = addChild(Body,'rdLeg_stJoint');
load(rdLeg_stJoint,'noha_1_sestava.stl');
rdLeg_stJoint.Location = [-8 0 2];
rdLeg_stJoint.Rotation = [0 0 180];
rdLeg_stJoint.Mass = 0.12;
rdLeg_stJoint.Restitution = 0;
rdLeg_stJoint.Friction = frictionVar;
rdLeg_stJoint.Force = 0;
rdLeg_stJoint.Torque = 0;
rdLeg_stJoint.Joint = F3D.Type.Joint('zrevolute');
% rdLeg_stJoint.Gravity = false;
% rdLeg_stJoint.Physics = true;
% rdLeg_stJoint.Collisions = true;

rdLeg_ndJoint = addChild(rdLeg_stJoint,'rdLeg_ndJoint');
load(rdLeg_ndJoint,'noha_2_sestava.stl');
rdLeg_ndJoint.Location = [7.5 0 0];
rdLeg_ndJoint.Rotation = [0 -30 0];
rdLeg_ndJoint.Mass = 0.1;
rdLeg_ndJoint.Restitution = 0;
rdLeg_ndJoint.Friction = frictionVar;
rdLeg_ndJoint.Force = 0;
rdLeg_ndJoint.Torque = 0;
rdLeg_ndJoint.Joint = F3D.Type.Joint('yrevolute');
% rdLeg_ndJoint.Gravity = true;
% rdLeg_ndJoint.Physics = true;
% rdLeg_ndJoint.Collisions = true;

rdLeg_rdJoint = addChild(rdLeg_ndJoint,'rdLeg_rdJoint');
load(rdLeg_rdJoint,'noha_3_sestava.stl');
rdLeg_rdJoint.Location = [7.5 0 0];
rdLeg_rdJoint.Rotation = [0 90 0];
rdLeg_rdJoint.Mass = 0.08;
rdLeg_rdJoint.Restitution = 0;
rdLeg_rdJoint.Friction = frictionVar;
rdLeg_rdJoint.Force = 0;
rdLeg_rdJoint.Torque = 0;
rdLeg_rdJoint.Joint = F3D.Type.Joint('yrevolute');
% rdLeg_rdJoint.Gravity = true;
% rdLeg_rdJoint.Physics = true;
% rdLeg_rdJoint.Collisions = true;


rdLeg_paw = addChild(rdLeg_rdJoint,'rdLeg_paw', 'PreciseContacts', true);
load(rdLeg_paw,'packa_sestava.stl');
rdLeg_paw.Location = [8 0 0.5];
rdLeg_paw.Rotation = [0 -60 0];
rdLeg_paw.Mass = 0.05;
rdLeg_paw.Restitution = 0;
rdLeg_paw.Friction = frictionVar;
rdLeg_paw.Force = 0;
rdLeg_paw.Torque = 0;
rdLeg_paw.Joint = F3D.Type.Joint('fixed');
% rdLeg_paw.Gravity = true;
% rdLeg_paw.Physics = true;
% rdLeg_paw.Collisions = true;


%% fourth leg
thLeg_stJoint = addChild(Body,'thLeg_stJoint');
load(thLeg_stJoint,'noha_1_sestava.stl');
thLeg_stJoint.Location = [0 -8 2];
thLeg_stJoint.Rotation = [0 0 -90];
thLeg_stJoint.Mass = 0.12;
thLeg_stJoint.Restitution = 0;
thLeg_stJoint.Friction = frictionVar;
thLeg_stJoint.Force = 0;
thLeg_stJoint.Torque = 0;
thLeg_stJoint.Joint = F3D.Type.Joint('zrevolute');
% thLeg_stJoint.Gravity = false;
% thLeg_stJoint.Physics = true;
% thLeg_stJoint.Collisions = true;

thLeg_ndJoint = addChild(thLeg_stJoint,'thLeg_ndJoint');
load(thLeg_ndJoint,'noha_2_sestava.stl');
thLeg_ndJoint.Location = [7.5 0 0];
thLeg_ndJoint.Rotation = [0 -30 0];
thLeg_ndJoint.Mass = 0.1;
thLeg_ndJoint.Restitution = 0;
thLeg_ndJoint.Friction = frictionVar;
thLeg_ndJoint.Force = 0;
thLeg_ndJoint.Torque = 0;
thLeg_ndJoint.Joint = F3D.Type.Joint('yrevolute');
% thLeg_ndJoint.Gravity = true;
% thLeg_ndJoint.Physics = true;
% thLeg_ndJoint.Collisions = true;

thLeg_rdJoint = addChild(thLeg_ndJoint,'thLeg_rdJoint');
load(thLeg_rdJoint,'noha_3_sestava.stl');
thLeg_rdJoint.Location = [7.5 0 0];
thLeg_rdJoint.Rotation = [0 90 0];
thLeg_rdJoint.Mass = 0.08;
thLeg_rdJoint.Restitution = 0;
thLeg_rdJoint.Friction = frictionVar;
thLeg_rdJoint.Force = 0;
thLeg_rdJoint.Torque = 0;
thLeg_rdJoint.Joint = F3D.Type.Joint('yrevolute');
% thLeg_rdJoint.Gravity = true;
% thLeg_rdJoint.Physics = true;
% thLeg_rdJoint.Collisions = true;

thLeg_paw = addChild(thLeg_rdJoint,'thLeg_paw', 'PreciseContacts', true);
load(thLeg_paw,'packa_sestava.stl');
thLeg_paw.Location = [8 0 0.5];
thLeg_paw.Rotation = [0 -60 0];
thLeg_paw.Mass = 0.05;
thLeg_paw.Restitution = 0;
thLeg_paw.Friction = frictionVar;
thLeg_paw.Force = 0;
thLeg_paw.Torque = 0;
thLeg_paw.Joint = F3D.Type.Joint('fixed');
% thLeg_paw.Gravity = true;
% thLeg_paw.Physics = true;
% thLeg_paw.Collisions = true;

%% Physics
% Body.Physics = true;
% stLeg_stJoint.Physics = true;
% stLeg_ndJoint.Physics = true;
% stLeg_rdJoint.Physics = true;
% stLeg_paw.Physics = true;
% ndLeg_stJoint.Physics = true;
% ndLeg_ndJoint.Physics = true;
% ndLeg_rdJoint.Physics = true;
% ndLeg_paw.Physics = true;
% rdLeg_stJoint.Physics = true;
% rdLeg_ndJoint.Physics = true;
% rdLeg_rdJoint.Physics = true;
% rdLeg_paw.Physics = true;
% thLeg_stJoint.Physics = true;
% thLeg_ndJoint.Physics = true;
% thLeg_rdJoint.Physics = true;
% thLeg_paw.Physics = true;

%% Gravity
% Body.Gravity = true;
% stLeg_stJoint.Gravity = true;
% stLeg_ndJoint.Gravity = true;
% stLeg_rdJoint.Gravity = true;
% stLeg_paw.Gravity = true;
% ndLeg_stJoint.Gravity = true;
% ndLeg_ndJoint.Gravity = true;
% ndLeg_rdJoint.Gravity = true;
% ndLeg_paw.Gravity = true;
% rdLeg_stJoint.Gravity = true;
% rdLeg_ndJoint.Gravity = true;
% rdLeg_rdJoint.Gravity = true;
% rdLeg_paw.Gravity = true;
% thLeg_stJoint.Gravity = true;
% thLeg_ndJoint.Gravity = true;
% thLeg_rdJoint.Gravity = true;
% thLeg_paw.Gravity = true;
%% Collisions
% Body.Collisions = true;
% stLeg_stJoint.Collisions = true;
% stLeg_ndJoint.Collisions = true;
% stLeg_rdJoint.Collisions = true;
% stLeg_paw.Collisions = true;
% ndLeg_stJoint.Collisions = true;
% ndLeg_ndJoint.Collisions = true;
% ndLeg_rdJoint.Collisions = true;
% ndLeg_paw.Collisions = true;
% rdLeg_stJoint.Collisions = true;
% rdLeg_ndJoint.Collisions = true;
% rdLeg_rdJoint.Collisions = true;
% rdLeg_paw.Collisions = true;
% thLeg_stJoint.Collisions = true;
% thLeg_ndJoint.Collisions = true;
% thLeg_rdJoint.Collisions = true;
% thLeg_paw.Collisions = true;

%% Body Servo
stBodyServo = addChild(Body,'stBodyServo');
load(stBodyServo,'model_servo_sestava.stl');
stBodyServo.Location = [7 0 2.25];
stBodyServo.Rotation = [0 0 0];
stBodyServo.Color = [0 0 0];
stBodyServo.Mass = 0.2;

ndBodyServo = addChild(Body,'ndBodyServo');
load(ndBodyServo,'model_servo_sestava.stl');
ndBodyServo.Location = [0 7 2.25];
ndBodyServo.Rotation = [0 0 90];
ndBodyServo.Color = [0 0 0];
ndBodyServo.Mass = 0.2;

rdBodyServo = addChild(Body,'rdBodyServo');
load(rdBodyServo,'model_servo_sestava.stl');
rdBodyServo.Location = [-7 0 2.25];
rdBodyServo.Rotation = [0 0 0];
rdBodyServo.Color = [0 0 0];
rdBodyServo.Mass = 0.2;

thBodyServo = addChild(Body,'thBodyServo');
load(thBodyServo,'model_servo_sestava.stl');
thBodyServo.Location = [0 -7 2.25];
thBodyServo.Rotation = [0 0 90];
thBodyServo.Color = [0 0 0];
thBodyServo.Mass = 0.2;

%% Joint servo
stJointServo = addChild(stLeg_stJoint,'stJointServo');
load(stJointServo,'model_servo_Joint.stl');
stJointServo.Location = [6.5 0.25 0];
stJointServo.Rotation = [0 0 0];
stJointServo.Color = [0 0 0];
stJointServo.Mass = 0.18;

ndJointServo = addChild(ndLeg_stJoint,'ndJointServo');
load(ndJointServo,'model_servo_Joint.stl');
ndJointServo.Location = [6.5 0.25 0];
ndJointServo.Rotation = [0 0 0];
ndJointServo.Color = [0 0 0];
ndJointServo.Mass = 0.18;

rdJointServo = addChild(rdLeg_stJoint,'rdJointServo');
load(rdJointServo,'model_servo_Joint.stl');
rdJointServo.Location = [6.5 0.25 0];
rdJointServo.Rotation = [0 0 0];
rdJointServo.Color = [0 0 0];
rdJointServo.Mass = 0.18;

thJointServo = addChild(thLeg_stJoint,'thJointServo');
load(thJointServo,'model_servo_Joint.stl');
thJointServo.Location = [6.5 0.25 0];
thJointServo.Rotation = [0 0 0];
thJointServo.Color = [0 0 0];
thJointServo.Mass = 0.18;

%% Paw servo
stPawServo = addChild(stLeg_ndJoint,'stPawServo');
load(stPawServo,'model_servo_paw.stl');
stPawServo.Location = [7 0.25 0];
stPawServo.Rotation = [0 0 0];
stPawServo.Color = [0 0 0];
stPawServo.Mass = 0.15;

ndPawServo = addChild(ndLeg_ndJoint,'ndPawServo');
load(ndPawServo,'model_servo_paw.stl');
ndPawServo.Location = [7 0.25 0];
ndPawServo.Rotation = [0 0 0];
ndPawServo.Color = [0 0 0];
ndPawServo.Mass = 0.15;

rdPawServo = addChild(rdLeg_ndJoint,'rdPawServo');
load(rdPawServo,'model_servo_paw.stl');
rdPawServo.Location = [7 0.25 0];
rdPawServo.Rotation = [0 0 0];
rdPawServo.Color = [0 0 0];
rdPawServo.Mass = 0.15;

thPawServo = addChild(thLeg_ndJoint,'thPawServo');
load(thPawServo,'model_servo_paw.stl');
thPawServo.Location = [7 0.25 0];
thPawServo.Rotation = [0 0 0];
thPawServo.Color = [0 0 0];
thPawServo.Mass = 0.15;

save(MW,'robot_sestaven_2.f3d')