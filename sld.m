%
% Written by Vinay Williams 
%
% Written on 5th February 2022
%
% Solar Limb Darkening
%
% Mandatory Inputs
%
% Optional Inputs
%
% Outputs

function sld(varargin)

    close all; 

	dist = 147.72e6;	% Simulation distance
	unit = 147.72e6;	% Unit to use [Default = Au]
	unit_name = "Au";	% Name of the units
	ds = 1e4; 		    % Simulation interval [Default = 100km]
	dr = 1;			    % Limb darkening interval [Default = 1km]
	sun_radius = 696340;% Radius of the radiating body [Default = Solar Radius]
	
	% Add the submodule repos
	addpath("./visible_area");
	addpath("./intensity_blackbody");

	% Process arguments
	n=1;
	while n < size(varargin,2)
		strval = lower(varargin{n});
		switch strval
		case "distance"
			n=n+1;
			dist = varargin{n};
		case "units"
			n=n+1;
			unit = varargin{n};
			n=n+1;
			unit_name = varargin{n};
		case "interval"
			n=n+1;
			ds = varargin{n};
		end	
		n=n+1;
	end


	% Initialise arrays
	[distance, vis_area, intensity, radius, theta] = deal(0:(dist/ds)-1);

    % Plotting
	figure(1);
    num = 6;
    
    subplot(num, 1,1)
	% Calculation loop
	for h = ds:ds:dist
		indx = h/ds;
		distance(indx) = h;
		vis_area(indx) = visible_area(sun_radius,h);
		intensity(indx) = intensity_blackbody(h);
        radius(indx) = sqrt(vis_area(indx)/pi);
        theta(indx) = acos(sqrt((sun_radius^2 - radius(indx)^2)/sun_radius^2));
        [ldi, angles] = limb_darkening_intensities(intensity(indx), theta(indx));
        
        
        plot(angles, ldi, "Color", "black")
        drawnow
        hold on
        
    end

	

	subplot(num,1,6);
	plot(distance./unit, vis_area, ".", "Color", "black");
	xlabel("Distance ["+unit_name+"]");
	ylabel("Visible Area [km^2]");

    subplot(num,1,2);
	plot(distance./unit, radius, ".", "Color", "black");
	xlabel("Distance ["+unit_name+"]");
	ylabel("Radius of Visible Area [km]");

	subplot(num,1,3);
	plot(distance./unit, intensity, ".", "Color", "black");
	xlabel("Distance ["+unit_name+"]");
	ylabel("Intensity W/m^2");

    subplot(num,1,4);
	plot(log(distance./unit), log(intensity), ".", "Color", "black");
	xlabel("log Distance");
	ylabel("log Intensity");


    subplot(num,1,5);
	plot(distance./unit, theta, ".", "Color", "black");
	xlabel("Distance");
	ylabel("Maximum Internal Angle");

	
end
