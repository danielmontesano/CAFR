clc, close all, clear all
Zo = 50;
[f,rho]=leeS1P('carga_puerto1');
[~,s11_P12_Zo,s21_P12_Zo,s12_P12_Zo,s22_P12_Zo]=leeS2P('wilkinson_12');
[~,s11_P13_Zo,s31_P13_Zo,s13_P13_Zo,s33_P13_Zo]=leeS2P('wilkinson_13');
[~,s22_P23_Zo,s23_P23_Zo,s32_P23_Zo,s33_P23_Zo]=leeS2P('wilkinson_23');

Zl = Zo*((1+rho)./(1-rho));

%%
close all

dibujarRho(f,rho,'Rho')
%%
dibujarCarga(f,Zl,'Load')
%%
dibujar(f,s11_P12_Zo,s21_P12_Zo,s12_P12_Zo,s22_P12_Zo,'Port 12 ref to Zo')
dibujar(f,s11_P13_Zo,s31_P13_Zo,s13_P13_Zo,s33_P13_Zo,'Port 13 ref to Zo')
dibujar(f,s22_P23_Zo,s23_P23_Zo,s32_P23_Zo,s33_P23_Zo,'Port 23 ref to Zo')
%%

% Zl=70; % averiguar Zx
for n=1:size(f)
    
S_Zo1=[s11_P12_Zo(n) s12_P12_Zo(n),
        s21_P12_Zo(n) s22_P12_Zo(n)] ;
S_Zo2=[s11_P13_Zo(n) s13_P13_Zo(n),
        s31_P13_Zo(n) s33_P13_Zo(n)] ;
S_Zo3=[s22_P23_Zo(n) s23_P23_Zo(n),
        s32_P23_Zo(n) s33_P23_Zo(n)] ;

diagon = diag((Zl(n)-Zo)/(Zl(n)+Zo))*eye(2);
I=eye(2);
%Paso a Zl
S_Zx1(:,:,n)= inv((I-S_Zo1))*(S_Zo1-diagon)*inv((I-S_Zo1*diagon))*(I-S_Zo1);
S_Zx2(:,:,n)= inv((I-S_Zo2))*(S_Zo2-diagon)*inv((I-S_Zo2*diagon))*(I-S_Zo2);
S_Zx3(:,:,n)= inv((I-S_Zo3))*(S_Zo3-diagon)*inv((I-S_Zo3*diagon))*(I-S_Zo3);

% S_Zx1 = inv((I-S_Zo1))*(S_Zo1-diagon)*inv((I-S_Zo1*diagon))*(I-S_Zo1);
% S_Zx2 = inv((I-S_Zo2))*(S_Zo2-diagon)*inv((I-S_Zo2*diagon))*(I-S_Zo2);
% S_Zx3 = inv((I-S_Zo3))*(S_Zo3-diagon)*inv((I-S_Zo3*diagon))*(I-S_Zo3);

s11_P12_Zl(n) = S_Zx1(1,1,n);
s21_P12_Zl(n) = S_Zx1(1,2,n);
s12_P12_Zl(n) = S_Zx1(2,1,n);
s22_P12_Zl(n) = S_Zx1(2,2,n);

s11_P13_Zl(n) = S_Zx2(1,1,n);
s31_P13_Zl(n) = S_Zx2(1,2,n);
s13_P13_Zl(n) = S_Zx2(2,1,n);
s33_P13_Zl(n) = S_Zx2(2,2,n);

s22_P23_Zl(n) = S_Zx3(1,1,n);
s23_P23_Zl(n) = S_Zx3(1,2,n);
s32_P23_Zl(n) = S_Zx3(2,1,n);
s33_P23_Zl(n) = S_Zx3(2,2,n);


%Conformar S total, existen mas combinaciones de parametros S, hay que
%comprobar que sean iguales
S_total1(:,:,n)= [S_Zx1(1,1,n) S_Zx1(1,2,n) S_Zx2(1,2,n),
                 S_Zx1(2,1,n) S_Zx1(2,2,n) S_Zx3(1,2,n),
                 S_Zx2(2,1,n) S_Zx3(2,1,n) S_Zx3(2,2,n)];
S_total2(:,:,n)= [S_Zx2(1,1,n) S_Zx1(1,2,n) S_Zx2(1,2,n),
                 S_Zx1(2,1,n) S_Zx3(1,1,n) S_Zx3(1,2,n),
                 S_Zx2(2,1,n) S_Zx3(2,1,n) S_Zx2(2,2,n)];

   
diagonTotal = diag((Zo-Zl(n))/(Zl(n)+Zo))*eye(3);
ITotal=eye(3);
%Paso a Zo
S_totalZo(:,:,n)=inv((ITotal-S_total1(:,:,n)))*(S_total1(:,:,n)-diagonTotal)*inv((ITotal-S_total1(:,:,n)*diagonTotal))*(ITotal-S_total1(:,:,n));
S_totalZo2(:,:,n)=inv((ITotal-S_total2(:,:,n)))*(S_total2(:,:,n)-diagonTotal)*inv((ITotal-S_total2(:,:,n)*diagonTotal))*(ITotal-S_total2(:,:,n));

end

%%

dibujar(f,s11_P12_Zl,s21_P12_Zl,s12_P12_Zl,s22_P12_Zl,'Port 12 ref to Zl')
dibujar(f,s11_P13_Zl,s31_P13_Zl,s13_P13_Zl,s33_P13_Zl,'Port 13 ref to Zl')
dibujar(f,s22_P23_Zl,s23_P23_Zl,s32_P23_Zl,s33_P23_Zl,'Port 23 ref to Zl')

%%
    figure(9)
    subplot(2,1,1)
    hold on
    plot(f,20*log10(abs(s11_P12_Zl)))
    plot(f,20*log10(abs(s11_P13_Zl)))
    hold off
    grid,title('S_{11} Magnitude (dB)'),legend('Port 12', 'Port 13')

    subplot(2,1,2)
    hold on
    plot(f,unwrap(angle(s11_P12_Zl)*180/pi))
    plot(f,unwrap(angle(s11_P13_Zl)*180/pi))
    hold off
    grid,title('Phase (deg)'),legend('Port 12', 'Port 13')
    xlabel('Frecuency (GHz)')
 
    figure(10)
    subplot(2,1,1)
    hold on
    plot(f,20*log10(abs(s22_P12_Zl)))
    plot(f,20*log10(abs(s22_P23_Zl)))
    hold off
    grid,title('S_{22} Magnitude (dB)'),legend('Port 12', 'Port 23')

    subplot(2,1,2)
    hold on
    plot(f,unwrap(angle(s22_P12_Zl)*180/pi))
    plot(f,unwrap(angle(s22_P23_Zl)*180/pi))
    hold off
    grid,title('Phase (deg)'),legend('Port 12', 'Port 23')
    xlabel('Frecuency (GHz)') 

    figure(11)
    subplot(2,1,1)
    hold on
    plot(f,20*log10(abs(s33_P13_Zl)))
    plot(f,20*log10(abs(s33_P23_Zl)))
    hold off
    grid,title('S_{33} Magnitude (dB)'),legend('Port 13', 'Port 23')

    subplot(2,1,2)
    hold on
    plot(f,unwrap(angle(s33_P13_Zl)*180/pi))
    plot(f,unwrap(angle(s33_P23_Zl)*180/pi))
    hold off
    grid,title('Phase (deg)'),legend('Port 13', 'Port 23')
    xlabel('Frecuency (GHz)') 

%% Representacion matriz 3x3 normalizada a Zl y a Zo

S_3x3_Zl = S_total1;  % S_total1 o S_total2 ref
S_3x3_Zo = S_totalZo;
    
% Ref to Zl
    figure(12)
    subplot(211)
    hold on
    plot(f,20*log10(abs(squeeze(S_3x3_Zl(1,1,:)))),'LineWidth', 2)
    plot(f,20*log10(abs(squeeze(S_3x3_Zl(1,2,:)))),'LineWidth', 2)
    plot(f,20*log10(abs(squeeze(S_3x3_Zl(1,3,:)))),'LineWidth', 2)

    plot(f,20*log10(abs(squeeze(S_3x3_Zl(2,1,:)))),'LineWidth', 2)
    plot(f,20*log10(abs(squeeze(S_3x3_Zl(2,2,:)))),'LineWidth', 2)
    plot(f,20*log10(abs(squeeze(S_3x3_Zl(2,3,:)))),'LineWidth', 2)
    
    plot(f,20*log10(abs(squeeze(S_3x3_Zl(3,1,:)))),'LineWidth', 2)
    plot(f,20*log10(abs(squeeze(S_3x3_Zl(3,2,:)))),'LineWidth', 2)
    plot(f,20*log10(abs(squeeze(S_3x3_Zl(3,3,:)))),'LineWidth', 2)
    
    hold off
    grid,title('S TOTAL Magnitude (dB) to Z_{L}')
    legend('S11', 'S12', 'S13', 'S21', 'S22', 'S23', 'S31', 'S32', 'S33','Location','bestoutside')
    xlabel('Frecuency (GHz)') 
%     figure(13)
%     hold on
%     plot(f,angle((squeeze(S_3x3_Zl(1,1,:))))*180/pi,'LineWidth', 2)
%     plot(f,angle((squeeze(S_3x3_Zl(1,2,:))))*180/pi,'LineWidth', 2)
%     plot(f,angle((squeeze(S_3x3_Zl(1,3,:))))*180/pi,'LineWidth', 2)
% 
%     plot(f,angle((squeeze(S_3x3_Zl(2,1,:))))*180/pi,'LineWidth', 2)
%     plot(f,angle((squeeze(S_3x3_Zl(2,2,:))))*180/pi,'LineWidth', 2)
%     plot(f,angle((squeeze(S_3x3_Zl(2,3,:))))*180/pi,'LineWidth', 2)
%     
%     plot(f,angle((squeeze(S_3x3_Zl(3,1,:))))*180/pi,'LineWidth', 2)
%     plot(f,angle((squeeze(S_3x3_Zl(3,2,:))))*180/pi,'LineWidth', 2)
%     plot(f,angle((squeeze(S_3x3_Zl(3,3,:))))*180/pi,'LineWidth', 2)
%     
%     hold off
%     grid,title('S TOTAL ANGLE (dB) to Zo')
%     legend ('S11', 'S12', 'S13', 'S21', 'S22', 'S23', 'S31', 'S32', 'S33')

%     figure(14)
    subplot(212)
    hold on
    plot(f,unwrap(angle((squeeze(S_3x3_Zl(1,1,:)))))*180/pi,'LineWidth', 2)
    plot(f,unwrap(angle((squeeze(S_3x3_Zl(1,2,:)))))*180/pi,'LineWidth', 2)
    plot(f,unwrap(angle((squeeze(S_3x3_Zl(1,3,:)))))*180/pi,'LineWidth', 2)

    plot(f,unwrap(angle((squeeze(S_3x3_Zl(2,1,:)))))*180/pi,'LineWidth', 2)
    plot(f,unwrap(angle((squeeze(S_3x3_Zl(2,2,:)))))*180/pi,'LineWidth', 2)
    plot(f,unwrap(angle((squeeze(S_3x3_Zl(2,3,:)))))*180/pi,'LineWidth', 2)
    
    plot(f,unwrap(angle((squeeze(S_3x3_Zl(3,1,:)))))*180/pi,'LineWidth', 2)
    plot(f,unwrap(angle((squeeze(S_3x3_Zl(3,2,:)))))*180/pi,'LineWidth', 2)
    plot(f,unwrap(angle((squeeze(S_3x3_Zl(3,3,:)))))*180/pi,'LineWidth', 2)
    
    hold off
    grid,title('S TOTAL ANGLE (dB) to Z_{L}')
    legend ('S11', 'S12', 'S13', 'S21', 'S22', 'S23', 'S31', 'S32', 'S33','Location','bestoutside')
    xlabel('Frecuency (GHz)') 
%% Ref to Zo
    figure(15)
    subplot(211)
    hold on
    plot(f,20*log10(abs(squeeze(S_3x3_Zo(1,1,:)))),'LineWidth', 2)
    plot(f,20*log10(abs(squeeze(S_3x3_Zo(1,2,:)))),'LineWidth', 2)
    plot(f,20*log10(abs(squeeze(S_3x3_Zo(1,3,:)))),'LineWidth', 2)

    plot(f,20*log10(abs(squeeze(S_3x3_Zo(2,1,:)))),'LineWidth', 2)
    plot(f,20*log10(abs(squeeze(S_3x3_Zo(2,2,:)))),'LineWidth', 2)
    plot(f,20*log10(abs(squeeze(S_3x3_Zo(2,3,:)))),'LineWidth', 2)
    
    plot(f,20*log10(abs(squeeze(S_3x3_Zo(3,1,:)))),'LineWidth', 2)
    plot(f,20*log10(abs(squeeze(S_3x3_Zo(3,2,:)))),'LineWidth', 2)
    plot(f,20*log10(abs(squeeze(S_3x3_Zo(3,3,:)))),'LineWidth', 2)
    
    hold off
    grid,title('S TOTAL Magnitude (dB) to Z_{o}')
    legend ('S11', 'S12', 'S13', 'S21', 'S22', 'S23', 'S31', 'S32', 'S33','Location','bestoutside')
    xlabel('Frecuency (GHz)') 
    
%     figure(16)
%     hold on
%     plot(f,angle((squeeze(S_3x3_Zo(1,1,:))))*180/pi,'LineWidth', 2)
%     plot(f,angle((squeeze(S_3x3_Zo(1,2,:))))*180/pi,'LineWidth', 2)
%     plot(f,angle((squeeze(S_3x3_Zo(1,3,:))))*180/pi,'LineWidth', 2)
% 
%     plot(f,angle((squeeze(S_3x3_Zo(2,1,:))))*180/pi,'LineWidth', 2)
%     plot(f,angle((squeeze(S_3x3_Zo(2,2,:))))*180/pi,'LineWidth', 2)
%     plot(f,angle((squeeze(S_3x3_Zo(2,3,:))))*180/pi,'LineWidth', 2)
%     
%     plot(f,angle((squeeze(S_3x3_Zo(3,1,:))))*180/pi,'LineWidth', 2)
%     plot(f,angle((squeeze(S_3x3_Zo(3,2,:))))*180/pi,'LineWidth', 2)
%     plot(f,angle((squeeze(S_3x3_Zo(3,3,:))))*180/pi,'LineWidth', 2)
%     
%     hold off
%     grid,title('S TOTAL ANGLE (dB) to Zo')
    legend ('S11', 'S12', 'S13', 'S21', 'S22', 'S23', 'S31', 'S32', 'S33','Location','bestoutside')
    xlabel('Frecuency (GHz)') 
%     figure(17)
    subplot(212)
    hold on

    plot(f,unwrap(angle((squeeze(S_3x3_Zo(1,1,:)))))*180/pi,'LineWidth', 2)
    plot(f,unwrap(angle((squeeze(S_3x3_Zo(1,2,:)))))*180/pi,'LineWidth', 2)
    plot(f,unwrap(angle((squeeze(S_3x3_Zo(1,3,:)))))*180/pi,'LineWidth', 2)

    plot(f,unwrap(angle((squeeze(S_3x3_Zo(2,1,:)))))*180/pi,'LineWidth', 2)
    plot(f,unwrap(angle((squeeze(S_3x3_Zo(2,2,:)))))*180/pi,'LineWidth', 2)
    plot(f,unwrap(angle((squeeze(S_3x3_Zo(2,3,:)))))*180/pi,'LineWidth', 2)
    
    plot(f,unwrap(angle((squeeze(S_3x3_Zo(3,1,:)))))*180/pi,'LineWidth', 2)
    plot(f,unwrap(angle((squeeze(S_3x3_Zo(3,2,:)))))*180/pi,'LineWidth', 2)
    plot(f,unwrap(angle((squeeze(S_3x3_Zo(3,3,:)))))*180/pi,'LineWidth', 2)
    
    hold off
    grid,title('S TOTAL ANGLE (dB) to Z_{o}')
    legend('S11', 'S12', 'S13', 'S21', 'S22', 'S23', 'S31', 'S32', 'S33','Location','bestoutside')
    xlabel('Frecuency (GHz)') 
    
    