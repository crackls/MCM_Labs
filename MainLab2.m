%%MOCOM LAB2

clc
clear all
close all

addpath('include')

%%%%%% Robot Model Definition
biTri(1,1,1) = 1; biTri(1,2,1) = 0; biTri(1,3,1) = 0; biTri(1,4,1) = 0;
biTri(2,1,1) = 0; biTri(2,2,1) = 1; biTri(2,3,1) = 0; biTri(2,4,1) = 0;
biTri(3,1,1) = 0; biTri(3,2,1) = 0; biTri(3,3,1) = 1; biTri(3,4,1) = 0.175;
biTri(4,1,1) = 0; biTri(4,2,1) = 0; biTri(4,3,1) = 0; biTri(4,4,1) = 1;

biTri(1,1,2) = -1; biTri(1,2,2) = 0;  biTri(1,3,2) = 0; biTri(1,4,2) = 0;
biTri(2,1,2) = 0;  biTri(2,2,2) = 0;  biTri(2,3,2) = 1; biTri(2,4,2) = 0;
biTri(3,1,2) = 0;  biTri(3,2,2) = 1;  biTri(3,3,2) = 0; biTri(3,4,2) = 0.108;
biTri(4,1,2) = 0;  biTri(4,2,2) = 0;  biTri(4,3,2) = 0; biTri(4,4,2) = 1;

biTri(1,1,3) = 0;  biTri(1,2,3) = 0;  biTri(1,3,3) = 1;  biTri(1,4,3) = 0.105;
biTri(2,1,3) = -1; biTri(2,2,3) = 0;  biTri(2,3,3) = 0;  biTri(2,4,3) = 0;
biTri(3,1,3) = 0;  biTri(3,2,3) = -1; biTri(3,3,3) = 0;  biTri(3,4,3) = 0;
biTri(4,1,3) = 0;  biTri(4,2,3) = 0;  biTri(4,3,3) = 0;  biTri(4,4,3) = 1;

biTri(1,1,4) = 0;  biTri(1,2,4) = 1;  biTri(1,3,4) = 0;  biTri(1,4,4) = -0.1455;
biTri(2,1,4) = 0;  biTri(2,2,4) = 0;  biTri(2,3,4) = -1; biTri(2,4,4) = 0;
biTri(3,1,4) = -1; biTri(3,2,4) = 0;  biTri(3,3,4) = 0;  biTri(3,4,4) = 0.3265;
biTri(4,1,4) = 0;  biTri(4,2,4) = 0;  biTri(4,3,4) = 0;  biTri(4,4,4) = 1;

biTri(1,1,5) = 0; biTri(1,2,5) = 0;  biTri(1,3,5) = 1;  biTri(1,4,5) = 0.095;
biTri(2,1,5) = 0; biTri(2,2,5) = -1; biTri(2,3,5) = 0;  biTri(2,4,5) = 0;
biTri(3,1,5) = 1; biTri(3,2,5) = 0;  biTri(3,3,5) = 0;  biTri(3,4,5) = 0;
biTri(4,1,5) = 0; biTri(4,2,5) = 0;  biTri(4,3,5) = 0;  biTri(4,4,5) = 1;

biTri(1,1,6) = 0; biTri(1,2,6) = 0;   biTri(1,3,6) = 1; biTri(1,4,6) = 0;
biTri(2,1,6) = 0; biTri(2,2,6) = -1;  biTri(2,3,6) = 0; biTri(2,4,6) = 0;
biTri(3,1,6) = 1; biTri(3,2,6) = 0;   biTri(3,3,6) = 0; biTri(3,4,6) = 0.325;
biTri(4,1,6) = 0; biTri(4,2,6) = 0;   biTri(4,3,6) = 0; biTri(4,4,6) = 1;


jointType = [0,0,0,0,0,0];

numberOfJoints = 6;

qmin = -pi*ones(6, 1);
qmax = pi*ones(6, 1);
q = [0, 0, 0, 0, 0, 0];

goal = [0.5; 0.4; 0.5];
bTg = [[eye(3) zeros(3,1)]' [goal; 1]];

gamma_A = 0.1;
gamma_L = 0.8;

x_dot = zeros(6, 1);

error_A = zeros(3,1);
error_L = zeros(3,1);

% simulation variables 
ts = 0.1;
t_start = 0.0;
t_end = 10.0;
t = t_start:ts:t_end;

figure
hold on
xlabel('x')
ylabel('y')
zlabel('z')
axis equal
az = 48;
el = 25;
view(az, el);

cindex = 1;
csize = length(t);
cmap = colormap(parula(csize));
color = cmap(mod(cindex, csize)+1, :);

plot3(0,0,0, 'ro')
plot3(goal(1), goal(2), goal(3), 'ro')


%--------------- Kinematic Simulation ---------------%

for i = t
    
    bTi = zeros(4, 4, numberOfJoints);
    bOi = zeros(3, numberOfJoints);
    
    % Transformation matrices
    biTei = GetDirectGeometry(q, biTri, jointType);
    bTe = GetTransformationWrtBase(biTei, 6);
    
    % End-effector  jacobian
    Jn = GetJacobian(biTei, bTe, jointType);
    
    % Errors
    error_L = bTg(1:3, 4) - bTe(1:3, 4);
    error_A = VersorLemma(bTe(1:3, 1:3), bTg(1:3, 1:3));
    
    % End-effector velocity
    x_dot(1:3) = gamma_A*error_A';  
    x_dot(4:6) = gamma_L*error_L';  
    
    % Computing q_dot
    q_dot = (pinv(Jn)*x_dot)';
    
    % simulating the robot
    q = KinematicSimulation(q, q_dot, ts, qmin, qmax);
    
    % Frames origins
    for j = 1:numberOfJoints
        bOi(:,j) = GetBasicVectorWrtBase(biTei, j);
    end
    bOi = [[0;0;0], bOi];
    for j = 2:numberOfJoints+1
        plot3(bOi(1, j), bOi(2, j), bOi(3, j), 'bo');
    end
    
    % Draw the links
    color = cmap(mod(cindex, csize)+1, :);
    cindex = cindex + 1;
    hold on;
    line(bOi(1, :), bOi(2, :), bOi(3, :), 'Linewidth', 4   , 'Color', color);
     
    pause(0.1)     
end
