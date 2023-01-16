% Name: Christopher Ciobanu
% Date: 10/25/22
% ECPE 124 Digital Image Processing
% Program 4: Watershed Segmentation
% This is the watershed function that performs normal watershed

function label = Watershed(img)
[height,width,depth] = size(img);

% initializes the variables
frontier = [];
label=zeros(height,width);
g = cell(256,1);
globallabel = 0;

%Part a, initializez the pre array cells

for i=1:height
    for j=1:width
        g{img(i,j)+1}=[g{img(i,j)+1}; i, j];
        label(i,j) = -1;
    end
end

%part a which uses a frotnier to do the initial pixel for watershed basin

for gray=1:256
    temp_label=label;
    
    [grayH, grayW] = size(g{gray});
    for e=1:grayH
           i=g{gray}(e,1);
           j=g{gray}(e,2);
                [onoff,inew,jnew] = anynearest8re(temp_label,i,j);
                if (img(i,j) == (gray - 1) && onoff)
                    label(i,j) = label(inew,jnew);
                    frontier = [frontier,i,j];
                end
    end
 
% part b which continue to fill the basins
     
    while (~isempty(frontier))
        icoor=frontier(1);
        jcoor=frontier(2);
        frontier(1)=[];
        frontier(1)=[];
        
        for x=-1:1
            for y=-1:1
                if (((icoor+x)>0) &&  ((icoor+x)<=height) && ((jcoor+y)>0) && ((jcoor+y)<=width))   % Checks to make sure we are not over stepping boundaries
                    if (((img(icoor+x,jcoor+y)) == (gray - 1)) && label(icoor+x,jcoor+y) == -1)
                        label(icoor+x,jcoor+y) = label(icoor,jcoor);
                        frontier = [frontier,icoor+x,jcoor+y];
                    end
                end
            end
        end
        
    end

%part c which flood fills the basins
    for h=1:grayH
        igray = g{gray}(h,1);
        jgray = g{gray}(h,2);
        if ((img(igray ,jgray) == (gray-1)) && label(igray,jgray) == -1)
            label = FloodfilloutputLabel([igray,jgray],img,globallabel,label);
            globallabel = globallabel + 1;
        end
    end
    
end
end
