clear all;
close all;
%% para una f concreta

%0.700  0.8073  -48.0  15.088  141.0  0.0368   65.7  0.8710  -27.7
 
amp = read(rfckt.amplifier,'BFP640_6.s2p');   
[s ,f] = extract(amp, 'S_parameters');

fig = figure;
hsm = smithchart;


step = 1/(length(f)+1);%Para que el slider vaya en numeros enteros.
sld = uicontrol('Style', 'slider','Min',1,'Max',length(f),...
'Value',37,'SliderStep',[step 5*step],'Units', 'normalized', 'Position', [0.3 0.005 0.5 0.05]);
sld.Callback = @(es,ed) updateGraph([],[],amp,s,f,hsm,sld.Value);
updateGraph([],[],amp,s,f,hsm,1);%Necesario actualizarlo la primera vez manualmente.
function updateGraph(source,event,amp,s,f,hsm,value)
if isempty(source)
            i = round(value);
        else
            i = round(source.Value);%Para poder actualizarlo manualmente
end

fc = f(i);
s_params = s(:,:,i);
h = findobj('type','line');
for n=1:length(h)
    delete(h(n));
end

[d, nf_i] = min(abs(amp.noisedata.Freq-fc));
Fmin = amp.noisedata.Fmin(nf_i+1);

 G = 10*log10(powergain(s_params,'Gmsg'))
%  circle(amp,fc,'Stab','In','Stab','Out','Ga',10:2:G, 'NF',Fmin:0.1:1.2, hsm);
circle(amp,fc,'Stab','In','Stab','Out', hsm);
 circle(amp,fc,'R',5.2,hsm)
 circle(amp,fc,'G',1.16,hsm)
 
% s_params = s_params(find(s_params==fc));
Zl = 50;
Zs = 50;
Z0 = 50;

Roin = gammain(s_params,Z0,Zl);
absRoin = abs(Roin);
Roout = gammaout(s_params,Z0,Zs);
absRoout = abs(Roout);

 fprintf('Frecuencia: %d% GHz\n',fc);

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