function [fixed_imf,moving_imf] = get_feat_vect(fixed_img,moving_img,type)


if type == "vl_sift"
    
    % read the images and convert them to gray scale
    fixed_img = rgb2gray(imread(fixed_img));
    moving_img = rgb2gray(imread(moving_img));

    % Calulating the keypoint locations in both images
    [fixed_kp,fixed_desc] = vl_sift(im2single(fixed_img)) ;
    [moving_kp,moving_desc] = vl_sift(im2single(moving_img)) ;

    % Retreiving the matched result from both the images
    [matched_result, temp] = vl_ubcmatch(fixed_desc,moving_desc) ;

    % Using only the matched keypoints
    fixed_imf = fixed_kp(1:2,matched_result(1,:))';
    moving_imf = moving_kp(1:2,matched_result(2,:))';
elseif type == "sift"
    [fixed_imf, moving_imf] = match(fixed_img, moving_img);
end

end


