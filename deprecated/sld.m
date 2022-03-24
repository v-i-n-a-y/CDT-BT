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
	ds = 1e5; 		    % Simulation interval [Default = 100km]
	dr = 1;			    % Limb darkening interval [Default = 1km]
	sun_radius = 696340;% Radius of the radiating body [Default = Solar Radius]
	flag_plot = true;
	% Add the submodule repos
	addpath("./visible_area");
	addpath("./intensity_blackbody");
	addpath("./functions");

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
	[distance, vis_area, intensity, radius, theta, force] = deal(0:(dist/ds)-1);

    if flag_plot == true
    % Plotting
	figure(1);


    end
    
	% Calculation loop
    for h = ds:ds:dist
        
        % Determine index
		indx = h/ds;

        % Calculate distance, visible area, intensity, radius, internal
        % angle
		distance(indx) = h;
		vis_area(indx) = visible_area(sun_radius,h);
		intensity(indx) = intensity_blackbody(h);
        radius(indx) = sqrt(vis_area(indx)/pi);
        theta(indx) = acos(radius(indx)/sun_radius);
        
        if flag_plot == true

            %Get limb darkening ratios
            [ldr, angles] = limb_darkening_intensities(intensity(indx), theta(indx));
            
            ldr1 = ldr(length(ldr));
            
            for i = 1:length(ldr)
                r = cos(angles(i))*sun_radius;
                ldr(i) = ldr(i)/(sun_radius^2 - (sun_radius-r)^2);
            end

            ldr2 = ldr;
    
            % Compute colour map
            angles = angles ./ max(angles);
            ldr = ldr ./ max(ldr);
    
	        clrs = zeros(length(angles), 3);
	        clrs(:,2) = ldr';
            clrs(:,1) = ldr';
    
            mx = 1;
            mi = 0;
    
            % Create colour map and adjust brightness
            cm = brighten(customcolormap(angles, clrs), ((intensity(indx)/intensity(1))*(mx-mi))-mi );
    
            % Plot sun
            clf
            ax = subplot(2,1,1);
            
            sub = {"Radius of Visible Disc: "+ radius(indx)+"km", ...
                   " Intensity at Centre: "+ intensity(indx)+"W/m^2", ...
                   " Intensity at Limb: "+ ldr1+"W/m^2"};
            tit = "Altitude above solar surface: "+ distance(indx)/unit+" Au";
    
	        plot_sun("colormap", cm, "subtitle", sub, "axes", ax, "title", tit, "radius", radius(indx));
            drawnow;

            f = sum(ldr2)/3e8;
            a = (acos(radius(indx)/distance(indx)));
            force(indx) = (distance(indx))^2 / (2*pi*f*sin(a));
            
            
        end
    end

    figure(2)
	num = 7; % total number of subplots

	subplot(num,1,1);
	plot(distance./unit, vis_area, ".", "Color", "black");
	xlabel("Distance ["+unit_name+"]");
	ylabel("Visible Area [km^2]");

    subplot(num,1,2);
	plot(distance./unit, radius, ".", "Color", "black");
	xlabel("Distance ["+unit_name+"]");
	ylabel("Radius Disc [km]");

	subplot(num,1,3);
	plot(distance, intensity, ".", "Color", "black");
	xlabel("Distance ["+unit_name+"]");
	ylabel("Intensity W/m^2");

    subplot(num,1,4);
	plot(log(distance./unit), log(intensity), ".", "Color", "black");
	xlabel("log(s)");
	ylabel("log(I)");

    subplot(num,1,5);
	plot(distance./unit, theta, ".", "Color", "black");
	xlabel("Distance");
	ylabel("Internal Angle");

    subplot(num,1,6);
	plot(distance./unit, force, ".", "Color", "black");
	xlabel("Distance");
	ylabel("Beta");

    subplot(num,1,7);
	plot(distance./unit, intensity./intensity(1), ".", "Color", "black");
	xlabel("Distance");
	ylabel("Intensity Ratio");
	
end
