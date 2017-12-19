function [f,s11,s21,s12,s22]=leeS2P(fileToRead)
%  Lee fichero .s1p

DELIMITER = ' ';
HEADERLINES = 5;

% Import the file
newData = importdata([fileToRead '.s2p'], DELIMITER, HEADERLINES);

f=newData.data(:,1)/1e9;
s11=10.^(newData.data(:,2)/20).*exp(j*newData.data(:,3)*pi/180);
s21=10.^(newData.data(:,4)/20).*exp(j*newData.data(:,5)*pi/180);
s12=10.^(newData.data(:,6)/20).*exp(j*newData.data(:,7)*pi/180);
s22=10.^(newData.data(:,8)/20).*exp(j*newData.data(:,9)*pi/180);
