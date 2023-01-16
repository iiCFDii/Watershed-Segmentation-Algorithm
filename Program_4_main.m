% Name: Christopher Ciobanu
% Date: 10/19/22
% ECPE 124 Digital Image Processing
% Program 4: Watershed Segmentation
% How to Use Testing Script: Hit Run at the Top of Matlab and press 1 for
% "normal watershed" and 2 for marker based watershed and then select the
% input image. Hit 7 to exit the program.
%For the holes.pgm to work leave the script as is (threshold values on line 80 should be 80,120), 
%for the cells_small.pgm to work change the threshold values on line 80 to
%100, 200

x1 = "1: Section 1 (Normal Watershed)";
x2 = "2: Section 2 (Watershed Segmentation using markers)";
x7 = "7: Exit Program";
selection= true;

% This is the Main while loop that runs the selection menu
while selection
    % Prints Selection menu
    disp(x1)
    disp(x2)
    disp(x7)
    
    % Switch statement that allows for different selections
    n = input('Enter section you would like to Test:');
    switch n
        case 1 % This case performs normal watershed segmentation on an image
            [FileName,FilePath]=uigetfile('*');          % Reads in File  
            image1 = imread(strcat(FilePath,FileName));  % Reads in File
            sigma = 0.6;
            
            figure
            imshow(image1)
            title('Original Image')
            
            [G,w] = Gaussian(sigma);
            [Gderiv,w] = Gaussian_Deriv(sigma);

            % performs convolution to create vertical and horizontal images
            image_h_in = convolve(image1,G');
            image_h = convolve(image_h_in,Gderiv);

            image_v_in = convolve(image1,G);
            image_v = convolve(image_v_in,Gderiv');

            [Magnitude, Gradient] = MagnitudeGradient(image_h,image_v);
            
            Quantized_Magnitude=uint8(Magnitude); 
            figure
            imshow(double(Quantized_Magnitude))
            title('Normal Watershed: Magnitude')
            
            label=Watershed(Quantized_Magnitude);
            Lshow=(255*label)/(max(max(label)));
            figure
            imshow(uint8(Lshow))
            title('Normal Watershed: Labels')
            
        case 2 % This case performs Marker Based WaterShed
            [FileName,FilePath]=uigetfile('*');          % Reads in File  
            image1 = imread(strcat(FilePath,FileName));  % Reads in File
%           n = input('Select Sigma Value (Default = 0.6): ');  % get sigma value from user input
            sigma = 0.6; % n
            figure
            imshow(image1)
            title('Original Image')
            
            [G,w] = Gaussian(sigma);
            [Gderiv,w] = Gaussian_Deriv(sigma);

            % performs convolution to create vertical and horizontal images
            image_h_in = convolve(image1,G');
            image_h = convolve(image_h_in,Gderiv);

            image_v_in = convolve(image1,G);
            image_v = convolve(image_v_in,Gderiv');

            [Magnitude, Gradient] = MagnitudeGradient(image_h,image_v);
            
            Quantized_Magnitude=uint8(Magnitude); 
            figure
            imshow(double(Quantized_Magnitude))
            title('Marker Watershed: Magnitude')
            
            water_threshold = double(ThresholdDoubleWater(image1,80,120));

            water_threshold = (water_threshold - 255)* -1;
            water_threshold = uint8(water_threshold);  

            figure
            imshow(water_threshold)
            title('Marker Watershed: Threshold')

            chamfer = Chamfer_Distance(water_threshold);

            figure
            imshow(uint8(chamfer*3))
            title('Marker Watershed: Chamfer SSD Map')
            
            water_chamfer=Watershed(chamfer);
            Lshow=(255*water_chamfer)/(max(max(water_chamfer)));
            figure
            imshow(uint8(Lshow))
            title('Marker Watershed: Watershed of Chamfer')
            
            image_hin = convolve(water_chamfer,G');
            image_h = convolve(image_hin,Gderiv);

            image_vin = convolve(water_chamfer,G);
            image_v = convolve(image_vin,Gderiv');
            
            [Magnitude1, Gradient1] = MagnitudeGradient(image_h,image_v);
            supressed = NonMaxSuppression(Magnitude1,Gradient1);
   
            edge = Hysteresis(supressed);
            figure
            imshow(edge)
            title('Marker Watershed: Edges separating objects')
            
            marker = double(water_threshold) + edge;
            [heightm,widthm] = size(marker);
            for i=1:heightm
                for j=1:widthm
                   if marker(i,j) > 255
                      marker(i,j) = 255; 
                   end
                end
            end
            figure
            imshow(marker)
            title('Marker Watershed: Watershed Marker')
            
            [final,cc_img] = WatershedMarker(marker,Quantized_Magnitude);
            
            figure
            imshow(uint8(cc_img))
            title('Marker Watershed: CC Image')
            
            figure
            imshow(uint8(final))
            title('Marker Watershed: Label Image')
            
            
        case 7 % This case exits the program
            disp("Exiting Program...")
            selection = false;
            disp("GoodBye")
        otherwise
            disp("Please Select a Valid Character 1,2, or 7")
    end
end
