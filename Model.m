function [fatigue, volume, G1, G2, G3, G4, G5, G6, G7, G8, G9, G10, G11, G12, G13, G14, G15, G16, G17] = Model(x1,x2,x3,x4,x5,x6,x7, P, G, Rr, r, c, deltaC, Dmax, Dmin, Lmax, Lmin)
%FATIGUECRITERIUM Summary of this function goes here
%   Detailed explanation goes here

% Obliczenie zmiennych pomocniczych 
Zgo = 0.6* Rr;
zSo = 0.6 * Zgo;
zJs = 1.1 * Zgo;


k = calculateK(x2/x1);

[Pz,Pw] = calculateP(x1,x2,x3,x4,x5,x6, P, G);

tauDop = Rr * 0.5;

tauMz = k* ( 8*x2 * Pz) / (pi * power(x1,3));
tauAz = tauMz/2;
tauMw = k* ( 8*x5 * Pw) / (pi * power(x4,3));
tauAw = tauMw /2;

[betaZ, betaW] = calculateBeta(Rr, Zgo, x1, x2, x4, x5);

gammaZ = calculateGamma(x2/x1, Zgo, x1);
gammaW = calculateGamma(x5/x4, Zgo, x4);

% wyliczenie kryterium bezpieczeństwa zmęczeniowego
termA = zSo/(betaZ * gammaZ * tauAz + tauMz * ((2*zSo/zJs) - 1));
termB = zSo/(betaW * gammaW * tauAw + tauMw * ((2*zSo/zJs) - 1));

fatigue = termA - termB;

volume = calculateVolume(x1,x2,x3,x4,x5,x6,x7);

% Obliczenie ograniczeń 

sF = 0.12;

G1 = calcg1(sF, tauDop, x2, x1, P);
G2 = calcg2(sF, tauDop, x4,x5,P);
G3 = calcg3(x1,x2,x3,x4,x5,x6,c,deltaC,G);
G4 = calcg4(x1,x2,x3,x7,P,G);
G5 = calcg5(x4,x5,x6,x7,G,P);
G6 = calcg6(x1,x2,x3,x7,G,P);
G7 = calcg7(x4,x5,x6,x7,G,P);
G8 = calcg8(x4,x5);
G9 = calcg9(x4,x5);
G10 = calcg10(x1,x2,x4,x5);
G11 = calcg11(x1,x2);
G12 = calcg12(x1,x2,Dmax);
G13 = calcg13(x4,x5,Dmin);
G14 = calcg14(x7,Lmax);
G15 = calcg15(x7,Lmin);
G16 = calcg16(zSo,betaZ,gammaZ,tauAz, tauMz, zJs);
G17 = calcg17(zSo,betaW,gammaW,tauAw, tauMw, zJs);



if G1 > 0
fatigue = fatigue + r * G1;
volume = volume + r * G1;
end

if G2 > 0
fatigue = fatigue + r * G2;
volume = volume + r * G2;
end

if G3 > 0
fatigue = fatigue + r * G3;
volume = volume + r * G3;
end

if G4 > 0
fatigue = fatigue + r * G4;
volume = volume + r * G4;
end

if G5 > 0
fatigue = fatigue + r * G5;
volume = volume + r * G5;
end

if G6 > 0
fatigue = fatigue + r * G6;
volume = volume + r * G6;
end

if G7 > 0
fatigue = fatigue + r * G7;
volume = volume + r * G7;
end

if G8 > 0
fatigue = fatigue + r * G8;
volume = volume + r * G8;
end

if G9 > 0
fatigue = fatigue + r * G9;
volume = volume + r * G9;
end

if G10 > 0
fatigue = fatigue + r * G10;
volume = volume + r * G10;
end

if G11 > 0
fatigue = fatigue + r * G11;
volume = volume + r * G11;
end

if G12 > 0
fatigue = fatigue + r * G12;
volume = volume + r * G12;
end

if G13 > 0
fatigue = fatigue + r * G13;
volume = volume + r * G13;
end

if G14 > 0
fatigue = fatigue + r * G14;
volume = volume + r * G14;
end

if G15 > 0
fatigue = fatigue + r * G15;
volume = volume + r * G15;
end

if G16 > 0
fatigue = fatigue + r * G16;
volume = volume + r * G16;
end

if G17 > 0
fatigue = fatigue + r * G17;
volume = volume + r * G17;
end


end


function volume = calculateVolume(x1,x2,x3,x4,x5,x6,x7)


termA = power(x1,2)* sqrt(power(x2,2) *power(x3,2) + power((x7-x1),2));
termB = power(x4,2)* sqrt(power(x5,2) *power(x6,2) + power((x7-x4),2));
termC = (pi/4) * (power(x1,2)*x2 + power(x4,2)*x5);


volume = (power(pi,2)/2) * (termA + termB) + termC;

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

function g1= calcg1(sF, tauDop, x2, x1, P)

w = x2/x1;
k = calculateK(w);
g1 = sF * tauDop - k*((8*x2*P)/(pi * x1^3));

end

function g2= calcg2(sF, tauDop, x4,x5,P)

w = x5/x4;
k = calculateK(w);
g2 = sF * tauDop - k*((8*x5*P)/(pi * x4^3));

end
function g3= calcg3(x1,x2,x3,x4,x5,x6,c,deltaC,G)

g3 = deltaC * c - abs(c-(((G*x1^4)/(8*x2^3*x3))+((G*x4^4)/(8*x5^5*x6))));

end
function g4= calcg4(x1,x2,x3,x7,P,G)

a = calculate_alpha(x1,x2);

g4 = x7 - ((8*x2^3*x3*P)/(G*x1^4)) - x1*x3 * (1+a);


end

function alpha = calculate_alpha(xa,xb)

w = xb/xa;

if xa < 0.8
    alpha = -0.00003 * w^3 + 0.0025 * w^2 - 0.0027 * w + 0.1590;
else
    alpha = -0.00002 * w^3 + 0.0020 * w^2 - 0.0018 * w + 0.0627;
end


end

function g5= calcg5(x4,x5,x6,x7,G,P)

a = calculate_alpha(x4,x5);

g5 = x7 - ((8*x5^3*x6*P)/(G*x4^4)) - x4*x6 * (1+a);

end


function g6= calcg6(x1,x2,x3,x7,G,P)

Ndop = calculate_Ndop(x2,x7);

g6 = Ndop - ((100*8*x2^3*x3*P)/(G*x7*x1^4));

end


function g7= calcg7(x4,x5,x6,x7,G,P)

Ndop = calculate_Ndop(x5,x7);

g7 = Ndop - ((100*8*x5^3*x6*P)/(G*x7*x4^4));

end

function Ndop = calculate_Ndop(xa,xb)

l = xb/xa;

Ndop = -0.0122* l ^ 6 +  0.2562*l^5 -1.9775 * l^4 + 6.9448 * l^3 - 12.807*l^2 + 9.8974*l + 52.444;

end


function g8= calcg8(x4,x5)

g8 = x5-3*x4;

end

function g9= calcg9(x4,x5)

g9 = 20*x4 - x5;

end

function g10= calcg10(x1,x2,x4,x5)

g10 = x2-x1 -(x5-x4);

end

function g11= calcg11(x1,x2)

g11 = 20*x1 - x2;

end

function g12= calcg12(x1,x2,Dmax)

g12 = Dmax - (x1+x2);

end

function g13= calcg13(x4,x5,Dmin)

g13 = x5-x4 - Dmin;

end

function g14= calcg14(x7,Lmax)

g14 = Lmax - x7;

end

function g15= calcg15(x7,Lmin)

g15 = x7 - Lmin;

end

function g16= calcg16(zSo,Bz,GammaZ,TauAz, TauMz, Zsj)

g16 = zSo/(Bz*GammaZ * TauAz* TauMz * ((2*zSo/Zsj)-1)) - 1.33;

end

function g17= calcg17(zSo,Bw,GammaW,TauAw, TauMw, Zsj)

g17 = zSo/(Bw*GammaW * TauAw* TauMw * ((2*zSo/Zsj)-1)) - 1.33;

end

