% Name: Christopher Ciobanu
% Date: 10/10/22
% ECPE 124 Digital Image Processing
% Program 3: Canny Edge Detection
%
% This is the Hysteresis function that performs Hysteresis and edge linking
function edge = Hysteresis(supressed)   
  [height,width,depth] = size(supressed);
    if depth > 1
        supressed = im2gray(supressed);    % converts rgb image to greyscale
    end 
    
    reshaped = reshape(supressed,height*width,1);   % turns the 2d array into a 1d
    sorted = sort(reshaped);                        % sorts in acending order
    
    t_hi = sorted(floor(height*width*0.9));         % gives the 90th percentile
    t_lo = t_hi * 0.2;                              % takes 20% of the 90th percentile as t_lo
    
    Hysteresis1 = supressed;
    
    % Within these for loops, hystersis is performed, and the stron and
    % weak edges are established 
    for i=1:height
        for j=1:width
            if Hysteresis1(i,j)>t_hi
                Hysteresis1(i,j)=255;%strong edge
            elseif Hysteresis1(i,j)>t_lo
                Hysteresis1(i,j)=125; % weak edge
            else
            Hysteresis1(i,j)=0; %non edge
            end
        end
    end
    
    % Within these for loops, edge linking is performed 
edge=Hysteresis1;
    for i=1:height
      for j=1:width
           if(Hysteresis1(i,j)==125) %weak pixel
              if(anynearest8(Hysteresis1,i,j)) %connected to any strong pixel
                edge(i,j)= 255;
              else
                edge(i,j)=0; %suppress if no strong pixel connection 
              end
           end
      end
    end
            
        

    
end 
    
    
    
