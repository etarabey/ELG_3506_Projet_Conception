I = @(x) 6.61E15 ./ (x.^5 .* (exp(2484./x)-1)); 
n = [1.33,1.5,2.43,3.5]; 
gamma = [(n(1)-n(2))/(n(1)+n(2)),(n(2)-n(3))/(n(2)+n(3)),(n(3)-n(4))/(n(3)+n(4))]; % Liste d'expressions pour gamma avec deux couches. 
tau = []; 
Q = []; 
R = []; 
for i = 1:length(n)-1 % for loop pour calculer les valeurs de tau. 
    tau(end+1) = (2*n(i))/(n(i)+n(i+1)); 
end

Q01 = (1/tau(1)).* [1,gamma(1); gamma(1) 1]; % Calcul des matrices dynamiques entre chaque couche. 
Q12 = (1/tau(2)).* [1, gamma(2); gamma(2) 1]; 
Q23 = (1/tau(3)).* [1, gamma(3); gamma(3) 1]; 

lambda_1 = 400; lambda_2 = 1400; step = 1; % Variation de lambda entre 400 nm et 1400 nm. 
wav = lambda_1:step:lambda_2;
lambda_c = 650; % Valeur centrale pour lambda_c à 650 nm. 
d = lambda_c/4; % Épaisseur d est calculé comme un quart la longueur d'onde centrale comme décrit dans la description du projet.     
i = 1;                                                                                                                                
for w=wav
    phase = (2*pi*d)/w; % Calcul pour l'argument de la phase.
    P1 = [exp(j.*phase), 0; 0, exp(j.*-phase)]; % Calcul pour la matrice de propagation de l'onde. 
    T = Q01*P1*Q12*P1*Q23; % Calcul pour le matrice de transfert, comme l'est décrit par la théorie de MTM.

    gammaTotal = T(2,1)/T(1,1); % Calcul pour le gamma du système comme décrit dans les slides. 
    R(i) = abs(gammaTotal).^2; % Calcul pour la réflectivité à une certaine longueur d'onde. 
    i = i+1; 
    tauTotal = 1-abs(gammaTotal); % Calcul pour la transmittivité. 

   
end
% Graphe la réflectivité en fonction de la longueur d'onde. 
figure(1); 
plot(wav,R);
title("Reflectivité par rapport à la longueur d'onde"); 
xlabel("Longueur d'onde λ (nm)"); 
ylabel("Reflectivité (%)")

% ------------------------------
% Calcul de la puissance transmisse intégré par rapport à la longueur
% d'onde avec n2 = 2.43
T = 1-R; 
P_lambda = I(wav).*T; 
P = trapz(wav,P_lambda); 
fprintf('Puissance intégrée = %.3f W \n',P);  

% -------------------------------











