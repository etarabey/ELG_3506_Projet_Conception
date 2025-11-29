function plot_puissance_d(d_array)
% La plupart du code est la même des parties 2a et 2b. SVP voir les
% commentaires dans cet fichier pour voir le fonctionnement du code. 
m = 1; 
I = @(x) 6.61E15 ./ (x.^5 .* (exp(2484./x)-1)); 
for d_frac = d_array % Sauf par contre, on fait varier d et on garde n1 et n2 fixe à 1.5 et 2.43 respectivement. 
n = [1.33,1.5,2.43,3.5]; 
gamma = [(n(1)-n(2))/(n(1)+n(2)),(n(2)-n(3))/(n(2)+n(3)),(n(3)-n(4))/(n(3)+n(4))]; 
tau = []; 
Q = []; 
R = []; 
for i = 1:length(n)-1 
    tau(end+1) = (2*n(i))/(n(i)+n(i+1)); 
end

Q01 = (1/tau(1)).* [1,gamma(1); gamma(1), 1]; 
Q12 = (1/tau(2)).* [1, gamma(2); gamma(2), 1]; 
Q23 = (1/tau(3)).* [1, gamma(3); gamma(3), 1]; 

lambda_1 = 400; lambda_2 = 1400; step = 1; 
wav = lambda_1:step:lambda_2;
lambda_c = 650; 
d = lambda_c/d_frac; % Calcul pour l'épaisseur variable. On garde lambda_c = 650 nm (valeur dans l'eau). 
frac_array(m) = d;
i = 1;
for w=wav
    phase = (2*pi*d)./w; 
    P1 = [exp(j.*phase), 0; 0, exp(j.*-phase)]; 
    T = Q01*P1*Q12*P1*Q23; 

    gammaTotal = T(2,1)/T(1,1); 
    R(i) = abs(gammaTotal).^2; 
    i = i+1; 

   
end

% ------------------------------
T = 1-R; 
P_lambda = I(wav).*T; 
P = trapz(wav,P_lambda); 
P_Array(m) = P; 
m = m+1; 
end
% Graphe les valeurs de la puissance transmis sur les valeurs de d. 
figure; 
plot(frac_array,P_Array);
title("Graphe de la puissance transmise en fonction de l'épaisseur des couches reflectives");
xlabel('d (nm)')
ylabel('Puissance tranmise (W)')
end

d_array = 2:1:100; % Tableau avec valeurs multiples de d. 

plot_puissance_d(d_array);











