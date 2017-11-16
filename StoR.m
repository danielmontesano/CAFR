function [ S_bi, R ] = StoR( S )
%Pasar S (dB y ang) a S binomial. Pasa tambien S binomial a R. 
if size(S,2)==3
    S_bi(1,1,:) = 10.^(S.S11/10).*exp(j.*deg2rad(S.S11_P));

end
if size(S,2)==9
    S_bi(1,1,:) = 10.^(S.S11/10).*exp(j.*deg2rad(S.S11_P));
    S_bi(1,2,:) = 10.^(S.S12/10).*exp(j.*deg2rad(S.S12_P));
    S_bi(2,1,:) = 10.^(S.S21/10).*exp(j.*deg2rad(S.S21_P));
    S_bi(2,2,:) = 10.^(S.S22/10).*exp(j.*deg2rad(S.S22_P));
    for n=1:size(S_bi,3)
        R(1,1,n) = -det(S_bi(:,:,n))./S_bi(2,1,n);
    end
    R(1,2,:) = S_bi(1,1,:)./S_bi(2,1,:);
    R(2,1,:) = -S_bi(2,2,:)./S_bi(2,1,:);
    R(2,2,:) = 1./S_bi(2,1,:);
end
end

