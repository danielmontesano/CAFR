load('matlab.mat')
warning ('off','all');
close all;


[ S_Me, R_Me ] = StoR2(filter);
[ S_T, R_T ] = StoR2(through);
[ S_L, R_L ] = StoR2(line1);
 [ S_L2, R_L ] = StoR2(line2);
[ S11_Re1,  ] = StoR2(reflect1);
[ S11_Re2,  ] = StoR2(reflect2);
vec_f = through.f;


[Sx,GL] = trl(S_T,[S11_Re1 zeros(1,length(S11_Re1))' zeros(1,length(S11_Re1))' S11_Re2] ,S_L, S_Me ,vec_f);
figure;
hold on;
for n=1:4
    subplot(2,1,1);
    hold on;
plot(10*log10(abs(Sx(:,n))));
 legend('S11', 'S12', 'S21', 'S22');
subplot(2,1,2);
hold on;
plot(rad2deg(unwrap(angle(Sx(:,n)))));
 legend('S11', 'S12', 'S21', 'S22');
end
peak2peak(angle(Sx(:,2)))

% [Sx,GL] = trl(S_T,[S11_Re1 zeros(1,length(S11_Re1))' zeros(1,length(S11_Re1))' S11_Re2] ,S_L, S_L2,vec_f);
% figure;
% hold on;
% for n=1:4
%     subplot(2,1,1);
%     hold on;
% plot(10*log10(abs(Sx(:,n))));
%  legend('S11', 'S12', 'S21', 'S22');
% subplot(2,1,2);
% hold on;
% plot(unwrap(angle(Sx(:,n))));
%  legend('S11w', 'S12', 'S21', 'S22');
% end
% peak2peak(angle(Sx(:,2)))
