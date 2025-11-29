function plot_puissance_n1(n1_array)
% La plupart du code est la même des parties 2a et 2b. SVP voir les
% commentaires dans cet fichier pour voir le fonctionnement du code. 
m = 1; 
I = @(x) 6.61E15 ./ (x.^5 .* (exp(2484./x)-1)); 
for n1 = n1_array % Sauf par contre, on fait varier n1 ici au lieu de n2, qui lui est fixe à une valeur de 2.43. 
n = [1.33,n1,2.43,3.5]; 
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
d = lambda_c/4; 
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
% Graphe les valeurs de la puissance transmis sur les valeurs de n1. 
figure; 
plot(n1_array,P_Array);
title('Graphe de la puissance transmise en fonction de n1');
xlabel('n1')
ylabel('Puissance tranmise (W)')
end

n1_array = 1:0.01:3.5; % Tableau avec valeurs multiples de n1. 

plot_puissance_n1(n1_array);











