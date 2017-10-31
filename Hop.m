% Pall gudbrandsson
% Lel�ta R�s Ycot
% Ragnhildur Gu�mundsd�ttir
% Kolbr�n D�ra Magn�sd�ttir
% �orbj�rg Katr�n Dav��sd�ttir

% hopverkefni 2017

%%
close all
clear all
clc

Mappa = {};
y = [];

pwd = strcat(pwd, '\MatlabHopverkefni');
mappa = strcat(pwd, '\Data\');
Mappa= dir(mappa);
GognMann = [];
GognFluga = [];

for i = 1:length(Mappa)
    try
        y = dir(strcat(mappa,char(Mappa(i).name), '/*.dat'));
        for a = 1:6
            gogn = load(strcat(mappa,Mappa(i).name,'\',char(y(a).name)));
            GognMann{end+1} = gogn;
        end
     catch me         
         disp('error');
        % ef hingad er komid er Mappa(i).name ekki gilt skraar nafn
    end
end

% les inn allt fyrir fluguna

mappa = strcat(pwd,'\Fluga\');
a = dir(strcat(mappa, '*.dat'));

for i = 1:length(a)
    gogn = importdata(strcat(mappa,char(a(i).name)));
    GognFluga{i} = gogn;
end
%GognFluga{1}.data(:,1)

% % Hernar er teiknad upp ferlarnir fyrir fluguna
% for i = 1:length(a)
%     figure
%     plot(GognFluga{i}.data(:,1),GognFluga{i}.data(:,2),'k','Linewidth',2);
% end
% 
% for i = 1:length(GognMann)
%     figure
%     plot(GognMann{i}(:,2),GognMann{i}(:,3))
% end

% Greina ferla








































