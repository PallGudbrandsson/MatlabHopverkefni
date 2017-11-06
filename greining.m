function gildi = greining(gogn,lengd, nafn)
    gildi = [];
    figure('Name',nafn,'NumberTitle','off')
    hold on
    for i = 1:length(gogn)
        if length(gogn{i}) == lengd
            plot(gogn{i}(:,2),gogn{i}(:,3),'r')
            gildi(end+1)=i;
        end
    end
end