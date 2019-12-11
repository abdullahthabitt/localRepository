function [nfixed,nmoving,H_f,H_m] = normalize(fixed,moving)

% transforming all the points to the origin
mean_fixed = mean(fixed);
mean_moving = mean(moving);
mfixed = fixed - mean_fixed;
mmoving = moving - mean_moving;

% average distance from the center of the points
fixed_distance = sqrt(sum(fixed.^2));
moving_distance = sqrt(sum(moving.^2));
mean_fixed_distance = mean(fixed_distance);
mean_moving_distance = mean(moving_distance);

% making the average distance from the center of the points
% to sqrt 2
nfixed = sqrt(2) * mfixed/mean_fixed_distance;
nmoving = sqrt(2) * mmoving/mean_moving_distance;

% scaling factor
s_f = sqrt(2)/mean_fixed_distance;
s_m = sqrt(2)/mean_moving_distance;

% similarity transform matrix
H_f = [s_f 0 -s_f*mean_fixed(1); 0 s_f -s_f*mean_fixed(2); 0 0 1];
H_m = [s_m 0 -s_f*mean_moving(1); 0 s_m -s_f*mean_moving(2); 0 0 1];


end
