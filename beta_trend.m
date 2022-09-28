%
% Written by Vinay Williams 
%
% Written on 22nd February 2022
%
% Last Modified on 7th March 2022
%
% Solar Limb Darkening effect on dust particle beta value
%

% Start the clock
tic 

% Clear all environment variables
clear all

% Clear the command window
clc
close all 

flag_plot = false;
flag_wait = false;
flag_save = true;

addpath("./visible_area");
addpath("./intensity_blackbody");
addpath("./functions");

% Constants
    data.solar_radius           = 696340;       %[m]
    data.solar_mass             = 1.9891e30;    %[kg]
    data.gravitational_constant = 6.67430e-11;  %[m^3 kg^-1 s^-2]
    data.speed_light            = 3e8;          %[ms^-1]
    data.solar_flux             = 6.2999e7;     %[W m^-2]
    data.simulation_unit        = 147.72e6;     %[km]
    data.simulation_unit_label  = "Au";

    disp("Constants defined...")

% Initialise function variables with default values
    data.simulation_start       = 147.72e6;     %[km]
    data.simulation_interval    = 1e2;          %[km]
    data.simulation_stop        = 696340;       %[km]

    disp("Simulation parameters set...")

% Seed distance array
    data.distance = (data.simulation_stop:data.simulation_interval:data.simulation_start); %[km]
    disp("Distance array seeded...");
    toc;

% Calculate visible areas
    data.visible_area = arrayfun(@(x) visible_area(data.solar_radius, x), data.distance); %[km^2]
    disp("Visible areas calculated...");
    toc;

% Calculate visible radii of sun
    data.visible_radius = arrayfun(@(x) data.solar_radius * sin(acos(data.solar_radius/(data.solar_radius+x))), data.distance); %[km]
    disp("Visible Radii calculated...");
    toc;

% Calculate max viewing angle
    data.max_viewing_angle = arrayfun(@(x,y) atan(x/((data.solar_radius - sqrt(data.solar_radius^2 - x^2))+y)), data.visible_radius, data.distance); %[rad]
    disp("Max viewing angles calculated...");
    toc;
    
    r = data.solar_radius;
% Calculate intensities
    indx = 1;
    for h = data.simulation_stop:data.simulation_interval:data.simulation_start
        h/data.simulation_start
        % Calculates the intensities over the surface
        [ldi, angles] = limb_darkening_intensities(data.solar_flux, data.max_viewing_angle(indx), "interval", data.max_viewing_angle(indx)/100);
   
        
        %d = arrayfun(@(x) (h+r-sqrt(r^2 - 1 + (r/(r+h))))/(cos(x)), angles);
        d = (h+r-sqrt(r^2 - (2*r + h/(r+h))))./(cos(angles));
        data.mean_intensity(indx) = mean((data.solar_radius^2 ./d.^2) .* ldi);

        indx = indx + 1;
    end
    
    data.intensity = data.mean_intensity .* data.visible_area;
    
    disp("Intensities corrected for limb darkening and dimming due to curvature...");
    toc;


% Calculate beta trend
    %data.beta = (((data.distance)).^2) .* data.mean_intensity./(data.gravitational_constant* data.solar_mass*data.speed_light);

    data.beta2 = (data.intensity .* (data.distance*1000).^2)/ (data.speed_light * data.gravitational_constant *data.solar_mass);
    disp("Beta trend calculated...");
    toc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if flag_plot == true
    % Plots
    figure()
        dat = data.visible_area;
        dat_label = "Visible Area/ km^2";
        t = tiledlayout(1,1);
        ax(1) = axes(t);
        a = plot(ax(1), data.distance./data.simulation_unit, dat, "-r");
        ax1.XColor = 'r';
        ax1.YColor = 'r';
        ax(2) = axes(t);   
        b = plot(ax(2), data.distance, dat, "--b");
        ax(2).XAxisLocation = 'top';
        ax(2).Color = 'none';
        xlabel(ax(1),"Distance/ "+data.simulation_unit_label)
        ylabel(ax(1),dat_label)
        xlabel(ax(2),"Distance/ km")
        ylabel(ax(2),dat_label)
        legend([a,b],'au','km')
        title("Visible Area v Distance")
        if flag_save == true
            saveas(gcf, "visible area v distance.png")
        end
    
        figure()
        dat = data.intensity;
        dat_label = "Total Intensity/ W";
        t = tiledlayout(1,1);
        ax(1) = axes(t);
        a = plot(ax(1), data.distance./data.simulation_unit, dat, "-r");
        ax1.XColor = 'r';
        ax1.YColor = 'r';
        ax(2) = axes(t);   
        b = plot(ax(2), data.distance, dat, "--b");
        ax(2).XAxisLocation = 'top';
        ax(2).Color = 'none';
        xlabel(ax(1),"Distance/ "+data.simulation_unit_label)
        ylabel(ax(1),dat_label)
        xlabel(ax(2),"Distance/ km")
        ylabel(ax(2),dat_label)
        legend([a,b],'au','km')
        title("Total Intensity v Distance")
        if flag_save == true
            saveas(gcf, "total intensity v distance.png")
        end
    
%     figure()
%         dat = data.mean_intensity;
%         dat_label = "Mean Intensity/ W/m^2";
%         t = tiledlayout(1,1);
%         ax(1) = axes(t);
%         a = plot(ax(1), data.distance./data.simulation_unit, dat, "-r");
%         ax1.XColor = 'r';
%         ax1.YColor = 'r';
%         ax(2) = axes(t);   
%         b = plot(ax(2), data.distance, dat, "--b");
%         ax(2).XAxisLocation = 'top';
%         ax(2).Color = 'none';
%         xlabel(ax(1),"Distance/ "+data.simulation_unit_label)
%         ylabel(ax(1),dat_label)
%         xlabel(ax(2),"Distance/ km")    
%         ylabel(ax(2),dat_label)
%         legend([a,b],'au','km')   
%         title("Mean Intensity v Distance")
%         if flag_save == true
%             saveas(gcf, "mean intensity v distance.png")
%         end
    
    figure()
        dat = data.max_viewing_angle;
        dat_label = "Viewing Angle/ rad";
        t = tiledlayout(1,1);
        ax(1) = axes(t);
        a = plot(ax(1), data.distance./data.simulation_unit, dat, "-r");
        ax1.XColor = 'r';
        ax1.YColor = 'r';
        ax(2) = axes(t);   
        b = plot(ax(2), data.distance, dat, "--b");
        ax(2).XAxisLocation = 'top';
        ax(2).Color = 'none';
        xlabel(ax(1),"Distance/ "+data.simulation_unit_label)
        ylabel(ax(1),dat_label)
        xlabel(ax(2),"Distance/ km")
        ylabel(ax(2),dat_label)
        legend([a,b],'au','km')
        title("Max Viewing Angle v Distance")
        if flag_save == true
            saveas(gcf, "max viewing angle v distance.png")
        end
    
    figure()
        dat = data.beta;
        dat_label = "Beta";
        t = tiledlayout(1,1);
        ax(1) = axes(t);
        a = plot(ax(1), data.distance./data.simulation_unit, dat./max(dat), "-r");
        ax1.XColor = 'r';
        ax1.YColor = 'r';
        ax(2) = axes(t);   
        b = plot(ax(2), data.distance, dat, "--b");
        ax(2).XAxisLocation = 'top';
        ax(2).Color = 'none';
        xlabel(ax(1),"Distance/ "+data.simulation_unit_label)
        ylabel(ax(1),dat_label)
        xlabel(ax(2),"Distance/ km")
        ylabel(ax(2),dat_label)
        legend([a,b],'au','km')    
        title("Beta v Distance")
        if flag_save == true
            saveas(gcf,"beta v distance.png")
        end
    
    %%%%
    figure()
        dat = data.visible_area;
        dat_label = "Visible Area/ km^2";
        t = tiledlayout(1,1);
        ax(1) = axes(t);
        a = loglog(ax(1), data.distance./data.simulation_unit, dat, "-r");
        ax1.XColor = 'r';
        ax1.YColor = 'r';
        ax(2) = axes(t);   
        b = loglog(ax(2), data.distance, dat, "--b");
        ax(2).XAxisLocation = 'top';
        ax(2).Color = 'none';
        xlabel(ax(1),"Distance/ "+data.simulation_unit_label)
        ylabel(ax(1),dat_label)
        xlabel(ax(2),"Distance/ km")
        ylabel(ax(2),dat_label)
        legend([a,b],'au','km')
        title("Visible Area v distance  (log log plot)")
        if flag_save == true
            saveas(gcf,"visible area v distance loglog.png")
        end
    
    figure()
        dat = data.intensity;
        dat_label = "Total Intensity/ W";
        t = tiledlayout(1,1);
        ax(1) = axes(t);
        a = loglog(ax(1), data.distance./data.simulation_unit, dat, "-r");
        ax1.XColor = 'r';
        ax1.YColor = 'r';
        ax(2) = axes(t);   
        b = loglog(ax(2), data.distance, dat, "--b");
        ax(2).XAxisLocation = 'top';
        ax(2).Color = 'none';
        xlabel(ax(1),"Distance/ "+data.simulation_unit_label)
        ylabel(ax(1),dat_label)
        xlabel(ax(2),"Distance/ km")
        ylabel(ax(2),dat_label)
        legend([a,b],'au','km')
        title("Total Intensity v Distance  (log log plot)")
        if flag_save == true
            saveas(gcf,"total intensity v distance loglog.png")
        end
    
%     figure()
%         dat = data.mean_intensity;
%         dat_label = "Mean Intensity/ W/m^2";
%         t = tiledlayout(1,1);
%         ax(1) = axes(t);
%         a = loglog(ax(1), data.distance./data.simulation_unit, dat, "-r");
%         ax1.XColor = 'r';
%         ax1.YColor = 'r';
%         ax(2) = axes(t);   
%         b = loglog(ax(2), data.distance, dat, "--b");
%         ax(2).XAxisLocation = 'top';
%         ax(2).Color = 'none';
%         xlabel(ax(1),"Distance/ "+data.simulation_unit_label)
%         ylabel(ax(1),dat_label)
%         xlabel(ax(2),"Distance/ km")
%         ylabel(ax(2),dat_label)
%         legend([a,b],'au','km')    
%         title("Mean Intensity v Distance  (log log plot)")
%         if flag_save == true
%             saveas(gcf,"mean intensity v distance loglog.png")
%         end
    
    figure()
        dat = data.max_viewing_angle;
        dat_label = "Viewing Angle/ rad";
        t = tiledlayout(1,1);
        ax(1) = axes(t);
        a = loglog(ax(1), data.distance./data.simulation_unit, dat, "-r");
        ax1.XColor = 'r';
        ax1.YColor = 'r';
        ax(2) = axes(t);   
        b = loglog(ax(2), data.distance, dat, "--b");
        ax(2).XAxisLocation = 'top';
        ax(2).Color = 'none';
        xlabel(ax(1),"Distance/ "+data.simulation_unit_label)
        ylabel(ax(1),dat_label)
        xlabel(ax(2),"Distance/ km")
        ylabel(ax(2),dat_label)
        legend([a,b],'au','km')
        title("Max viewing angle v Distance from solar centre ")
        if flag_save == true
            saveas(gcf,"max viewing angle v distance loglog.png")
        end
    
    figure()
        dat = data.beta;
        dat_label = "Beta";
        t = tiledlayout(1,1);
        ax(1) = axes(t);
        a = loglog(ax(1), data.distance./data.simulation_unit, dat./max(dat), "-r");
        ax1.XColor = 'r';
        ax1.YColor = 'r';
        ax(2) = axes(t);   
        b = loglog(ax(2), data.distance, dat, "--b");
        ax(2).XAxisLocation = 'top';
        ax(2).Color = 'none';
        xlabel(ax(1),"Distance/ "+data.simulation_unit_label)
        ylabel(ax(1),dat_label)
        xlabel(ax(2),"Distance/ km")
        ylabel(ax(2),dat_label)
        legend([a,b],'au','km')    
        title("Beta v Distance from solar centre (log log plot)")
        if flag_save == true
            saveas(gcf,"beta v distance loglog.png")
        end
    
        figure()
    plot(data.distance, data.visible_area, "r")
    hold on
    yyaxis right
    plot(data.distance, data.intensity, "b")
    plot(data.distance, (data.visible_area .* 6.3e13)./data.distance.^2, 'g')
        
    if flag_wait == false
        close all
    end
    toc
end


if flag_save == true
    save("save-data", "data")
    csvwrite('beta_corr.csv', data.beta./max(data.beta));
    csvwrite('dist.csv', data.distance);
end

disp("Finished...");
toc;
