function fatigue = FatigueCriterium(x1,x2,x3,x4,x5,x6,x7, P, G, zSo, zJs, Rr, Zgo)
%FATIGUECRITERIUM Summary of this function goes here
%   Detailed explanation goes here
k = calculateK(x2/x1);

[Pz,Pw] = calculateP(x1,x2,x3,x4,x5,x6, P, G);

tauMz = k* ( 8*x2 * Pz) / (pi * power(x1,3));
tauAz = tauMz/2;
tauMw = k* ( 8*x5 * Pw) / (pi * power(x4,3));
tauAw = tauMw /2;

[betaZ, betaW] = calculateBeta(Rr, Zgo, x1, x2, x4, x5);

gammaZ = calculateGamma(x2/x1, Zgo, x1);
gammaW = calculateGamma(x5/x4, Zgo, x4);

termA = zSo/(betaZ * gammaZ * tauAz + tauMz * ((2*zSo/zJs) - 1));
termB = zSo/(betaW * gammaW * tauAw + tauMw * ((2*zSo/zJs) - 1));

fatigue = termA - termB;

end


function k = calculateK(w)

k = 1 + 5/4 * (1/w) + 7/8 * (power(1/w,2)) + power(1/w,3);

end

function [Pz,Pw] = calculateP(x1,x2,x3,x4,x5,x6,P, G)

cz = calculate_cz(x1,x2,x3,G);
cw = calculate_cw(x4,x5,x6,G);

Pz = P * cz/(cz+cw); 
Pw = P * cw/(cz+cw);

end 


function cz = calculate_cz(x1,x2,x3,G)

cz = G * power(x1,4) / (8* (power(x2,3) *x3 ));


end


function cw = calculate_cw(x4,x5,x6,G)

cw = G * power(x4,4) / (8* (power(x5,3) *x6 ));

end

function [Bz, Bw] = calculateBeta(Rr, Zgo, x1, x2, x4, x5)

n = 5* power(10,-4) * Zgo + 0.75;
Bps = 1.154 * power(10,-4) * Rr + 1.010;
Bz = (1 + (n*(calculate_a(x2/x1) -1))) * Bps;
Bw = (1 + (n*(calculate_a(x5/x4) -1))) * Bps;


end


function a = calculate_a(w)

a = 0.574*power(10,-4) * power(w,4) - 28.500 * power(10,-4) * power(w,3) + 520.820 + power(10,4)*power(w,2) - 0.424*w + 2.452; 

end



function gamma = calculateGamma(w, zGo, d)

if d < 10
    gamma = 1;
else
    ak = calculate_a(w);
    gamma1 = calculateGamma1(zGo, ak);
    B = calculateB(gamma1);
    A = calculateA(gamma1);
    gamma = B * log10(d) + A;

end

end


function gamma1 = calculateGamma1(Zgo, ak)
    
    gamma1 = 4.2860 * 10^-4 * (Zgo - 500) + 0.1038 * ak^3 - 0.9265 * ak^2 + 2.6931 * ak - 0.5870;

end

function B = calculateB(gamma1)

    B = (gamma1 - 1) * (log(2)/2*log(5)) + (gamma1-1)/2;
    
end

function A = calculateA(gamma1)

    A = (gamma1 - 1) * (log(2)/2*log(5)) + (gamma1-3)/2;

end

function g1= calcg1()

end

function g2= calcg2()

end
function g3= calcg3()

end
function g4= calcg4()

end
function g5= calcg5()

end
function g6= calcg6()

end
function g7= calcg7()

end
function g8= calcg8()

end

function g9= calcg9()

end
function g10= calcg10()

end

function g11= calcg11()

end

function g12= calcg12()

end

function g13= calcg13()

end

function g14= calcg14()

end

function g15= calcg15()

end

function g16= calcg16()

end

function g17= calcg17()

end

