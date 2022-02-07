

function [intensities, thetas] = limb_darkening_intensities(i0, theta, varargin)
	dtheta = 1e-4; % Interval to iterate angle
	model = "linear";
	flag_plot = false;

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
	
	[thetas, intensities] = deal(0:(theta/dtheta)-1);


	% Calculate
	for i = dtheta:dtheta:theta
		indx = int8(i/dtheta);
		intensities(indx) = limbdarkening(i0, i, model, 0.4793, 0.2462);
        thetas(indx) = i;
    end

    thetas = thetas./(1/dtheta);

	if flag_plot == true
        hold on
		plot(thetas, intensities, "Color", "black");
		xlabel("Angle from centre");
		ylabel("Intensity W/m^2");
        drawnow
	end
	
end
