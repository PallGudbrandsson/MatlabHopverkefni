% Pall gudbrandsson og co
% hopverkefni 2017

%% damid
close all
clear all
clc

Mappa = {};
y = [];

pwd = strcat(pwd, '\MatlabHopverkefni\');
mappa = strcat(pwd, '\Data\')
Mappa= dir(strcat(mappa))

% C:\Users\Palli\Documents\MATLAB\Heilbrigðir\
for i = 1:length(Mappa)
    try
        % held tad turfi ekki ad hafa try catch en atla ekki ad taka strax
        y{i} = dir(strcat(mappa,char(Mappa(i).name), '\*.dat'));
        dir(strcat(mappa,char(Mappa(i).name), '\*.dat'))
    catch me
        disp('error');
        % ef hingad er komid er Mappa(i).name ekki gilt skraar nafn. Geri
        % tetta tvi i minum prufum var vesen med nofnin
    end
end