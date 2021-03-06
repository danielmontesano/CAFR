%% Ejercicio 3
%%

clc
% clear
close all
%%
load('matlab.mat')
% dibujar(filter,'Filter')
% dibujar(through,'Through')
 dibujar(line1,'Line 1')
% dibujar(line2,'Line 2')
% dibujar(reflect1,'Reflect 1')
% dibujar(reflect2,'Reflect 2')

%%
vec_f = through.f;
line = line1;
[ S_Me, R_Me ] = StoR(line1);
[ S_T, R_T ] = StoR(through);
[ S_L, R_L ] = StoR(line);
% [ S_L2, R_L ] = StoR(line2);
[ S11_Re1,  ] = StoR(reflect1);
[ S11_Re2,  ] = StoR(reflect2);

    for n=1:size(R_T,3)

        T = R_L(:,:,n)*inv(R_T(:,:,n));
        
        p = [T(2,1) T(2,2)-T(1,1) -T(1,2)];
        raizT = roots(p);
        
        if(abs(raizT(1))>abs(raizT(2)))
            c_a = 1/raizT(1); %c/a
            b   = raizT(2);
        else
            c_a   = 1/raizT(2);
            b = raizT(1);
        end
        
%         g = 1/S_T(2,1,n);
%         d = -det(S_T(:,:,n));
%         e = S_T(1,1,n);
%         f = -S_T(2,2,n);
        g = R_T(2,2,n);
        d = R_T(1,1,n)/R_T(2,2,n);
        e =  R_T(1,2,n)/R_T(2,2,n);
        f =  R_T(2,1,n)/R_T(2,2,n);
        
        r22p22 = g*((1-(e*c_a))/(1-(b*c_a)));
        gamma = (f-(d*c_a))/(1-(e*c_a));
        alphaPorA = (d-(b*f))/(1-(e*c_a)); %Alpha*a
        beta_alpha = (e-b)/(d-(b*f));  %Beta/a
        
        a_Alpha = ((S11_Re1(n)-b)*(1+(S11_Re2(n)*beta_alpha)))/...
                  ((S11_Re2(n)+gamma)*(1-(S11_Re1(n)*c_a)));
        a = sqrt(alphaPorA*a_Alpha);
         
        gamma_R = (S11_Re1(n)-b)/(a*(1-(S11_Re1(n)*c_a)));
        
%         if( rad2deg(abs(angle(S11_Re1(n))))>90)
        if( rad2deg((angle(gamma_R)))>90 && rad2deg((angle(gamma_R)))<270)

          a = -a; 
        end
        
         gamma_RCa = (S11_Re1(n)-b)/(a*(1-(S11_Re1(n)*c_a)));

        c = a*c_a;
        alpha = alphaPorA/a;
        beta = alpha*beta_alpha;

        IRa = [1 -b; -c a];
        IRb = [1 -beta; -gamma alpha];
        
        % R Dut
        Rm  = (1/(r22p22*(a-(b*c))*(alpha-(gamma*beta))))*IRa*R_Me(:,:,n)*IRb;    

        S11 =  Rm(1,2)/Rm(2,2);
        S12 =  det(Rm)/Rm(2,2);
        S21 =  1/Rm(2,2);
        S22 = -Rm(2,1)/Rm(2,2);

        coefgamma_RCa(n) = gamma_RCa;            
        coefgamma_R(n) = gamma_R;
        coefr22p22 = r22p22;
        coefA(n) = a;
        coefB(n) = b;
        coefC(n) = c;
        coefAlpha(n) = alpha;
        coefBeta(n) = beta;
        coefGamma(n) = gamma;

        S11_M(n) = 20*log10(abs(S11));
        S11_P(n) = radtodeg(angle(S11));
        S12_M(n) = 20*log10(abs(S12));
        S12_P(n) = radtodeg(angle(S12));
        S21_M(n) = 20*log10(abs(S21));
        S21_P(n) = radtodeg(angle(S21));
        S22_M(n) = 20*log10(abs(S22));
        S22_P(n) = radtodeg(angle(S22));
        
        
        if(isequal(line,line1))
            l = 0.00703;
        else 
            l = 0.02417;
        end
        gammaM(n)=log(S21)/-l;
        betaL(n)= unwrap(imag(gammaM(n))*l);
        tauL(n)=betaL(n)/(2*pi*vec_f(n));
        
    end
    
    DUT = table(vec_f,S11_M',S11_P',S12_M',S12_P',S21_M',S21_P',S22_M',S22_P');
    DUT.Properties.VariableNames = {'f','S11','S11_P','S12','S12_P','S21','S21_P','S22','S22_P'};
    
 dibujar(DUT,'DUT')
%%    
lim1=160*ones(1, length(vec_f));
lim2=20*ones(1, length(vec_f));
figure, plot(vec_f/1e9, rad2deg((abs(betaL))));
xlabel('Frecuency (GHz)')
title('\betaL (grados)')
hold on
plot(vec_f/1e9, lim1);
plot(vec_f/1e9, lim2);
hold off
%%
figure

plot(vec_f/1e9,tauL/1e-12);
xlabel('Frecuency (GHz)')
title('\alpha')
        if(isequal(line,line1))
           retardo = mean(tauL/1e-12)
        else 
           retardo = mean(tauL(1:375)/1e-12)
        end

%%
figure

subplot(2,1,1),plot(vec_f/1e9,real(gammaM));
xlabel('Frecuency (GHz)')
title('\alpha')
subplot(2,1,2)
plot(vec_f/1e9,imag(gammaM));  
xlabel('Frecuency (GHz)')
title('\beta')
%%
figure, plot(vec_f/1e9,radtodeg(angle(coefgamma_R)))
hold on
plot(vec_f/1e9,radtodeg(angle(coefgamma_RCa)),'LineWidth',2)
hold off
xlabel('Frecuency (GHz)')
legend('sin correguir','Calibrado')
