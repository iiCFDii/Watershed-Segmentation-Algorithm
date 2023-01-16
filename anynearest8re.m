% Name: Christopher Ciobanu
% Date: 10/10/22
% ECPE 124 Digital Image Processing
% Program 3: Canny Edge Detection
%
% This is the anynearest8 function which determines if any pixels around
% a center pixels are on. 
function [onoff,inew,jnew] = anynearest8re(image,i,j)   
  [height,width] = size(image);
    
    onoff = false;
    inew = i;
    jnew = j; 
    if ((i-1)>0 &&  (i+1)<=height && (j-1)>0 && (j+1)<=width)   % Checks to make sure we are not over stepping boundaries
       for x=-1:1
           for y=-1:1
               if( image(i+x,j+y) >= 0)
                  onoff = true;
                  inew = i+x;
                  jnew = j+y;
                  return; 
               end
           end
       end      
    else
         inew = i;
         jnew = j;
    end
    
    
end 