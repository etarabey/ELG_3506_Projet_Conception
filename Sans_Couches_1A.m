% eau, n0 = 1.33
% ncellule = 3.5 
% R = 0.2 comme défini dans le document du projet pour la réflectivité sans
% couches
% lambdac = 650 nm (eau) 

R = 0.2; 
T = 1-R; % Calcul pour la transmittivité. 
lambda_1 = 400; lambda_2 = 1400; step = 1; 
wav = lambda_1:step:lambda_2; 
I = @(x) 6.61E15 ./ (x.^5 .* (exp(2484./x)-1)); % Équation pour l'irradiance idéale du spectre solaire.
P_lambda = I(wav) * T; % Puissance calculé pour chaque valeur de lambda. 
P = trapz(wav,P_lambda); %Valeur intégré de la puissance à travers de lambda (wav). 
fprintf('Power = %.3f W.\n',P);

