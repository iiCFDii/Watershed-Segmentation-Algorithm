function output1 = FloodfilloutputLabel(seed_point,image,new_color, label) %Flood fill that outputs  seperate image
    [height,width,depth] = size(image);
    if depth > 1
        image = rgb2gray(image);
    end
    double_Image = image;
    frontier = [];
    old_color = double_Image(seed_point(1,1),seed_point(1,2));   % This sets the old color to the color at the seedpoint of the image

    frontier = [frontier,seed_point];    % essentially this is forntier.push(seed_point)
    new_color;
    label(seed_point(1,1),seed_point(1,2)) = new_color;    % sets the seedpoint pixel in the output image to the new color
    
    % This while loop will go on until the section from the seedpoint is
    % completely flood filled, (until the frontier/stack is not empty)
    while (~isempty(frontier))  
        j = frontier(end);      % sets j to end of the stack value
        i = frontier(end-1);    % sets i to the end -1 stack value, i and j are our "tuple" coordinates in this case
        frontier(end) = [];     % this is essnetially performing frontier.pop, setting the end of the stack to null
        frontier(end) = [];
        for x=-1:1
            for y=-1:1      % these 2 for loops are checking the 4 nearest neighbors
                if (((i+x)>0) && ((i+x)<=height) && ((j+y)>0) && ((j+y) <=width))   % makes sure we are staying within bounderies
                        if (double_Image(i+x,j+y) == old_color && label(i+x,j+y) ~= new_color )   % if the original image pixel is = old color and the output doesnt have the new color set then we can push that coord to the stack
                            frontier = [frontier,[i+x,j+y]]; % frontier.push(coord)
                            label(i+x,j+y) = new_color;    % output of the coord = new color
                        end
                end
            end
        end

    end 
    output1 = label;
end