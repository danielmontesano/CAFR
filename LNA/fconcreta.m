clear all;
%% para una f concreta

%0.700  0.8073  -48.0  15.088  141.0  0.0368   65.7  0.8710  -27.7
 
 [f,s11,s21,s12,s22]=leeS2P('BFP640_25');
 f = f.*1e9*1e9; %los datos vienen en GHZ y en leeS2P se pasa a GHZ. hay que compensarlo 2 veces.
% s11= 10^(0.8073/20)*exp(j*-48.0*pi/180);
% s21= 10^(15.088/20)*exp(j*141.0*pi/180);
% s12= 10^(0.0368/20)*exp(j*65.7*pi/180);
% s22= 10^(0.8710/20)*exp(j*-27.7*pi/180);
f = find(f == 2e9); %Nos quedamos con freq 0.7GHz
s11= s11(f);
s21= s21(f);
s12= s12(f);
s22= s22(f);

determinanteS = s11.*s22-s12.*s21;

Cs = conj(s11 - determinanteS*conj(s22))/(abs(s11)^2 - abs(determinanteS)^2);
Rs = abs(s12*s21/(abs(s11)^2 - abs(determinanteS)^2));

Cl = (conj(s22)-s11*conj(determinanteS))/((abs(s22)^2)-(abs(determinanteS))^2);
Rl = abs((s12*s21)/((abs(s22)^2)-(abs(determinanteS))^2));

Zl = 50;
Zs = 50;
Z0 = 50;
Rol = (Zl-50)/(Zl+Z0);
Ros = (Zs-50)/(Zs+Z0);
Roin = s11 + s12*s21*Rol/(1-s22*Rol);
absRoin = abs(Roin);
Roout = s22 + s12*s21*Ros/(1-s11*Ros);
absRoout = abs(Roout);


fig = figure;
hsm = smithchart;
% hsm.Marker = 'o'; 
% hsm.MarkerFaceColor = 'r';
circleS = viscircles([real(Cs) imag(Cs)],Rs,'Color','b');
circleL = viscircles([real(Cl) imag(Cl)],Rl,'Color','r');
 text(real(Cs), imag(Cs),'Source','color','b','HorizontalAlignment', 'center','VerticalAlignment', 'middle');
 text(real(Cl), imag(Cl),'Load','color','r','HorizontalAlignment', 'center','VerticalAlignment', 'middle');

 if absRoin < 1
     fprintf('La carga de source %.2f%+.2fj es estable\n',real(Zs), imag(Zs));
 else
     fprintf('La carga de source %.2f%+.2fj es inestable\n',real(Zs), imag(Zs));
 end
 if absRoout < 1
     fprintf('La carga de load %.2f%+.2fj es estable\n',real(Zl), imag(Zl));
 else
     fprintf('La carga de load %.2f%+.2fj es inestable\n',real(Zl), imag(Zl));
 end
 
% hsm = smithchart(z2gamma(50+50*j)); hsm.Marker = 'o'; hsm.MarkerFaceColor = 'r';
%%

