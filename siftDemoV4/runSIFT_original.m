clear, clc,
image = "skin2.jpg";
tic;
[img, descriptors, locs] = sift(image);
toc;

locs = locs';
descriptors = descriptors';
%visualize a random selection of 50 features:

figure(2) ; clf ;
imagesc(single(img)) ; colormap gray ; hold on ;

perm = randperm(size(locs,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(locs(:,sel)) ;
h2 = vl_plotframe(locs(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
h3 = vl_plotsiftdescriptor(descriptors(:,sel),locs(:,sel)) ;
set(h3,'color','g') ;

%%
img_vl=single(rgb2gray(imread(image)));
tic;
[f_image,d_image] = vl_sift(img_vl, 'PeakThresh', 1,'edgethresh', 2);
toc;
%visualize a random selection of 50 features:

figure(1) ; clf ;
imagesc(single(img_vl)) ; colormap gray ; hold on ;

perm = randperm(size(f_image,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(f_image(:,sel)) ;
h2 = vl_plotframe(f_image(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
h3 = vl_plotsiftdescriptor(d_image(:,sel),f_image(:,sel)) ;
set(h3,'color','g');
%%
showkeys(image, locs)
% [fixed,moving] = match("skin1.jpg", "skin2.jpg");
% im = appendimages("retina1.png", "retina2.png");
locs = locs';
descriptors = descriptors';


im2 = imread("skin2.jpg");
[fa, da] = vl_sift(im2single(rgb2gray(im1)));
[fb, db] = vl_sift(im2single(rgb2gray(im2)));
[matches, scores] = vl_ubcmatch(da, db);

im1 = imread("skin1.jpg");
img_vl=single(rgb2gray(im1)) ;
[f_image_right,d_image_right] = vl_sift(img_vl) ;

 
%visualize a random selection of 50 features:

figure(1) ; clf ;
imagesc(single(img_vl)) ; colormap gray ; hold on ;

perm = randperm(size(f_image,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(f_image(:,sel)) ;
h2 = vl_plotframe(f_image(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
h3 = vl_plotsiftdescriptor(d_image(:,sel),f_image(:,sel)) ;
set(h3,'color','g');


%visualize a random selection of 50 features:

figure(1) ; clf ;
imagesc(single(img)) ; colormap gray ; hold on ;

perm = randperm(size(locs,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(locs(:,sel)) ;
h2 = vl_plotframe(locs(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
h3 = vl_plotsiftdescriptor(descriptors(:,sel),locs(:,sel)) ;
set(h3,'color','g') ;











I = vl_impattern('roofs1') ;
imshow(I) ;

figure;
imshow(rgb2gray(im2))
[f, d] = vl_sift(im2single(rgb2gray(im2)));
perm = randperm(size(f,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(f(:,sel)) ;
h2 = vl_plotframe(f(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
