% Name: Christopher Ciobanu
% Date: 10/10/22
% ECPE 124 Digital Image Processing
% Program 3: Canny Edge Detection
%
% This is the anynearest8 function which determines if any pixels around
% a center pixel are set to 255. 
function onoff = anynearest8(Hystersis,i,j)   
  [height,width,depth] = size(Hystersis);
    if depth > 1
        Hystersis = im2gray(Hystersis);    % converts rgb image to greyscale
    end 
    
    
    if ((i-1)>0 &&  (i+1)<=height && (j-1)>0 && (j+1)<=width)   % Checks to make sure we are not over stepping boundaries

        if (Hystersis(i-1,j) == 255 || Hystersis(i+1,j)== 255 || Hystersis(i,j+1)== 255 || Hystersis(i,j-1)== 255 || Hystersis(i+1,j+1)== 255 || Hystersis(i-1,j+1)== 255 || Hystersis(i-1,j-1)== 255 || Hystersis(i+1,j-1)== 255)
            onoff = true; 
        else
            onoff = false; 
        end
    else
        onoff = false;
    end
    
    
end 
        