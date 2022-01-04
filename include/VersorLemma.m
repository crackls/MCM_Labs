%% VersorLemma function
% inputs:
% - r1: the first rotation matrix
% - r2: the second rotation matrix
% output:
% - c: the Vect3 representing the axis around which r1 should rotate to reach r2, where its modulus is the angle

function c = VersorLemma(r1, r2)
    
    % Compute cos(teta) and sin(teta)
    costh = (dot(r1(:,1),r2(:,1)) + dot(r1(:,2),r2(:,2)) + dot(r1(:,3),r2(:,3)) - 1)/2;
    sinth = (cross(r1(:,1),r2(:,1)) + cross(r1(:,2),r2(:,2)) + cross(r1(:,3),r2(:,3)))/2;
    
    % Some erroe
    delta_th = 10e-4;
    
    if (costh <= delta_th)
        % cos(teta) is ~ 0
        teta = 0;
        v = [0; 0; 0];
        
    elseif (abs(costh) < (1 - delta_th))
        % |cos(teta)| is < 1
        teta = atan2(costh, norm(sinth));
        v = (sinth)/sin(teta);
        
    else
        % cos(teta) is ~ -1
        teta = pi;
        R = r1 + r2;
        v = sum(R, 1)/norm(sum(R,1));
        
    end
    
    c = (v*teta);
end

