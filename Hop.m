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

pause

%skref 5
teljari = 1;

for i = 1:length(type)
    teikna = zeros(length(Bil)-1,1);
    for a = 1:length(Bil)
        if stadur(a,i) == 'O'
            teikna(a) = 0;
        elseif stadur(a,i) == 'F'
            teikna(a) = Bil(a,i);
        else
            teikna(a) = -Bil(a,i);
        end
    end
    
    subplot(6,1,teljari)
    title('AA')
    plot(teikna,'g')
    if teljari == 6
        teljari = 1;
        figure
    else
        teljari = teljari + 1;
    end
end
close

% Skref 6. Prenta allt ut
for c = 1:(length(type)/6)
    nafn = strsplit(char(nofn(c+2)),'_');
    figure('Name',char(nafn(1)), 'NumberTitle','off')
    hold on
    for i = 1:length(GognFluga)
        subplot(3,1,i)
        plot(GognFluga{i}.data(:,1),GognFluga{i}.data(:,2), 'k', 'Linewidth',1)
        hold on
    end
    for i = (c-1)*6+1:c*6
        if type(i) == 'Erfidur'
            subplot(3,1,2)
            plot(GognMann{i}(:,2), GognMann{i}(:,3),'r','Linewidth',0.5)
            title('Erfidur')

        elseif type(i)== 'Midlungs'
            subplot(3,1,3)
            plot(GognMann{i}(:,2), GognMann{i}(:,3),'b','Linewidth',0.5)
            title('Midlungs')

        elseif type(i) == 'Lett'
            subplot(3,1,1)
            plot(GognMann{i}(:,2), GognMann{i}(:,3),'g','Linewidth',0.5)
            title('Lett')
        end
    end
end

%herna kemur oll utskrift. Seinna skal gera fall inni for loopu sem gerir
%ser vesen fyrir hverja manneskju
% tarf ad skrifa ut badi AA
% prosentur tar sem madurinn er fyrir aftan fluguna, a flugunni eda fyrir
% framan