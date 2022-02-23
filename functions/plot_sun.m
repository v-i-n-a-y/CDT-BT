

function  plot_sun(varargin)

    % Default flags and variables
    flag_ext_ax = false;
    plot_title = "";
    plot_subtitle = "";
    colorMap = customcolormap([0,1],[1 1 0; 1 0 0]);
    radius = 100;
    sides = 360;
    lim = 1200;
    % Process Arguments
    n = 1;
    while n<size(varargin,2)
        strval = lower(varargin{n});
        switch strval
            case 'axes'
                n=n+1;
                flag_ext_ax = true;
                ax = varargin{n};
            case 'title'
                n=n+1;
                plot_title = varargin{n};
            case 'subtitle'
                n=n+1;
                plot_subtitle = varargin{n};
            case 'colormap'
                n=n+1;
                colorMap = varargin{n};
            case 'radius'
                n=n+1;
                radius = varargin{n};
            case 'sides'
                n=n+1;
                sides = varargin{n};
            case "limit"
                n=n+1;
                lim = varargin{n};
        end
        n=n+1;
    end

    r = linspace(0, radius, 360);    % Define Radius & Radius Gradient Vector
    a = linspace(0, 2*pi, sides);   % Angles (Radians)
    [R,A] = ndgrid(r, a);           % Create Grid
    Z = -R;                         % Create Gradient Matrix
    [X,Y,Z] = pol2cart(A,R,Z);      % Convet to cartesian

    % Plot
        if flag_ext_ax == true
            surf(ax, X, Y, Z);
        else 
            figure(1)
            ax = axes();
            surf(ax, X,Y,Z);
        end

    
    % Shade plot
    colormap(colorMap);
    shading('interp');

    % Decorate plot
    title(plot_title);
    subtitle(plot_subtitle)
    view(0, 90);
    xlim([-lim, lim])
    axis equal
end