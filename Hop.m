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
teljari = 1;

for i = 1:length(Mappa) % Herna eru oll gogn sem vid notum til ad lesa inn gogn em manneskjuna skref 1.1
    try
        y = dir(strcat(mappa,char(Mappa(i).name), '\*.dat'));
        nofn{i} = char(y(1).name);
        for a = 1:6
            gogn = load(strcat(mappa,Mappa(i).name,'\',char(y(a).name)));
            GognMann{end+1} = gogn;
        end
     catch me  
         disp('error');
         disp(Mappa(i).name);
        % ef hingad er komid er Mappa(i).name ekki gilt skraar nafn
    end
end




% geri fylki sem inniheldur nofn sjuklinga
% skref 1.2 unnid meira med nofn einstaklinga. Innlesturinn sem vid erum ad
% nota skilar 2 ogildum nofnum tannig vid verdum ad byrja a 3
for i = 3:length(nofn)
    try
        nafn = strsplit(char(nofn(i)),'_');
        Nofn(i-2) = char(nafn(1))
    catch me
        disp('error')
    end
end
        


% herna les eg inn gognin um fluguna skref 1.3
mappa = strcat(pwd,'\Fluga\');
a = dir(strcat(mappa, '*.dat'));

for i = 1:length(a)
    gogn = importdata(strcat(mappa,char(a(i).name)));
    GognFluga{i} = gogn;
end
%GognFluga{1}.data(:,1)

% Herna eru ferlarnir teiknadir upp fyrir fluguna
% byggt a gognum ur heimaverkefni 5
% 1 = lett 1679
% 2 = erfidur 1278
% 3 = mid 1364
% for i = 1:length(a)
%     figure
%     plot(GognFluga{i}.data(:,1),GognFluga{i}.data(:,2),'k','Linewidth',2);
% end
% 
% for i = 1:length(GognMann)
%     figure
%     plot(GognMann{i}(:,2),GognMann{i}(:,3))
% end




% Greina ferla skref 2

type = strings(1,length(GognMann)); %ones(1,length(GognMann));

for i = 1:length(GognMann)
    switch length(GognMann{i})
        case 1679
           type{i} = 'Lett';
        case 1278
            type(i) = 'Erfidur';
        case 1364
            type{i} = 'Midlungs';
        otherwise
            disp('Tetta a ekki ad gerast')
    end
end


% herna er eg ad finna hvor madurinn er a flugunni, fyrir aftan eda a henni
% og prosenturnar a tvi
% Skref 3

stadur = strings(1679-1, length(GognMann));
teljari = 1;
summaHlutL = 0;
summa = 0;

AAHlutL = ones(length(GognMann),1); % hlutlaus Amplitude accuracy. Hliutlaus, alltaf lagt vid
AA = ones(length(GognMann),1);
    
for i = 1:length(GognMann) % tarf ad endurbata tessa lykkju
    Bil = zeros(length(GognMann{1})-1); bil = 0;
    
    if type(i) == 'Lett' % nota flugu 1
        fluga = GognFluga{1}.data;
    elseif type(i) == 'Midlungs' % nota flugu 3
        fluga = GognFluga{3}.data;
    elseif type(i) == 'Erfidur' % nota flugu 2
        fluga = GognFluga{2}.data;% villa
    else
        disp('error')
        pause
    end
    for a = 2:(length(GognMann{i})-1)
        % byrja a ad athuga hvern einasta punkt. Matti athuga med ad breyta
        % tessu seinna.
        bil = sqrt((GognMann{i}(a,2)-fluga(a,1))^2 + (GognMann{i}(a,3)-fluga(a,2))^2);
        summaHlutL = summaHlutL + bil;
        if bil < 2
            % er a punktinum   
            % tar sem tetta fylki er F***ing Gigantiskt nota eg einfalda stafi til ad spara plass
            stadur(a,i) = 'O'; % On the point
%             summa = summa + bil;
        elseif sqrt((GognMann{i}((a-1),2)-fluga((a-1),1))^2 + (GognMann{i}((a-1),3)-fluga((a-1),2))^2)>sqrt((GognMann{i}((a+1),2)-fluga((a+1),1))^2 + (GognMann{i}((a+1),3)-fluga((a+1),2))^2)
            % fyrir framan
            stadur(a,i) = 'F'; % in Front of
            summa = summa + bil;
        else
            % fyrir aftan
            stadur(a,i) = 'B'; % Behind
            summa = summa - bil;
        end
        summaHlutL = summaHlutL + bil;
        
        try
            bil = sqrt((GognMann{i}(a,2)-GognMann{i}(a-1,2))^2 + (GognMann{i}(a,3)-GognMann{i}(a-1,3))^2);
        catch me
            bil = 0;
        end
        Bil(a-1) = bil;
    end
    
    
    %nafn = strsplit(char(nofn(i+2)),'_');
    subplot(6,1,teljari)%, 'Name',char(nafn(1)), 'NumberTitle','off')
    %figure
    plot(Bil,'r')
    if rem(i,6) == 0
        teljari = 1;
        figure
    else
        teljari = teljari + 1;
    end
    AAHlutL(i) = summaHlutL/length(GognMann);
    AA(i) = summa/length(GognMann);
    summaHlutL = 0;
    summa = 0;
end
close

%setja tetta upp i fprintf og skipta tannig ad tad eru 6 stok per manneskju

% Hlutfall Behind the point, On the point. in Front of the point 
% Skref 4
Behind = ones(1,length(type)); behind = 0;
On = ones(1,length(type)); on = 0;
Front = ones(1,length(type)); front = 0;

for i = 1:length(type)
    behind = 0; on = 0; front = 0;
    %breyta tessari romsu og nota find
    for a = 1:length(stadur)
        if stadur(a,i) == 'O'
            on = on + 1;
        elseif stadur(a,i) == 'F'
            front = front + 1;
        elseif stadur(a,i) == 'B'
            behind = behind + 1;
        else
            %ekkert gildi(ferill buinn)
        end
    end
    summa = on + front + behind;
    Behind(i) = (behind/summa)*100;
    On(i) = (on/summa)*100;
    Front(i) = (front/summa)*100;
end

clc
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
        i
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