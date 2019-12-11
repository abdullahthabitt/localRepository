function H = computeransachomography(fixed,moving,trans_type,threshold)


% Defining the required number of points
switch trans_type
    case "Projective"
        req_points = 4;
        disp('DOF 8')
    case "Affine"
        req_points = 3;
        disp('DOF 6')
    case "Similarity"
        req_points = 2;
        disp('DOF 3')
    case "Euclidean"
        req_points = 2;
        disp('DOF 2')
end


% Defining the iterations, distance and percentage of inside points

itermax = 10000; % Maximum Number of Iterations
percentinside = 0.85; % Percentage of points before the for loop is broken
num = size(fixed,1); % Total Number of Points


% Storing the max number of points in the threshold
index_sol = 0; % storing the index of the selected points during Ransac
num_sol = 0; % Total Number of Inlier Points.

for i=1:itermax

    % Randomly select the minimum number of points required
    chosen_points = randperm(num, req_points);

    % chosen fixed and moving points
    fixed_chosen = fixed(chosen_points,:);
    moving_chosen = moving(chosen_points,:);
    
    % Computing Homography
    H = computeHomography(fixed_chosen, moving_chosen, trans_type);

    % transform the moving points and calculate error with the moving
    % points
    dist_diff = cal_reprojection_error(fixed,moving,H);

    
    % Threshold the Reprojection error to detect the index of the points
    % which turn out to be inliers in the threshold distance
    candidates = dist_diff < threshold;
    num_cand = sum(candidates);

    % Caculate the percentage of inliers
    candp = num_cand/size(fixed,1);

    % If the percentage of points is reached, BREAK
    if candp > percentinside
        index_sol = candidates;
        break;
    end

    % Save the best points if they are greater than the current best
    if candp > num_sol
        index_sol = candidates;
        num_sol = candp;
    end   
end


% Inlier points are used to compute the best homography matrices
fixed_final = fixed(index_sol,:);
moving_final = moving(index_sol,:);

% Calculating the Homography Matrix
H = computeHomography(fixed_final, moving_final, trans_type);

% Displaying the total number of selected
disp('Calculated:')
sum(index_sol)

end

% Calculate the Reprojection Error.
function [reprojectionerror] = cal_reprojection_error(fixed,moving,H)
    matrix_H = [moving'; ones(1,length(moving))];
    moving_new = H * matrix_H;
    moving_new = moving_new(1:2,:)./moving_new(3,:);

    moving_new = moving_new(1:2,:)';
    distance = (fixed - moving_new).^2;
    reprojectionerror = sum(distance, 2);
end

