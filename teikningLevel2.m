function teikningLevel2(mann, hnit)
    for i = 1:length(mann)
        len = length(mann{i});
        switch len
            case 1679
                % lett
                subplot(3,1,1)
                title('Lett')
                hold on
                plot(mann{i}(:,1)/1000,mann{i}(:,hnit),'r');
            case 1364
                % erfidur
                subplot(3,1,2)
                title('Erfitt')
                hold on
                plot(mann{i}(:,1)/1000,mann{i}(:,hnit),'r');
            case 1278
                % mid
                title('Midlungs')
                subplot(3,1,3)
                hold on
                plot(mann{i}(:,1)/1000,mann{i}(:,hnit),'r');
            otherwise
                disp('ERROR ERROR ERROR')
        end
    end
end