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
    
    figure()
        dat = data.mean_intensity;
        dat_label = "Mean Intensity/ W/m^2";
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
        title("Mean Intensity v Distance")
        if flag_save == true
            saveas(gcf, "mean intensity v distance.png")
        end
    
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
        b = plot(ax(2), data.distance, dat./max(dat), "--b");
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
    
    figure()
        dat = data.mean_intensity;
        dat_label = "Mean Intensity/ W/m^2";
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
        title("Mean Intensity v Distance  (log log plot)")
        if flag_save == true
            saveas(gcf,"mean intensity v distance loglog.png")
        end
    
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
        b = loglog(ax(2), data.distance, dat./max(dat), "--b");
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
return