function [f,rho]=leeS1P(fileToRead)
%  Lee fichero .s1p

DELIMITER = ' ';
HEADERLINES = 5;

% Import the file
newData = importdata([fileToRead '.s1p'], DELIMITER, HEADERLINES);

f=newData.data(:,1)/1e9;
rho=10.^(newData.data(:,2)/20).*exp(j*newData.data(:,3)*pi/180);