clear
clc




Rr = 1300;
G = 8.2*10^4;
P = 1000;
 
Dmax = 100;
Dmin = 10;
Lmax = 200;
Lmin = 50;
r = 1.0;
c = 1.0;
deltaC = 1.0; 


%res = Model(1.0,35.0,5.0,1.0,10.0,5.0,50.0, P, G, Rr);
%Model(x1,x2,x3,x4,x5,x6,x7, P, G, Rr, r, c, deltaC, Dmax, Dmin, Lmax, Lmin)


[N,L,W] = dane();

number_of_particles = 1000;
number_of_dimensions = N;
number_of_iterations = 2000;
inertia_coef = 0.5;
cognitive_coef = 0.5;
social_coef = 0.1;

%Cząstka składa się z :
%Trzech danych dla każdego wymiaru:
%                                  -pozycji
%                                  -prędkości
%                                  -najlepszej pozycji
%
% jednej danej ogólnej, swojej najlepszej wartości kryterium
% czyli dla problemu dwuwymiarowego macierz cząstki powinna mieć 7 elementów
% |X|vX|bX|Y|vY|bY|bV|
% jej rozmiar jest więc wyznaczany wzorem sz = 3*d + 1


fi = [1 4 7 10 13 16 19];
swarm = zeros(number_of_particles, number_of_dimensions*3+1);
valueI = number_of_dimensions*3+1;
best_global_value = inf();
best_global_vector = zeros(1,number_of_dimensions);



for i = 1 : number_of_particles
    for d = 1: number_of_dimensions

        di = fi(d);

        random_index = round( 1 + rand() * (L-1));

        %początkowa pozycja cząstki
        swarm(i, di) = random_index;
        %początkowa najlepsza pozycja cząstki
        swarm(i, di + 2) = random_index;
        %początkowa prędkość cząstki = 0;


    end


    x1 = W(1, swarm(i,1));
    x2 = W(2, swarm(i,4));
    x3 = W(3, swarm(i,7));
    x4 = W(4, swarm(i,10));
    x5 = W(5, swarm(i,13));
    x6 = W(6, swarm(i,16));
    x7 = W(7, swarm(i,19));
         
        [fatigue, volume] = Model(x1,x2,x3,x4,x5,x6,x7, P, G, Rr, r, c, deltaC, Dmax, Dmin, Lmax, Lmin);
    
    swarm(i, valueI) = fatigue;

    if fatigue < best_global_value
       best_global_value = fatigue;
       best_global_vector = [swarm(i,1) swarm(i,4) swarm(i,7) swarm(i,10) swarm(i,13) swarm(i,16) swarm(i,19)];
    end   

end



for iter = 1: number_of_iterations
    for i = 1 : number_of_particles
            for d = 1: number_of_dimensions

            di = fi(d);
            rp = rand();
            rg = rand();
            %       prędskość
            swarm(i, di + 1) =  inertia_coef * swarm(i, di + 1) + cognitive_coef* rp *(swarm(i, di+2) - swarm(i,di)) + social_coef* rg *(best_global_vector(1,d) - swarm(i,di));
            %       pozycja
            swarm(i,di) = min(max(round(swarm(i,di) + swarm(i, di + 1)),1),L);
            end
    x1 = W(1, swarm(i,1));
    x2 = W(2, swarm(i,4));
    x3 = W(3, swarm(i,7));
    x4 = W(4, swarm(i,10));
    x5 = W(5, swarm(i,13));
    x6 = W(6, swarm(i,16));
    x7 = W(7, swarm(i,19));
         
        [fatigue, volume] = Model(x1,x2,x3,x4,x5,x6,x7, P, G, Rr, r, c, deltaC, Dmax, Dmin, Lmax, Lmin);
    
        if fatigue < swarm(i, valueI)
            swarm(i, valueI) = fatigue;

            %aktaulizacja najlepszej 
              for d = 1: number_of_dimensions

                if d == 1
                    di = 1;
                else
                    di = (d-1) *3;
                end
                    swarm(i, di+2) = swarm(i,di);
              end
        end
    
        if fatigue < best_global_value
            best_global_value = fatigue;
            best_global_vector = [swarm(i,1) swarm(i,4) swarm(i,7) swarm(i,10) swarm(i,13) swarm(i,16) swarm(i,19)];
        end   
        
    
    end


end


disp(best_global_vector);
disp(best_global_value);

