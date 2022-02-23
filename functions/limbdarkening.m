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

function ratio = limbdarkening(theta, varargin)

	% Process arguments
	n=1;

	while n<size(varargin,2)
		strval = lower(varargin{n});
		switch strval
			case "linear"
				% Get coefficients
				n=n+1;
				c = varargin{n};

				% Calculate intensity
				ratio = ((1-c)*(1-cos(theta)));

			case "quadratic"
                		n=n+1; 
               			c1 = varargin{n};
                		n=n+1;
                		c2 = varargin{n};

                		ratio = (1-c1)*(1-cos(theta))-c2*(1-cos(theta))^2;
			case "square root"
				n=n+1;
				c1 = varargin{n};
				n=n+1;
				c2 = varargin{n};

				ratio = (1-c1)*(1-cos(theta))-c2*(1-cos(theta));
			case "logarithm"
				n=n+1; 
				c1 = varargin{n};
				n=n+1; 
				c2 = varargin{n};

				ratio = (1-c1)*(1-cos(theta))-c2*cos(theta)*log(cos(theta));
			case "exponential"
				n=n+1;
				c1 = varargin{n};
				n=n+1;
				c2 = varargin{n};

				ratio = (1-c1)*(1-cos(theta))-(c2/(1-exp(cos(theta))));
		end
		n=n+1;
	end
end
