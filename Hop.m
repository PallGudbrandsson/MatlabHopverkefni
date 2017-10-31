% Pall gudbrandsson og co
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
Gogn = [];

for i = 1:length(Mappa)
    try
        % held tad turfi ekki ad hafa try catch en atla ekki ad taka strax
        y = dir(strcat(mappa,char(Mappa(i).name), '\*.dat'));
        for a = 1:6
            gogn = load(strcat(mappa,Mappa(i).name,'\',char(y(a).name)));
            Gogn{end+1} = gogn;
        end
     catch me         
         disp('error');
        % ef hingad er komid er Mappa(i).name ekki gilt skraar nafn. Geri
        % tetta tvi i minum prufum var vesen med nofnin
    end
end









































