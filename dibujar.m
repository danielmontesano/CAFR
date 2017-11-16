name = 'line2';
v = genvarname(name);
figure;
if eval(['size(' v ',2)'])==3
    

    subplot(2,1,1);
    plot(eval([ v '.f']),eval([ v '.S11']));
    title('Magnitude (dB)');
    legend('S11');
    subplot(2,1,2);
    plot(eval([ v '.f']),eval(['unwrap(' v '.S11_P)']));
    title('Phase (deg)');
    legend('S11');

end

if eval(['size(' v ',2)'])==9
    subplot(2,1,1);
    hold on;
    plot(eval([ v '.f']),eval([ v '.S11']));
    plot(eval([ v '.f']),eval([ v '.S12']));
    plot(eval([ v '.f']),eval([ v '.S21']));
    plot(eval([ v '.f']),eval([ v '.S22']));
    hold off;
    title('Magnitude (dB)');
    legend('S11', 'S12', 'S21', 'S22');
    subplot(2,1,2);
    hold on
    plot(eval([ v '.f']),eval(['unwrap(' v '.S11_P)']));
    plot(eval([ v '.f']),eval(['unwrap(' v '.S12_P)']));
    plot(eval([ v '.f']),eval(['unwrap(' v '.S21_P)']));
    plot(eval([ v '.f']),eval(['unwrap(' v '.S22_P)']));
    hold off;
    title('Phase (deg)');
    legend('S11', 'S12', 'S21', 'S22');
end

clearvars v name;