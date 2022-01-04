%% GetDirectGeometryFunction
%inputs: 
% - q : links current position; 
% - biTri : vector of matrices containing the transformation matrices of link <i> w.r.t. link <i-1> for q=0. The size of biTri is (4,4,numberOfLinks)];
% - linkType: vector of size numberOfLinks identifying the joint type: 0 for revolute, 1 for
% prismatic.
% outputs:
% - biTei: vector of matrices containing the transformation matrices of link <i> w.r.t. link <i-1> for the input q. The
% size of biTei is equal to (4,4,numberOfLinks).

function [biTei] = GetDirectGeometry(q, biTri, linkType)
    
    numberOfLinks = length(linkType);
    biTei = zeros(4, 4, numberOfLinks);
    
    for i = 1:numberOfLinks
        biTei(1:4,1:4, i) = DirectGeometry(q(i), biTri(:,:, i), linkType);
    end
    
end