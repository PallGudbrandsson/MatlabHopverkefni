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
nofn = [];
Nofn = [];
pwd = strcat(pwd, '\MatlabHopverkefni');
mappa = strcat(pwd, '\Data\');
Mappa= dir(mappa);
GognMann = [];
GognFluga = [];
gogn = [];
teljari = 1;

for i = 1:length(Mappa) % Herna eru oll gogn sem vid notum til ad lesa inn gogn em manneskjuna skref 1.1
    try
        gogn = innlestur(strcat(mappa,Mappa(i).name),'.dat');
        
        for a = 1:length(gogn) 
            % tetta skref er til ad fa gognin ur cell og uppi struct. Tetta
            % er gert tvi ekki nadist ad finna betri leid til ad fa kodann
            % innan ur struct inni cell yfir i struct eins og restin af
            % kodanum gerir rad fyrir.
            GognMann{end+1} = gogn{a};
        end
     catch me  
         disp('error');
         disp(Mappa(i).name);
        % ef hingad er komid er Mappa(i).name ekki gilt skraar nafn
    end
end

% herna les eg inn gognin um fluguna skref 1.2
mappa = strcat(pwd,'\Fluga\');
GognFluga = innlestur(mappa,'.dat');




% Greina ferla skref 2
% (i-1)*6+1:i*6;
tegundir = [];
lettur = 1679; midlungs = 1364; erfidur = 1278;
tegundir{1} = greining(GognMann,lettur,'Lett');
tegundir{3} = greining(GognMann,midlungs,'Midlungs');
tegundir{2} = greining(GognMann,erfidur,'Erfidur');

%sortera tegundir
Tegund = ones(1,(length(tegundir{1})+length(tegundir{2})+length(tegundir{2})));
teljari1 = 1; teljari2 = 1; teljari3 = 1;
for i = 1:length(Tegund)
    if tegundir{1}(teljari1) == i
        Tegund(i) = 1;
        if teljari1 ~= 30
            teljari1 = teljari1 + 1;
        end
    elseif tegundir{2}(teljari2) == i
        Tegund(i) = 2;
        if teljari2 ~= 30
            teljari2 = teljari2 + 1;
        end
    elseif tegundir{3}(teljari3) == i
        Tegund(i) = 3;
        if teljari ~= 30
            teljari3 = teljari3 + 1;
        end
    else
        disp('ERROR ERROR ERROR')
    end
end
% flokka tegundir; 1=lettur, 2=midlungs, 3=erfidur





% Greina stadsetningu og skrifa upp
AA = []; aa = 0;
AAhlutL = []; aah = 0;
Bil = []; bil = 0;
Vegalengd = ones(1,length(GognMann));
Stada = []; stada = 0;


for i = 1:length(GognMann)
    len = length(GognMann{i});
    switch len
        case 1679
            flugax = GognFluga{1}.data(:,1);
            flugay = GognFluga{1}.data(:,2);
        case 1364
            flugax = GognFluga{3}.data(:,1);
            flugay = GognFluga{3}.data(:,2);
        case 1278
            flugax = GognFluga{2}.data(:,1);
            flugay = GognFluga{2}.data(:,2);
        otherwise
            disp('tetta a ekki ad gerast');
    end
    [bil, stada, aa, aah]=bilGreining(GognMann{i}(:,2),GognMann{i}(:,3),flugax,flugay);
    Vegalengd(i) = sum(bilGreining2(GognMann{i}(:,2),GognMann{i}(:,3)));
    Bil{i} = bil;
    Stada{i} = stada;
    AA{i} = aa;
    AAhlutL{i} = aah;
end
hreyfing = [];

%skref 6
framan = zeros(1,length(GognMann));
a = zeros(1,length(GognMann));
aftan = zeros(1,length(GognMann));

for i = 1:length(Stada)
    [framan(i),a(i),aftan(i)] = stadsetning(Stada{i});
end

% teikna lengd per timaskref
teikna1 = 0; teikna2 = 0; teikna3 = 0;
for i = 1:length(Vegalengd)
    switch Tegund(i)
        case 1
            % lettur
            teikna1(end+1) = Vegalengd(i);
        case 2
            % erfidur
            teikna3(end+1) = Vegalengd(i);
        case 3
            % midlungs
            teikna2(end+1) = Vegalengd(i);
        otherwise
            disp('ERROR ERROR ERROR');
    end
end
teikna1(1) = []; teikna2(1) = []; teikna3(1) = [];

figure('Name','Lengd per timaskref','NumberTitle','off')
subplot(3,1,1)
stem(teikna1)
title('Lett')
subplot(3,1,2)
stem(teikna3)
title('Erfidur')
subplot(3,1,3)
stem(teikna2)
title('Midlungs')

% Teikna upp AA



% Lidur 8
% tegundir geymir index ferla sem eru; 1 audveldir, 2 erfidir, 3 midlungs

    % lidur 8 x hnit
    figure('Name','X-hnit','NumberTitle','off')
    teikningLevel2(GognMann,2);

    % teikna fluguna
    subplot(3,1,1)
    plot(GognMann{tegundir{1}(1)}(:,1)/1000,GognFluga{1}.data(:,1),'k','Linewidth',2)
    subplot(3,1,3)
    plot(GognMann{tegundir{2}(1)}(:,1)/1000,GognFluga{2}.data(:,1),'k','Linewidth',2)
    subplot(3,1,2)
    plot(GognMann{tegundir{3}(1)}(:,1)/1000,GognFluga{3}.data(:,1),'k','Linewidth',2)

    % lidur 8 y hnit
    figure('Name','Y-hnit','NumberTitle','off')
    teikningLevel2(GognMann,3);

    % teikna fluguna
    subplot(3,1,1)
    plot(GognMann{tegundir{1}(1)}(:,1)/1000,GognFluga{1}.data(:,2),'k','Linewidth',2)
    subplot(3,1,3)
    plot(GognMann{tegundir{2}(1)}(:,1)/1000,GognFluga{2}.data(:,2),'k','Linewidth',2)
    subplot(3,1,2)
    plot(GognMann{tegundir{3}(1)}(:,1)/1000,GognFluga{3}.data(:,2),'k','Linewidth',2)