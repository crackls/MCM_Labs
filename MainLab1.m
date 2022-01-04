%%MOCOM LAB1

clc
clear all
%close all

addpath('include');

% T del frame 1 con respecto al 0
biTri(1,1,1) = 1; biTri(1,2,1) = 0; biTri(1,3,1) = 0; biTri(1,4,1) = 0;
biTri(2,1,1) = 0; biTri(2,2,1) = 1; biTri(2,3,1) = 0; biTri(2,4,1) = 0;
biTri(3,1,1) = 0; biTri(3,2,1) = 0; biTri(3,3,1) = 1; biTri(3,4,1) = 0.175;
biTri(4,1,1) = 0; biTri(4,2,1) = 0; biTri(4,3,1) = 0; biTri(4,4,1) = 1;

% T del frame 2 con respecto al 1
biTri(1,1,2) = -1; biTri(1,2,2) = 0;  biTri(1,3,2) = 0; biTri(1,4,2) = 0;
biTri(2,1,2) = 0;  biTri(2,2,2) = 0;  biTri(2,3,2) = 1; biTri(2,4,2) = 0;
biTri(3,1,2) = 0;  biTri(3,2,2) = 1;  biTri(3,3,2) = 0; biTri(3,4,2) = 0.108;
biTri(4,1,2) = 0;  biTri(4,2,2) = 0;  biTri(4,3,2) = 0; biTri(4,4,2) = 1;

% T del frame 3 con respecto al 2
biTri(1,1,3) = 0;  biTri(1,2,3) = 0;  biTri(1,3,3) = 1;  biTri(1,4,3) = 0.105;
biTri(2,1,3) = -1; biTri(2,2,3) = 0;  biTri(2,3,3) = 0;  biTri(2,4,3) = 0;
biTri(3,1,3) = 0;  biTri(3,2,3) = -1; biTri(3,3,3) = 0;  biTri(3,4,3) = 0;
biTri(4,1,3) = 0;  biTri(4,2,3) = 0;  biTri(4,3,3) = 0;  biTri(4,4,3) = 1;

% T del frame 4 con respecto al 3
biTri(1,1,4) = 0;  biTri(1,2,4) = 1;  biTri(1,3,4) = 0;  biTri(1,4,4) = -0.1455;
biTri(2,1,4) = 0;  biTri(2,2,4) = 0;  biTri(2,3,4) = -1; biTri(2,4,4) = 0;
biTri(3,1,4) = -1; biTri(3,2,4) = 0;  biTri(3,3,4) = 0;  biTri(3,4,4) = 0.3265;
biTri(4,1,4) = 0;  biTri(4,2,4) = 0;  biTri(4,3,4) = 0;  biTri(4,4,4) = 1;

% T del frame 5 con respecto al 4
biTri(1,1,5) = 0; biTri(1,2,5) = 0;  biTri(1,3,5) = 1; biTri(1,4,5) = 0.095;
biTri(2,1,5) = 0; biTri(2,2,5) = -1; biTri(2,3,5) = 0; biTri(2,4,5) = 0;
biTri(3,1,5) = 1; biTri(3,2,5) = 0;  biTri(3,3,5) = 0; biTri(3,4,5) = 0;
biTri(4,1,5) = 0; biTri(4,2,5) = 0;  biTri(4,3,5) = 0; biTri(4,4,5) = 1;

% T del frame 6 con respecto al 5
biTri(1,1,6) = 0;  biTri(1,2,6) = 0;  biTri(1,3,6) = 1; biTri(1,4,6) = 0;
biTri(2,1,6) = 0;  biTri(2,2,6) = 1;  biTri(2,3,6) = 0; biTri(2,4,6) = 0;
biTri(3,1,6) = -1; biTri(3,2,6) = 0;  biTri(3,3,6) = 0; biTri(3,4,6) = 0.325;
biTri(4,1,6) = 0;  biTri(4,2,6) = 0;  biTri(4,3,6) = 0; biTri(4,4,6) = 1;

% T del frame 7 con respecto al 6
biTri(1,1,7) = 0; biTri(1,2,7) = 0;  biTri(1,3,7) = 1; biTri(1,4,7) = 0.132;
biTri(2,1,7) = 0; biTri(2,2,7) = -1; biTri(2,3,7) = 0; biTri(2,4,7) = 0;
biTri(3,1,7) = 1; biTri(3,2,7) = 0;  biTri(3,3,7) = 0; biTri(3,4,7) = 0;
biTri(4,1,7) = 0; biTri(4,2,7) = 0;  biTri(4,3,7) = 0; biTri(4,4,7) = 1;

numberOfSteps = 100;
numberOfLinks = 7;
linkType = zeros(1, numberOfLinks);
qSteps = zeros(numberOfLinks, numberOfSteps);


%-------------------MOVE----------------------%

qi = [0 0 0 0 0 0 0];
qf = [2 2 2 2 2 2 2];

qSteps = [linspace(qi(1), qf(1), numberOfSteps)',...
    linspace(qi(2), qf(2), numberOfSteps)',...
    linspace(qi(3), qf(3), numberOfSteps)',...
    linspace(qi(4), qf(4), numberOfSteps)',...
    linspace(qi(5), qf(5), numberOfSteps)',...
    linspace(qi(6), qf(6), numberOfSteps)',...
    linspace(qi(7), qf(7), numberOfSteps)'];

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
csize = numberOfSteps;
cmap = colormap(parula(csize));
color = cmap(mod(cindex, csize)+1, :);

plot3(0,0,0, 'ro')

for i = 1:numberOfSteps

    bOi = zeros(3, numberOfLinks);
    q = qSteps(i, 1:numberOfLinks)';
    
    % Transformation matrices
    biTei = GetDirectGeometry(q, biTri, linkType);
    
    % Frames origins
    for j = 1:numberOfLinks
        bOi(:,j) = GetBasicVectorWrtBase(biTei, j);
    end
    bOi = [[0;0;0], bOi];
    for j = 2:numberOfLinks+1
        plot3(bOi(1, j), bOi(2, j), bOi(3, j), 'bo');
    end
    
    % Draw the links
    color = cmap(mod(cindex, csize)+1, :);
    cindex = cindex + 1;
    hold on;
    line(bOi(1, :), bOi(2, :), bOi(3, :), 'Linewidth', 4   , 'Color', color);
     
    pause(0.1)
end

