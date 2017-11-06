function Gogn = innlestur(mappa, typa)
% les inn oll gogn i moppuni sem er gefin af typunni sem er gefd
    Gogn = [];
    Mappa = dir(strcat(mappa,'\*',typa));
    for i = 1:length(Mappa)
        %fle = strsplit(mappa,'_'); % fle er placeholder nafn til ad taka vid array
        %nafn = fle(end);
        try
            gogn = load(strcat(mappa,'/',Mappa(i).name));
        catch me
            gogn = importdata(strcat(mappa,'\',Mappa(i).name));
        end
        Gogn{i} = gogn;
    end
end