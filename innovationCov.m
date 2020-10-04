function PK1vv = innovationCov(gammaK1,yK1,lambda,mag_sd,n)
    % Eq. (11)
	% Find the output covariance
	% Eq. (11) intermediate step, used also for Eq. (13)
	P_in2 = gammaK1(:,:) - repmat(yK1,1,2*n+1);
        
        
	% Eq. (11) concluding step
	% If only the magnetometer is in use for measurement, PK1yy is a 
	%   3x3 matrix.
	PK1yy = (lambda*P_in2(:,2*n+1)*transpose(P_in2(:,2*n+1)) + ...
        0.5*sum((P_in2(:,1:(2*n))*transpose(P_in2(:,1:(2*n)))),2))/...
        (n+lambda);
        
        
	% TODO: Figure out how to find the standard deviation for the 
	%   magnetometer measurement. 
	%   Equations (12), (23), and (24) may be helpful. Per Eq. (24), 
	%   RK1 seems to be dependent on the variances of the measurement 
	%   noise. For one sensor, Eq. (24) seems to give a scalar RK1, 
	%   which would not work with Eq. (12), so we just set RK1 equal to
	%   the value in Eq. (23b), and are hoping that is correct.
    % The paper mentions that actual field errors have systematic
    %   components, but modeling the errors as a single standard deviation
    %   works well for the filter.
        
	RK1 = (mag_sd^2)*eye(3);
        
	% Eq. (12)
	% Find the innovation covariance
	PK1vv = PK1yy + RK1;
end