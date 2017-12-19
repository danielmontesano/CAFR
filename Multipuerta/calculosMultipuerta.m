
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
% dibujar(f,s11_P13_Zo,s31_P13_Zo,s13_P13_Zo,s33_P13_Zo,'Puerto 13')
% dibujar(f,s22_P23_Zo,s23_P23_Zo,s32_P23_Zo,s33_P23_Zo,'Puerto 23')