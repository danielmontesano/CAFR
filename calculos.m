%% Ejercicio 3
%%

clc
clear
close all
%%
load('matlab.mat')
dibujar(filter)
dibujar(line1)
dibujar(line2)
dibujar(reflect1)
dibujar(reflect2)
dibujar(through)

%%


[ S_bi_T, R_T ] = StoR(through);
[ S_bi_L1, R_L1 ] = StoR(line1);

    for n=1:size(R_T,3)

        T(:,:,n) = R_L1(:,:,n)*inv(R_T(:,:,n));
        
        p = [T(2,1,n) T(2,2,n)-T(1,1,n) -T(1,2,n)];
        Troot(:,n) = roots(p);
        a_c(n)= Troot(1);
        c_a = 1./a_c;
        b(n)=Troot(2);
        
        g(n) = R_T(2,2,n);
        d(n) = R_T(2,2,n)*R_T(1,1,n);
        e(n) = R_T(2,2,n)*R_T(1,2,n);
        f(n) = R_T(2,2,n)*R_T(2,1,n);
        
    end
    
r22rho22 = g.*((f-(d.*c_a))/(1-(e.*c_a)));
alphaporA = ((d-(b.*f))/(1-(e.*c_a)));
beta_alpha = ((e-b)/(d-(b.*f)));
