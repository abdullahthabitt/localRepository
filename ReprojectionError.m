function [Error] = ReprojectionError(fixed,moving,H)
%%


% Calculating Error from moving to fixed
% STEP 1: We make the matrix square so that it is matrix 
%         Multiplication compliant.

col_ones = ones(1,size(moving,1));
moving_to_fixed = [moving';col_ones];
T_moving_to_fixed = H*moving_to_fixed;

%STEP 2: Scale to find the correct transformation
Scaled_T_moving_to_fixed = T_moving_to_fixed(1:2,:)./T_moving_to_fixed(3,:);

%STEP 3: Calculate the error in moving to fixed transformation
error_moving_to_fixed = sqrt(sum((fixed - Scaled_T_moving_to_fixed').^2,2));
error_moving_to_fixed = mean(error_moving_to_fixed);
% Calculating Error from fixed to moving
% STEP 1: We make the matrix square so that it is matrix 
%         Multiplication compliant.

col_ones = ones(1,size(fixed,1));
fixed_to_moving = [fixed';col_ones];
T_fixed_to_moving = inv(H)*fixed_to_moving;

%STEP 2: Scale to find the correct transformation
Scaled_T_fixed_to_moving = T_fixed_to_moving(1:2,:)./T_fixed_to_moving(3,:);

%STEP 3: Calculate the error in moving to fixed transformation
error_fixed_to_moving = sqrt(sum((moving - Scaled_T_fixed_to_moving').^2,2));

% Total Error is the sum of fixed_to_moving and moving_to_fixed error
Error = error_moving_to_fixed + error_fixed_to_moving;


end

