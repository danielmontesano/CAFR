function [  ] = dibujar( name,text )
figure;
if size(name,2)==3
    subplot(2,1,1);
    plot(name.f,name.S11);
    title('Magnitude (dB)');
    legend('S11');
    subplot(2,1,2);
    plot(name.f,name.S11_P);
    title('Phase (deg)');
    legend('S11');
    grid
end

if size(name,2)==9
    subplot(2,1,1);
    hold on;
    plot(name.f,name.S11);
    plot(name.f,name.S12);
    plot(name.f,name.S21);
    plot(name.f,name.S22);
    hold off;
    title('Magnitude (dB)');
    legend('S11', 'S12', 'S21', 'S22');
    grid
    subplot(2,1,2);
    hold on
    plot(name.f,unwrap(name.S11_P));
    plot(name.f,unwrap(name.S12_P));
    plot(name.f, unwrap(name.S21_P));
    plot(name.f,unwrap(name.S22_P));

    hold off;
    title('Phase (deg)');
    legend('S11', 'S12', 'S21', 'S22');
    grid
end
% suptitle(text)
clearvars name;

end

