% Même calcul que la partie 2c sauf qu'on ajoute une couche anti-reflectif
% d'extra. 
n2_array = 1:0.01:3.5; 
m = 1; 
I = @(x) 6.61E15 ./ (x.^5 .* (exp(2484./x)-1)); 
for n2 = n2_array 
n = [1.33,1.5,n2,3.2,3.5]; % On suppose ici que n3 = 3.2
gamma = [(n(1)-n(2))/(n(1)+n(2)),(n(2)-n(3))/(n(2)+n(3)),(n(3)-n(4))/(n(3)+n(4)),(n(4)-n(5))/(n(4)+n(5))]; % Un autre expression de gamma s'est ajouté reliant n3 et ncellule ensembles. 
tau = []; 
Q = []; 
R = []; 
for i = 1:length(n)-1 % On aurait de plus une autre valeur de tau d'extra. 
    tau(end+1) = (2*n(i))/(n(i)+n(i+1)); 
end

Q01 = (1/tau(1)).* [1,gamma(1); gamma(1), 1]; 
Q12 = (1/tau(2)).* [1, gamma(2); gamma(2), 1]; 
Q23 = (1/tau(3)).* [1, gamma(3); gamma(3), 1]; 
Q34 = (1/tau(4)).* [1, gamma(4); gamma(4),1]; % On ajoute une autre valeur pour Q en raison du couche d'extra. 

lambda_1 = 400; lambda_2 = 1400; step = 1; 
wav = lambda_1:step:lambda_2;
lambda_c = 650; 
d = lambda_c/4; 
i = 1;
for w=wav
    phase = (2*pi*d)./w; 
    P1 = [exp(j.*phase), 0; 0, exp(j.*-phase)]; 
    T = Q01*P1*Q12*P1*Q23*P1*Q34; % On multiplie un autre terme de P et Q multipliés ensembles pour mettre en compte
    % de la troisième couche. 
    gammaTotal = T(2,1)/T(1,1); 
    R(i) = abs(gammaTotal).^2; 
    i = i+1; 
    tauTotal = 1-abs(gammaTotal); 

   
end

% ------------------------------
T = 1-R; 
P_lambda = I(wav).*T; 
P = trapz(wav,P_lambda); 
P_Array(m) = P; 
m = m+1; 
end
% Graphe les valeurs de la puissance transmis sur les valeurs de n2. 
figure(2); 
plot(n2_array,P_Array);
title('Puissance transmise par rapport à n2 avec trois couches'); 
xlabel('n2')
ylabel('Puissance transmise (W)')

% -------------------------------