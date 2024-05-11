function a = target_function(x,y)
    a = 2*x^2 + y^2 -5;
end





clear
clc

Rr = 1300;
G = 8.2*10^4;
Zgo = 0.6* Rr;
Zso = 0.6 * Zgo;
Zsj = 1.1 * Zgo;
tauDop = 0.5 * Rr;
res = FatigueCriterium(1.0,35.0,5.0,1.0,10.0,5.0,50.0, 1000, G, Zso, Zsj, Rr, Zgo);
volume = VolumeCriterium(1.0,35.0,5.0,1.0,10.0,5.0,50.0);

disp(res);
a = 200;
b = 100;

number_of_particles = 5000;
number_of_iterations = 4000;
inertia_coef = 0.5;
cognitive_coef = 0.5;
social_coef = 0.1;


swarm = zeros(number_of_particles, 7);
best_global_value = inf();
best_global_x = inf();
best_global_y = inf();

for i = 1 : number_of_particles
    swarm(i, 1) = a*rand() - b;
    swarm(i, 2) = a*rand() - b;
    swarm(i,5) = swarm(i,1);
    swarm(i,6) = swarm(i,2);
    swarm(i,7) = target_function(swarm(i,5), swarm(i,6));
    if  swarm(i,7) < best_global_value
        best_global_value =  swarm(i,7);
        best_global_x = swarm(i,5);
        best_global_y = swarm(i,6);
    end


end

for i = 1 : number_of_iterations
    for j = 1: number_of_particles
    %--aktualizuj prędkość cząstki na osi X
    Xra = rand();
    Xrb = rand();

    swarm(j, 3) = inertia_coef * swarm(j, 3) + cognitive_coef* Xra *(swarm(j, 5) - swarm(j,1)) + social_coef* Xrb *(swarm(j, 5) - best_global_x);
    %--aktualizacja prędkości cząstki na osiY
    Yra = rand();
    Yrb = rand();

    swarm(j, 4) = inertia_coef * swarm(j, 4) + cognitive_coef* Yra *(swarm(j, 6) - swarm(j,2)) + social_coef* Yrb *(swarm(j, 6) - best_global_y);
    %--w przypdaku potrzeby zaadaptowania algorytmu dla więcej niż 2
    %kryteriów w tym miejscu powinna być kolejna pętla

    %--aktualizuj położenie cząstki
    swarm(j,1) = swarm(j,1) + swarm(j,3);
    swarm(j,2) = swarm(j,2) + swarm(j,4);
    %--sprawdź czy wartość funkcji dopasowania dla aktulanego położenia
    %cząstki jest lepsza niż najlepsza dla tej cząstki
    particle_value = target_function(swarm(j,1), swarm(j,2));
    
    if particle_value < swarm(j,7)
        swarm(j,7) = particle_value;
        swarm(j,5) = swarm(j,1);
        swarm(j,6) = swarm(j,2);
    end
        %--sprawdź czy wartość funkcji dopasowania dla aktulanego położenia
    %cząstki jest lepsza niż globalna
    if particle_value < best_global_value
        best_global_value = particle_value;
        best_global_x = swarm(j,1);
        best_global_y = swarm(j,2);
    end


    end
end


disp(best_global_value)
disp(best_global_x)
disp(best_global_y)