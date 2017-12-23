clc, close all, clear all
Zo = 50;
[f,rho]=leeS1P('carga_puerto1');
[~,s11_P12_Zo,s21_P12_Zo,s12_P12_Zo,s22_P12_Zo]=leeS2P('wilkinson_12');
[~,s11_P13_Zo,s31_P13_Zo,s13_P13_Zo,s33_P13_Zo]=leeS2P('wilkinson_13');
[~,s22_P23_Zo,s23_P23_Zo,s32_P23_Zo,s33_P23_Zo]=leeS2P('wilkinson_23');

Zl = Zo*((1-rho)./(1+rho));

%%
close all

dibujarRho(f,rho,'Rho')
%%
dibujarCarga(f,Zl,'Carga')
%%
dibujar(f,s11_P12_Zo,s21_P12_Zo,s12_P12_Zo,s22_P12_Zo,'Puerto 12')
dibujar(f,s11_P13_Zo,s31_P13_Zo,s13_P13_Zo,s33_P13_Zo,'Puerto 13')
dibujar(f,s22_P23_Zo,s23_P23_Zo,s32_P23_Zo,s33_P23_Zo,'Puerto 23')
%%

Zx=70; % averiguar Zx
for n=1:size(f)
    
S_Zo1=[s11_P12_Zo(n) s12_P12_Zo(n),
        s21_P12_Zo(n) s22_P12_Zo(n)] ;
S_Zo2=[s11_P13_Zo(n) s13_P13_Zo(n),
        s31_P13_Zo(n) s33_P13_Zo(n)] ;
S_Zo3=[s22_P23_Zo(n) s23_P23_Zo(n),
        s32_P23_Zo(n) s33_P23_Zo(n)] ;

diagon = diag((Zx-Zo)/(Zx+Zo))*eye(2);
I=eye(2);
%Paso a Zl
S_Zx1(:,:,n)= inv((I-S_Zo1))*(S_Zo1-diagon)*inv((I-S_Zo1*diagon))*(I-S_Zo1);
S_Zx2(:,:,n)= inv((I-S_Zo2))*(S_Zo2-diagon)*inv((I-S_Zo2*diagon))*(I-S_Zo2);
S_Zx3(:,:,n)= inv((I-S_Zo3))*(S_Zo3-diagon)*inv((I-S_Zo3*diagon))*(I-S_Zo3);

%Conformar S total, existen mas combinaciones de parametros S, hay que
%comprobar que sean iguales
S_total(:,:,n)= [S_Zx1(1,1,n) S_Zx1(1,2,n) S_Zx2(1,2,n),
                 S_Zx1(2,1,n) S_Zx1(2,2,n) S_Zx3(1,2,n),
                 S_Zx2(2,1,n) S_Zx3(2,1,n) S_Zx3(2,2,n)];
            
diagonTotal = diag((Zo-Zx)/(Zx+Zo))*eye(3);
ITotal=eye(3);
%Paso a Zo
S_totalZo(:,:,n)=inv((ITotal-S_total(:,:,n)))*(S_total(:,:,n)-diagonTotal)*inv((ITotal-S_total(:,:,n)*diagonTotal))*(ITotal-S_total(:,:,n));
     
end

