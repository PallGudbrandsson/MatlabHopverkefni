function Gogn = innlestur(mappa, typa)
% Tetta function les inn oll gogn i moppuni sem er sett inn af gagnatypunni
% sem er sett inn
    Gogn = [];
    Mappa = dir(strcat(mappa,'\*',typa));
    for i = 1:length(Mappa)
        try
            gogn = load(strcat(mappa,'/',Mappa(i).name));
        catch me
            gogn = importdata(strcat(mappa,'\',Mappa(i).name));
        end
        Gogn{i} = gogn;
    end
end