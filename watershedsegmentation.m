function [ output_args ] = watershedsegmentation ( I )
%WATERSHEDSEGMENTATION Segment an image using the watershed algorithm
%   This function performs segmentation on a grayscale image using the
%   watershed algorithm. The image is preprocessed, and various
%   morphological operations are applied to enhance the segmentation.


I = imread('Enter the path of the image'); % Read the input image


I = rgb2gray(I); % Convert the image to grayscale


I = im2double(I); % Convert the image to double precision


figure; % Create a new figure for displaying results


subplot(4,3,1);
imshow(I), title('Original Image'); % Display the original image
text(732,501,'Image courtesy of Corel(R)','FontSize',7,'HorizontalAlignment','right');


hy = fspecial('sobel'); % Create Sobel filters for edge detection
hx = hy';


Iy = imfilter(double(I), hy, 'replicate'); % Apply the Sobel filters to the image to get gradients
Ix = imfilter(double(I), hx, 'replicate');


gradmag = sqrt(Ix.^2 + Iy.^2); % Compute the gradient magnitude


subplot(4,3,2);
imshow(gradmag,[]), title('Gradient magnitude (gradmag)'); % Display the gradient magnitude


L = bwlabel(watershed(gradmag)); % Perform the watershed transform on the gradient magnitude


Lrgb = label2rgb(L); % Convert the label matrix to RGB for better visualization


subplot(4,3,3);
imshow(Lrgb), title('Watershed transform of gradient magnitude (Lrgb)'); % Display the watershed transform result


se = strel('disk', 20, 0); % Create a structuring element (disk of radius 20)


Io = imopen(I, se); % Perform morphological opening on the image


subplot(4,3,4);
imshow(Io), title('Opening (Io)'); % Display the result of opening


Ie = imerode(I, se); % Perform morphological erosion on the image


Iobr = imreconstruct(Ie, I); % Perform morphological reconstruction


subplot(4,3,5);
imshow(Iobr), title('Opening-by-reconstruction (Iobr)'); % Display the result of opening by reconstruction


Ioc = imclose(Io, se); % Perform morphological closing on the opened image


subplot(4,3,6);
imshow(Ioc), title('Opening-closing (Ioc)'); % Display the result of opening-closing


Iobrd = imdilate(Iobr, se); % Perform morphological dilation on the opened-by-reconstruction image


Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr)); % Perform reconstruction using the complemented image
Iobrcbr = imcomplement(Iobrcbr);


subplot(4,3,7);
imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)'); % Display the result of opening-closing by reconstruction


fgm = imregionalmax(Iobrcbr); % Detect regional maxima in the reconstructed image


subplot(4,3,8);
imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)'); % Display the regional maxima


I2 = I;
I2(fgm) = 255; % Superimpose the regional maxima on the original image


subplot(4,3,9);
imshow(I2), title('Regional maxima superimposed on original image (I2)'); % Display the regional maxima superimposed on the original image


se2 = strel(ones(5,5)); % Create another structuring element (5x5 square)


fgm2 = imclose(fgm, se2); % Perform morphological closing on the regional maxima


fgm3 = imerode(fgm2, se2); % Perform morphological erosion on the closed regional maxima


fgm4 = bwareaopen(fgm3, 20); % Remove small objects from the binary image


I3 = I;
I3(fgm4) = 255; % Superimpose the modified regional maxima on the original image


subplot(4,3,10);
imshow(I3), title('Modified regional maxima superimposed on original image (fgm4)'); % Display the modified regional maxima superimposed on the original image

end

