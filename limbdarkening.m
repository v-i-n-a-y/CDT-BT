% 
% Written by Vinay Williams 
%
% Written on 5th February 2022
%
% Mandatory Inputs:
%
% Optional Inputs:
%
% Outputs:
%
%

function i = limbdarkening(i0, theta, varargin)

	% Process arguments
	n=1;

	while n<size(varargin,2)
		strval = lower(varargin{n});
		switch strval
			case "linear"
				% Get coefficients
				n=n+1;
				u = varargin{n};

				% Calculate intensity
				i = i0*((1-u)*(1-cos(theta)));

			case "quadratic"
                n=n+1; 
                u = varargin{n};
                n=n+1;
                v = varargin{n};

                i = i0*((1-u)* (1-cos(theta)) * (v - sin(theta).^2));
			case "logarithm"
		end
		n=n+1;
	end
end
