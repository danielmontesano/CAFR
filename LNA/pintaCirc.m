clear all;
close all;
%% para una f concreta

%0.700  0.8073  -48.0  15.088  141.0  0.0368   65.7  0.8710  -27.7
 
 [f,s11,s21,s12,s22]=leeS2P('BFP640_45');
 f = f.*1e9*1e9; %los datos vienen en GHZ y en leeS2P se pasa a GHZ. hay que compensarlo 2 veces.

 fig = figure;
hsm = smithchart;


step = 1/(length(f)-1);%Para que el slider vaya en numeros enteros.
sld = uicontrol('Style', 'slider','Min',1,'Max',length(f),...
'Value',1,'SliderStep',[step 5*step],'Units', 'normalized', 'Position', [0.3 0.005 0.5 0.05]);
sld.Callback = @(es,ed) updateGraph([],[],s11, s21, s12, s22,f,sld.Value);
updateGraph([],[],s11, s21, s12, s22,f,1);%Necesario actualizarlo la primera vez manualmente.
function updateGraph(source,event,s11,s21,s12,s22,f,value)
if isempty(source)
            i = round(value);
        else
            i = round(source.Value);%Para poder actualizarlo manualmente
end

h = findobj('type','line');
for n=1:length(h)
    delete(h(n));
end
h = findobj('type','text');
for n=1:length(h)
   if (strcmp(h(n).String,'Load') | strcmp(h(n).String,'Source') )
       delete(h(n));
   end
end


        
%i = find(f == 2e9);
s11 = s11(i);
s21 = s21(i);
s12 = s12(i);
s22 = s22(i);

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

%hsm = smithchart;

% hsm.Marker = 'o'; 
% hsm.MarkerFaceColor = 'r';
circleS = viscircles([real(Cs) imag(Cs)],Rs,'Color','b');
circleL = viscircles([real(Cl) imag(Cl)],Rl,'Color','r');

 text(real(Cs), imag(Cs),'Source','color','b','HorizontalAlignment', 'center','VerticalAlignment', 'middle');
 text(real(Cl), imag(Cl),'Load','color','r','HorizontalAlignment', 'center','VerticalAlignment', 'middle');

      fprintf('Frecuencia: %d% GHz\n',f(i));

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
 
end