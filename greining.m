function gildi = greining(gogn,lengd, nafn)
% Tetta fall er notad til tess ad grein ferlana
    gildi = []; % by til tomt fylki
    figure('Name',nafn,'NumberTitle','off') 
    % Gildid a nefni sett sem gefna breita og numers titillint( Figure 1 )
    % tekid af
    hold on
    for i = 1:length(gogn)
        if length(gogn{i}) == lengd
            plot(gogn{i}(:,2),gogn{i}(:,3),'r')
            gildi(end+1)=i;
        end
    end
end