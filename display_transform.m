function  display_transform(image_1,image_2,H,Error)

transformation = projective2d(transpose(H));
frame = imref2d(size(image_1));
[output, Rregistered] = imwarp(image_2,transformation,'OutputView',frame);


figure;
subplot(1,3,1)
imshow(image_1)
title('Original Image')

subplot(1,3,2)
imshow(image_2)
title('Moving Image')

subplot(1,3,3)
imshow(output)
title('Transformed Image')

Itransf=uint8(output);
new_img=cat(3, zeros(size(Itransf)), Itransf, image_1);

figure;
imshow(new_img)
title(['R.E = ' num2str(Error)])

Itransf=uint8(output);
new_img=cat(3, zeros(size(Itransf)), Itransf, image_2);

% figure;
% imshow(new_img)
% title('Overlayed Transformed Image on Moving Image')

end

