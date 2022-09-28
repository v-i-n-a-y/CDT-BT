

function [intensities, thetas] = limb_darkening_intensities(i0, theta, varargin)

	dtheta      = 1e-5; % Interval to iterate angle
	model       = "linear";
	flag_plot   = false;

	% Process arguments
	n = 1;
	while n<size(varargin,2)
		strval = lower(varargin{n});
		switch strval
			case "interval"
				n=n+1;
				dtheta = varargin{n};
			case "model"
				n=n+1; 
				model = varargin{n};
			case "plot"
				flag_plot = true;
		end
		n=n+1;
	end
	
    [thetas, intensities] = deal(0.0001:(theta/dtheta)-1);


    indx = 1;
	% Calculate
	for a = 0:dtheta:theta
		intensities(indx) = i0*(1-limbdarkening(a, model, 0.5914));
        thetas(indx) = a;
        indx = indx+1;
    end
    
    thetas = thetas./(1/dtheta);

	if flag_plot == true
        figure(1)
        hold on
        plot(-thetas, intensities, "Color", "black")
        plot(thetas, intensities, "Color", "black")
        xlabel("Internal Angle [rad]");
        ylabel("Intensity [w/m^2]")
        title("Intensity Ratio trend for a "+model+" solar limb darkening model")
        drawnow;
	end
	
end
