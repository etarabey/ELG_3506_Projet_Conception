syms n0 n1 n2 n3 R; % Définition des symboles pour les indices de réfraction et pour la réflectivité. 
g01 = (n0-n1)/(n0+n1); % Expression pour gamma01
g12 = (n1-n2)/(n1+n2); % Expression pour gamma12
g23 = (n2-n3)/(n2+n3); % Expression pour gamma23

eqnR = (g01-g12-g01*g12*g23+g23)/(1-g01*g12-g12*g23+g01*g23).^2 == 0; % Expression pour R basé de ce qui est décrit dans les slides. 
Rsol = isolate(eqnR,n2); % On isole pour n2. 
Rsolstr = char(Rsol);
fprintf("%s \n",Rsolstr);
RsolRH = rhs(Rsol); 
n0Val = 1.33; 
n1Val = 1.5; 
n3Val = 3.5; 
n2Val = double(subs(RsolRH, {n0,n1,n3}, {n0Val,n1Val,n3Val})); % On trouve la valeur de n2 avec les autres valeurs de n données. 
fprintf('Valeur de n2: %.2f',n2Val); 
