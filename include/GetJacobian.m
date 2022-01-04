%% GetJacobian function
% Function returning the end effector jacobian for a manipulator which current
% configuration is described by bTei.
%
% Inputs:
% - biTei : transformation matrix of link <i> w.r.t. link <i-1> for the input qi.
% - bTe: current transformation matrix from base to the end effector.
% - jointType: vector identifying the joint type, 0 for revolute, 1 for
% prismatic
%
% Output:
% - Jn: end-effector jacobian matrix

function Jn = GetJacobian(biTei, bTe, jointType)
    
    Jn = zeros(6, length(jointType));
    
    for i = 1:length(jointType)
        % Transformation matrices
        bTi = GetTransformationWrtBase(biTei, i);
        
        % Add jacobian columns
        Jn(:,i) = GetJacobianColumn(bTi, bTe, jointType(i));
    end


end
