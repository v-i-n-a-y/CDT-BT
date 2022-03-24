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

function sld2(varargin)

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
	[distance, vis_area, intensity, radius, theta, force_orig, force_alt] = deal(0:(dist/ds)-1);

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
            [ldr_orig, angles] = limb_darkening_intensities(intensity(indx), theta(indx)); 
            ldr_alt = ldr_orig;

            % Account for intensity variation with curvature
            for i = 1:length(ldr_orig)
                ldr_alt(i) = ldr_orig(i)/(sun_radius - sun_radius+(cos(angles(i))*sun_radius))^2;

            end

            limb_intensity_1 = ldr_orig(length(ldr_orig));
            limb_intensity_2 = ldr_alt(length(ldr_alt));

            % Copy matrix for force computation
            ldr_force_orig = ldr_orig;
            ldr_force_alt  = ldr_alt;
    
            % Compute colour map
            angles = angles ./ max(angles);

            ldr_orig = ldr_orig ./ max(ldr_orig);
            ldr_alt = ldr_alt ./ max(ldr_alt);
    
	        clrs_orig = zeros(length(angles), 3);
	        clrs_orig(:,2) = ldr_orig';
            clrs_orig(:,1) = ldr_orig';

            clrs_alt = zeros(length(angles), 3);
	        clrs_alt(:,2) = ldr_alt';
            clrs_alt(:,1) = ldr_alt';
    
            mx = 1;
            mi = 0;
    
            % Create colour map and adjust brightness
            cm_orig = brighten(customcolormap(angles, clrs_orig), ((intensity(indx)/intensity(1))*(mx-mi))-mi );
            cm_alt = brighten(customcolormap(angles, clrs_alt), ((intensity(indx)/intensity(1))*(mx-mi))-mi );
            
            ax = subplot(2,1,1);

            % Plot sun orig
            sub_orig = {"Radius of Visible Disc: "+ radius(indx)+"km", ...
                   " Intensity at Centre: "+ intensity(indx)+"W/m^2", ...
                   " Intensity at Limb: "+ limb_intensity_1+"W/m^2"};
            tit_orig = "Altitude above solar surface: "+ distance(indx)/unit+" Au";
    
	        plot_sun("colormap", cm_orig, "subtitle", sub_orig, "axes", ax, "title", tit_orig, "radius", radius(indx));


            ax2 = subplot(2,1,2);

            % Plot sun alt
            sub_alt = {"Radius of Visible Disc: "+ radius(indx)+"km", ...
                   " Intensity at Centre: "+ intensity(indx)+"W/m^2", ...
                   " Intensity at Limb: "+ limb_intensity_2+"W/m^2"};
            tit_alt = "Altitude above solar surface: "+ distance(indx)/unit+" Au";
    
	        plot_sun("colormap", cm_alt, "subtitle", sub_alt, "axes", ax2, "title", tit_alt, "radius", radius(indx));
            drawnow;

            force_orig = (4*pi*sum(ldr_force_orig*intensity(indx)))/3e8;
            force_alt = (4*pi*sum(ldr_force_alt*intensity(indx)))/3e8;

            %a = (acos(radius(indx)/distance(indx)));
            %force(indx) = (distance(indx))^2 / (2*pi*f*sin(a));
            
            
        end
    end

    figure(2)
	num = 8; % total number of subplots

	subplot(num,1,1);
	plot(distance./unit, vis_area, ".", "Color", "black");
	xlabel("Distance ["+unit_name+"]");
	ylabel("Visible Area [km^2]");
set(gca, "FontSize", 14)
    subplot(num,1,2);
	plot(distance./unit, radius, ".", "Color", "black");
	xlabel("Distance ["+unit_name+"]");
	ylabel("Radius Disc [km]");
set(gca, "FontSize", 14)
	subplot(num,1,3);
	plot(distance, intensity, ".", "Color", "black");
	xlabel("Distance ["+unit_name+"]");
	ylabel("Intensity W/m^2");
set(gca, "FontSize", 14)
    subplot(num,1,4);
	plot(log(distance./unit), log(intensity), ".", "Color", "black");
	xlabel("log(s)");
	ylabel("log(I)");
set(gca, "FontSize", 14)
    subplot(num,1,5);
	plot(distance./unit, theta, ".", "Color", "black");
	xlabel("Distance [Au]");
	ylabel("Internal Angle");
set(gca, "FontSize", 14)
    subplot(num,1,6);
	plot(distance./unit, force_orig, ".", "Color", "black");
	xlabel("Distance [Au]");
	ylabel("Force");
set(gca, "FontSize", 14)

    subplot(num,1,7);
	plot(distance./unit, intensity./intensity(1), ".", "Color", "black");
	xlabel("Distance");
	ylabel("Intensity Ratio");
set(gca, "FontSize", 14)
    subplot(num,1,8);
    plot(angles, ldr_orig - ldr_alt, ".", "Color", "black")
    xlabel("Angle [rad]");
    ylabel("Limb Darkening Ratio");

    set(gca, "FontSize", 14)
    
	
end
