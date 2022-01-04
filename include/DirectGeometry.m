%% DirectGeometry Function 
% inputs: 
% - qi : current links position;
% - biTri: transformation matrix of link <i> w.r.t. link <i-1> for qi=0; 
% - jointType: 0 for revolute, 1 for prismatic;
% output:
% biTei : transformation matrix of link <i> w.r.t. link <i-1> for the input qi.

function biTei = DirectGeometry(qi, biTri, linkType)
    
    teta = qi;
    
    if linkType == 0        % If revolute 
        
        Mat_z_theta = [cos(teta)    -sin(teta)     0     0;
                       sin(teta)    cos(teta)      0     0;
                       0            0              1     0;
                       0            0              0     1];
                   
    elseif linkType == 1    % If prismatic
        
        Mat_z_theta = [1    0    0     0;
                       0    1    0     0;
                       0    0    1     teta;
                       0    0    0     1];
    end
    
    % Compute the new matrix
    biTei = biTri*Mat_z_theta;
    
end