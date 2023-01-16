% Name: Christopher Ciobanu
% Date: 10/10/22
% ECPE 124 Digital Image Processing
% Program 3: Canny Edge Detection
%
% This is the MagnitudeGradient function that calculates the Magnitude and
% Gradient of the horizontal and vertical images.
function [Magnitude, Gradient] = MagnitudeGradient(Horizontal,Vertical)
    [height,width,depth] = size(Horizontal);
    if depth > 1
        Horizontal = im2gray(Horizontal);    % converts rgb image to greyscale
        Vertical = im2gray(Vertical);    % converts rgb image to greyscale
    end 
    
    % This loop calculates the magnitude using the horizontal and vertical
    % images and the Gradient as well. 
    for i=1:height
        for j=1:width
         Magnitude(i,j) = sqrt(Vertical(i,j)*Vertical(i,j) + Horizontal(i,j)*Horizontal(i,j));   
         Gradient(i,j)= atan2(Horizontal(i,j),Vertical(i,j));
        end  
    end
      
end