syms n0 n1 n2 n3 n4 R; % Définition des symboles généraux pour les valeurs de n et de la réflectivité.
n = [n0,n1,n2,n3,n4];
g01 = (n0-n1)/(n0+n1); % Expression pour gamma01
g12 = (n1-n2)/(n1+n2); % Expression pour gamma12
g23 = (n2-n3)/(n2+n3); % Expression pour gamma23
g34 = (n3-n4)/(n3+n4); % Expression pour gamma34 
t01 = 2*n0/(n0+n1); % Expression pour tau01
t12 = 2*n1/(n1+n2); % Expression pour tau12
t23 = 2*n2/(n2+n3); % Expression pour tau23
t34 = 2*n3/(n3+n4); % Expression pour tau34

Q01 = (1/t01) .* [1 g01;g01 1]; % Expression pour Q01 (matrice dynamique)
Q12 = (1/t12) .* [1 g12;g12 1]; % Expression pour Q12 (matrice dynamique)
Q23 = (1/t23) .* [1 g23;g23 1]; % Expression pour Q23 (matrice dynamique)
Q34 = (1/t34) .* [1 g34;g34 1]; % Expression pour Q34 (matrice dynamique)
P = j.*[1 0; 0 -1]; % Expression pour la matrice de propagation lorsque lambda = lambda_c. 
% Donnant l'expression idéale pour la réflectivité minimale. 

T = reshape(Q01,2,2)*P*reshape(Q12,2,2)*P*reshape(Q23,2,2)*P*reshape(Q34,2,2); % Calcul pour la matrice de transfert. 

R = T(2,1)/T(1,1); % Calcul pour la réflectivité. 
R = R == 0;
Rsol = isolate(R,n2); % On isole n2 encore pour trouver l'expression pour une réflectivité minimale.
Rsolstr = char(Rsol); 
Rstr = char(lhs(R));
fprintf('Équation pour 3a: %s \n',Rstr);
fprintf('Équation pour 3b: %s \n',Rsolstr);
RsolRH = rhs(Rsol); 
n0Val = 1.33; 
n1Val = 1.5;
n3Val = 3.2;
n4Val = 3.5; 
n2Val = double(subs(RsolRH, {n0,n1,n3,n4}, {n0Val,n1Val,n3Val,n4Val})); % On résout pour une valeur de n2 avec les autres valeurs de n fixes pour que R = 0. 
fprintf('Valeur de n2 optimale: %.2f',n2Val);



