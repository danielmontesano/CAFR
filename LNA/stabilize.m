clear all;
fc=2.4e9;

unmatched_amp = read(rfckt.amplifier,'BFP640_6.s2p'); 
[s ,f] = extract(unmatched_amp, 'S_parameters');
[d, nf_i] = min(abs(unmatched_amp.NoiseData.Freq-fc));
Fmin = unmatched_amp.NoiseData.Fmin(nf_i+1);


 
analyze(unmatched_amp,f);

shunt_r = rfckt.shuntrlc('R',43);
stab_amp = rfckt.cascade('ckts',{unmatched_amp,shunt_r});
analyze(stab_amp,f);

% [s ,f] = extract(stab_amp, 'S_parameters');
% [d, g_i] = min(abs(f-fc));
% s_params = s(:,:,g_i+1);
% G = 10*log10(powergain(s_params,'Gmsg'));

circle(stab_amp,fc,'Ga',13:0.1:15.47,'NF',0.7:0.05:1)
% 
% GammaS = 0.462*exp(1j*98.3*pi/180);
 GammaL = -0.33+j*0.18;
%GammaL = 0.405*exp(-1j*147.1*pi/180);
 GammaS = 0+j*0.38;
Zs = gamma2z(GammaS,1);

Zl = gamma2z(GammaL,1);


[hlines,hsm] = circle(stab_amp,fc,'G',1,'R',real(Zs)); 
hsm.Type = 'YZ';
hold all
plot(GammaS,'k.','MarkerSize',16)
text(real(GammaS)+0.05,imag(GammaS)-0.05,'\Gamma_{S}','FontSize', 12, ...
    'FontUnits','normalized')
plot(0,0,'k.','MarkerSize',16)
hold off

GammaA = 0.391*exp(1j*(-112.3)*pi/180);
Za = gamma2z(GammaA,1);
Ya = 1/Za;

Cin = imag(Ya)/50/2/pi/fc

Lin = (imag(Zs) - imag(Za))*50/2/pi/fc

[hlines,hsm] = circle(stab_amp,fc,'G',1,'R',real(Zl)); 
hsm.Type = 'YZ';
hold all
plot(GammaL,'k.','MarkerSize',16)
text(real(GammaL)+0.05,imag(GammaL)-0.05,'\Gamma_{L}','FontSize', 12, ...
    'FontUnits','normalized')
plot(0,0,'k.','MarkerSize',16)
hold off


GammaB = 0.4847*exp(1j*(-117.8)*pi/180);
Zb = gamma2z(GammaB, 1);
Yb = 1/Zb;
Cout = imag(Yb)/50/2/pi/fc
Lout = (imag(Zl) - imag(Zb))*50/2/pi/fc


input_match = rfckt.cascade('Ckts', ...
    {rfckt.shuntrlc('C',Cin),rfckt.seriesrlc('L',Lin)});
output_match = rfckt.cascade('Ckts', ...
    {rfckt.seriesrlc('L',Lout),rfckt.shuntrlc('C',Cout)});
LNA = rfckt.cascade('ckts', ...
    {input_match,unmatched_amp,shunt_r,output_match});



analyze(LNA,f);
plot(LNA,'Ga','Gt','dB');

plot(LNA,'NF','dB')

