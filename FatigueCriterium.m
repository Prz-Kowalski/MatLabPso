function fatigue = FatigueCriterium(x1,x2,x3,x4,x5,x6,x7, P, G, zSo, zJs, Rr)
%FATIGUECRITERIUM Summary of this function goes here
%   Detailed explanation goes here
k = calculateK(x2/x1);

[Pz,Pw] = calculateP(x1,x2,x3,x4,x5,x6,x7, P, G);

tauMz = k* ( 8*x2 * Pz) / (pi * power(x1,3));
tauAz = tauMz/2;
tauMw = k* ( 8*x5 * Pw) / (pi * power(x4,3));

betaZ = 0;
gammaZ = 0;
betaW = 0;
gammaW = 0;

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

function Bz = calculateBz(Rr, Zgo)





end


function n = calculateN(Zgo)

 n = 5* power(10,-4) * Zgo + 0.75;

end

function Bps = calcualteBps(Rr)

Bps = 1.154 * power(10,-4) * Rr + 1.010;

end


function a = calculateA()

end