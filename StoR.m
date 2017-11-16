function [ S_bi ] = StoR( S )
%Pasar S dB y ang a S binomial. 
S_bi = table;
if size(S,2)==3
    S_bi.f = S.f;
    S_bi.S11 = 10.^(S.S11/10).*exp(j.*deg2rad(S.S11_P));
end
if size(S,2)==9
    S_bi.f = S.f;
    S_bi.S11 = 10.^(S.S11/10).*exp(j.*deg2rad(S.S11_P));
    S_bi.S12 = 10.^(S.S12/10).*exp(j.*deg2rad(S.S12_P));
    S_bi.S21 = 10.^(S.S21/10).*exp(j.*deg2rad(S.S21_P));
    S_bi.S22 = 10.^(S.S22/10).*exp(j.*deg2rad(S.S22_P));
end
end

