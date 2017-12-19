function [  ] = dibujarRho(f,S11,text )
figure
    subplot(2,1,1);
    plot(f,20*log10(abs(S11)));
    title([text,'. Magnitude (dB)']);
    legend('S11');
    grid
    subplot(2,1,2);
    plot(f,unwrap(angle(S11))*180/pi);
%     plot(f,angle(S11)*180/pi);
    title([text,'. Phase (deg)']);
    legend('S11');
    xlabel('Frecuency (GHz)')
    grid
end