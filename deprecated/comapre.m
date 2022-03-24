


simulation_distance = 150e6;
simulation_interval = 10000;
sun_radius = 696340;
[distance, vis_area, intensity, radius, theta] = deal(0:(simulation_distance/simulation_interval)-1);

indx = 1;
for h = 1:simulation_interval:simulation_distance
    distance(indx)  = h;
    vis_area(indx) = visible_area(sun_radius, h);
    intensity(indx) = intensity_blackbody(h, "temperature", 5800);
    radius(indx) = sqrt(vis_area(indx)/pi);
    theta(indx) = atan(radius(indx)/h);
    [ldi, ~] = limb_darkening_intensities(intensity(indx), theta(indx));

    temp = 0;
    for i = 1:round(radius(indx),0) 
        b = sqrt(sun_radius^2 - i^2);
        a = sun_radius - b;

        d = sqrt((h+a)^2 + i^2);
        temp(i+1) = intensity(indx)/d^2;
    end
    
    intensity2(indx) = mean(temp);
    intensity3(indx) = mean(ldi);
   indx = indx+1;

   disp(h/147.72e6)
end

figure(1)
hold on
plot(log(distance./147.72e6),log(intensity), ". k")
plot(log(distance./147.72e6),log(intensity2), "* b")
plot(log(distance./147.72e6),log(intensity3), "o r")
plot(log(distance./147.72e6),log(intensity - intensity3), "-- g")
legend(["Basic", "Curvature", "Limb Darkening", "Difference of 1 and 3"])
mean(intensity-intensity2)