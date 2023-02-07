clc;
clear;
close all;

%%%READING THE IMAGE
x = imread('lena256.png');
if(size(x,3)==3)
    x=rgb2gray(x);
end
[M,N]=size(x);
figure, imshow(x);
title("Grayscale of Original Image");% Grayscale of the RGB image

%%%ADDITION OF NOISE TO THE IMAGE 
%%%salt and pepper noise addition.
spn = imnoise(x,'salt & pepper',0.02);
%Jd = double(J);
figure,imshow(spn);
title("Image with Salt and Pepper noise");
%%% Gaussian Noise addition.
gn = imnoise(x,'gaussian',0.02);
%Kd=double(K);
figure,imshow(gn);
title("Image with Amplifier noise");
xn=spn+gn; %%Image with Gaussian and Salt and Pepper noise - This is the noisy image to be denoised
figure,imshow(xn);
title("Image with SPN+GN");
%%%Another way of adding Gaussian Noise.
% mean_val=0;
% noise_std=10; %% 10,20,30,40,50.
% sizeA = size(x);
% randn('seed',662023); %%% Results depend on 'seed' of the random noise.
% xn = double(x) + (noise_std*randn(sizeA)) + mean_val;
% xn = max(0,min(xn,255));
%xn = Kd+Jd;

%%% PSNR COMPUTATION OF NOISY IMAGE
%%%Peak signal to noise Ratio
%%% Gives idea how noisy the image is compared to its original (noiseless)
%%% version
xn_mse=sum(sum((double(x)-double(xn)).^2))/(M*N);
xn_psnr=10*log10(255^2./xn_mse);

%%% DENOISING THE IMAGE
%%%There are 4 main different types of noise - 
%%%1.Amplifier Noise/Gaussian Noise
%%%2.Salt and Pepper Noise
%%%3.Poisson Noise- Shot noise
%%%4.Speckle Noise
%%%Gaussian noise is removed by linear filters - mean filtering/averaging
%%%filter or by a wiener filter.
%%%Non linear filtering - Median filter - It is a robust filter which is
%%%used to remove salt and pepper noise.

A = medfilt2(xn); % Removing salt and pepper noise
%figure,imshow(A);
%title("Image with salt and pepper noise removed");

B = imgaussfilt(A);% Removing amplifier noise
%title("Image with both noises removed");
%B = imgaussfilt(xn);
%%%Image with only amplifier noise removed (see previous statement)
figure,imshow(B); % Complete denoised image
title("Denoised image");

%%%PSNR OF THE DENOISED IMAGE
xdn_mse=sum(sum((double(x)-double(B)).^2))/(M*N);
xdn_psnr=10*log10(255^2./xdn_mse);

%%%EXTRA FILTERS - Bilateral filter,mean filter and wiener filter.

%%%BILATERAL FILTER
%%% Inspect a patch of the image, then compute the variance of the patch,
%%% which approximates the variance of noise.
%%% For bilateral filtering, the degree of smoothing must be larger than
%%% the variance of the noise
patch = imcrop(xn,[170, 35, 50 50]);
%imshow(patch)
patchVar = std2(xn)^2;
DoS = 2*patchVar;
blf = imbilatfilt(xn,DoS);
figure,imshow(blf);
title([" Degree of Smoothing :",num2str(DoS)]);

%%%MEAN FILTER
%%%Averaging filter
h = 1/256*ones(256,1); %%%256X256 mean filter
H = h*h';
%H = uint8(H);
mfilt = filter2(H,double(xn)); %mfilt has proper values but there is conflict btw double and int types,hence I'm not getting result
figure,imshow(mfilt); %% I'm not getting proper result here so pls check
title("Mean filtered Image");

%%%WIENER FILTER
wfilt = wiener2(xn,[3,3]);
figure,imshow(wfilt);
title("Wiener filtered image");

%%%Image denoising done
%%%Can add few extra features like IQI - Image quality index, but it isn't
%%%there in the syllabus