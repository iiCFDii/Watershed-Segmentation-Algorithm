% Name: Christopher Ciobanu
% Date: 10/10/22
% ECPE 124 Digital Image Processing
% Program 3: Canny Edge Detection
%
% This is the NonMaxSuppression which takes the magnitude image and
% performs non maximal suppression
function supressed = NonMaxSuppression(Magnitude,Gradient)   
  [height,width] = size(Magnitude);
%     if depth > 1
%         Magnitude = im2gray(Magnitude);    % converts rgb image to greyscale
%         Gradient = im2gray(Gradient);    % converts rgb image to greyscale
%     end 
supressed = zeros(height,width);

    for i=1:height
        for j=1:width
            
             theta = Gradient(i,j);     % Takes the theta value stored in the gradient.
             if theta < 0
                 theta = theta + pi;    % adds pi to the radiant    
             end
             theta = (180/pi) * theta;  % converts from radiant to degree
             
             if ((i-1)>0 &&  (i+1)<=height && (j-1)>0 && (j+1)<=width)   % Checks to make sure we are not over stepping boundaries
                        
                    % These if statements determine which pixels are
                    % important/kept and which are eliminated based on the degree and surrounding pixels
                     if (theta <= 22.5 || theta > 157.5)
                        if  ((Magnitude(i,j) < Magnitude(i-1,j)) || (Magnitude(i,j) < Magnitude(i+1,j)))
                             supressed(i,j) = 0;
                        else 
                             supressed(i,j) = Magnitude(i,j);
                        end

                     elseif (theta > 22.5 && theta <= 67.5)
                        if  ((Magnitude(i,j) < Magnitude(i-1,j-1)) || (Magnitude(i,j) < Magnitude(i+1,j+1)))
                            supressed(i,j) = 0;
                        else 
                            supressed(i,j) = Magnitude(i,j);                            
                        end 

                     elseif (theta > 67.5 && theta <= 112.5)
                        if  ((Magnitude(i,j) < Magnitude(i,j-1)) || (Magnitude(i,j) < Magnitude(i,j+1)))
                            supressed(i,j) = 0;                          
                        else 
                           supressed(i,j) = Magnitude(i,j);
                        end 

                     elseif (theta > 112.5 && theta <= 157.5)
                        if  ((Magnitude(i,j) < Magnitude(i-1,j+1)) || (Magnitude(i,j) < Magnitude(i+1,j-1)))
                            supressed(i,j) = 0;                            
                        else 
                            supressed(i,j) = Magnitude(i,j);
                        end 

                     end
             else 
                supressed(i,j) =  Magnitude(i,j);
             end
        end  
    end
      
end