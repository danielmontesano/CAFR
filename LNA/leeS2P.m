function [f,s11,s21,s12,s22]=leeS2P(fileToRead)
%  Lee fichero .s1p

startRow = 8;
endRow = 106;

formatSpec = '%6f%8f%7f%8f%7f%8f%7f%8f%f%[^\n\r]';
fileID = fopen([fileToRead '.s2p'],'r');

dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'HeaderLines', startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

fclose(fileID);

% Import the file
data = [dataArray{1:end-1}];
f=data(:,1)/1e9;
s11=10.^(data(:,2)/20).*exp(j*data(:,3)*pi/180);
s21=10.^(data(:,4)/20).*exp(j*data(:,5)*pi/180);
s12=10.^(data(:,6)/20).*exp(j*data(:,7)*pi/180);
s22=10.^(data(:,8)/20).*exp(j*data(:,9)*pi/180);
