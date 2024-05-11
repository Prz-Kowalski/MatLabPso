function volume = VolumeCriterium(x1,x2,x3,x4,x5,x6,x7)
%VOLUMECRITERIUM Summary of this function goes here
%   Detailed explanation goes here

termA = power(x1,2)* sqrt(power(x2,2) *power(x3,2) + power((x7-x1),2));
termB = power(x4,2)* sqrt(power(x5,2) *power(x6,2) + power((x7-x4),2));
termC = (pi/4) * (power(x1,2)*x2 + power(x4,2)*x5);


volume = (power(pi,2)/2) * (termA + termB) + termC;

end