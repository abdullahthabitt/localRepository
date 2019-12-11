function H = computeHomography(fixed,moving,transform_type)
% a function that compute the homography matrix needed to register a pair
% of Nx2 features.
% Inputs:
%   fixed          - Nx2 features (key points) of the fixed image
%   moving         - Nx2 features (key points) of the moving image
%   transform_type - string specifying the type of transorform can be
%   "Projective", "Affine", "Similarity", or "Euclidian"
%
% return:
%   H   -  the homography matarix (3x3)


% Total number of matched keypoints
num = size(fixed,1);

% transforming in [x y x y] form
fixed_imf = [fixed(:,1)'; fixed(:,2)'];
fixed_imf = fixed_imf(:);


% Calculating the homographic estimation

% Projective Transform has 8 Degrees of Freedom
% Hence 8 terms to be estimated
if transform_type == "Projective"
    matrix = [];
    for i=1:num
        x_m = moving(i,1);
        y_m = moving(i,2);
        x_f = fixed(i,1);
        y_f = fixed(i,2);
        matrix = [matrix;[x_m y_m 1 0 0 0 -x_f*x_m -x_f*y_m]];
        matrix = [matrix;[0 0 0 x_m y_m 1 -y_f*x_m -y_f*y_m]];
    end

    H = matrix \ fixed_imf;
    H = [H(1) H(2) H(3); H(4) H(5) H(6); H(7) H(8) 1];

% Affine Transformation has 6 Degrees of Freedom 
% Hence 6 terms to be estimated
    elseif transform_type == "Affine"
    matrix = [];
    for i=1:num
        x_m = moving(i,1);
        y_m = moving(i,2);
        matrix = [matrix ;[x_m y_m 1 0 0 0]];
        matrix= [matrix ;[0 0 0 x_m y_m 1]];
    end

        H = matrix \ fixed_imf;
        H = [H(1) H(2) H(3); H(4) H(5) H(6); 0 0 1];

% Similarity Transform has 4 degrees of freedom
% Hence 3 terms to be estimated
    elseif transform_type == "Similarity"
        matrix = [];
        for i=1:num
            x_m = moving(i,1);
            y_m = moving(i,2);
            matrix = [matrix ;[x_m -y_m 1 0]];
            matrix = [matrix ;[y_m x_m 0 1]];
        end
        
        H = matrix \ fixed_imf;
        H = [H(1) -H(2) H(3); H(2) H(1) H(4); 0 0 1];

% Eucleadian has 3 degrees of freedom which is basically
% the Similarity transform but the s term is removed

    elseif transform_type == "Euclidean"
        matrix = [];
        for i=1:num
            x_m = moving(i,1);
            y_m = moving(i,2);
            matrix = [matrix ;[x_m -y_m 1 0]];
            matrix = [matrix ;[y_m x_m 0 1]];
        end
        
        H = matrix \ fixed_imf;

        scale = sqrt(H(1)^2 + H(2)^2);
        H(1) = H(1)/scale;
        H(2) = H(2)/scale;

        H = [H(1) -H(2) H(3); H(2) H(1) H(4); 0 0 1];
        
end

