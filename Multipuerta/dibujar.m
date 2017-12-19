function [  ] = dibujar(f,S11,S21,S12,S22,text )
figure;
    subplot(2,1,1);
    hold on;
    plot(f,20*log10(abs(S11)));
    plot(f,20*log10(abs(S12)));
    plot(f,20*log10(abs(S21));
    plot(f,20*log10(abs(S22));
    hold off;
    title([text,'. Magnitude (dB)']);
    legend('S11', 'S12', 'S21', 'S22');
    grid
    subplot(2,1,2);
    hold on
    plot(f,unwrap(angle(S11)));
    plot(f,unwrap(angle(S12)));
    plot(f,unwrap(angle(S21)));
    plot(f,unwrap(angle(S22)));

    hold off;
    title([text,'. Phase (deg)']);
    legend('S11', 'S12', 'S21', 'S22');
    xlabel('Frecuency (GHz)')
    grid

end

