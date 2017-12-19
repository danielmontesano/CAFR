function [  ] = dibujarCarga(f,Zl,text )
figure
    subplot(2,1,1);
    plot(f,real(Zl));
    title([text,'. Real Part']);
    legend('Ro');
    grid
    subplot(2,1,2);
%     plot(f,unwrap(angle(S11))*180/pi);
    plot(f,imag(Zl));
    title([text,'. Imaginary Part']);
    legend('Xo');
    xlabel('Frecuency (GHz)')
    grid
end