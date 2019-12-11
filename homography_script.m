%% Clearing Everything
% [IMPORTANT] : Before running the cells make sure you add the datset folders, siftDemoV4
% and vlfeat-0.9.21 (folders and subfolders) to the path
close all
clear all
clc
%% 4.1 : Initial Testing 
% Use these to select the images from the feature vectors
% Range from 0 to 3
clear all
close all
clc

set_fixed = 0;
set_moving = 3;

% Loading the Features
mat_file = load("Features.mat");
images = ["00.png","01.png","02.png","03.png"];

% Loading the files
fixed = mat_file.Features(set_fixed+1).xy;
moving = mat_file.Features(set_moving+1).xy;

nimage_1 = images(set_fixed+1);
nimage_2 = images(set_moving+1);

% Reading the images
image_1 = rgb2gray(imread(nimage_1));
image_2 = rgb2gray(imread(nimage_2));

% Computing Homography
H = computeHomography(fixed,moving,'Projective')


% Displaying the transform
Error = ReprojectionError(fixed,moving,H)
display_transform(image_1,image_2,H,Error)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 5.1 Testing with Images - Homography unnormalized without RANSAC
close all 
clc 
clear all
% Reading the images
nimage_1 = "retina1.png";
nimage_2 = "retina2.png";

fixed_img = rgb2gray(imread(nimage_1));
moving_img = rgb2gray(imread(nimage_2));
% Getting Feature Vectors
[fixed , moving] =  get_feat_vect(nimage_1,nimage_2,"vl_sift");

% Computing Homography
H = computeHomography(fixed,moving,'Projective')

% Displaying the transform
Error = ReprojectionError(fixed,moving,H)
display_transform(fixed_img,moving_img,H,Error)

%% 5.3 Testing with Images - Homography unnormalized with` RANSAC

close all 
clc 
clear all
% Reading the images
nimage_1 = "retina1.png";
nimage_2 = "retina2.png";

fixed_img = rgb2gray(imread(nimage_1));
moving_img = rgb2gray(imread(nimage_2));

% Getting Feature Vectors
[fixed , moving] =  get_feat_vect(nimage_1,nimage_2,"vl_sift");

% Computing Homography
threshold = 0.1;
H = computeransachomography(fixed,moving,"Projective",threshold)

% Displaying the transform
Error = ReprojectionError(fixed,moving,H)
display_transform(fixed_img,moving_img,H,Error)

%% 5.4 Testing with Images - Homography normalized with` RANSAC

close all 
clc 
clear all
% Reading the images
nimage_1 = "retina1.png";
nimage_2 = "retina2.png";

fixed_img = rgb2gray(imread(nimage_1));
moving_img = rgb2gray(imread(nimage_2));

% Getting Feature Vectors
[fixed , moving] =  get_feat_vect(nimage_1,nimage_2,"vl_sift");
[nfixed,nmoving,H_f,H_m] = normalize(fixed,moving);

threshold = 0.000001;
% Computing Homography
H_new = computeransachomography(nfixed,nmoving,"Projective",threshold)
H = inv(H_f) * H_new * H_m;


Error = ReprojectionError(fixed,moving,H)

% Displaying the transform
Error = ReprojectionError(fixed,moving,H)
display_transform(fixed_img,moving_img,H,Error)













