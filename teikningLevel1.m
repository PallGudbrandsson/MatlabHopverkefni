function teikningLevel1(x_as,y_as,tegund,xText,yText)
    switch tegund
        case 1
            subplot(3,1,1)
            title('Lett')
            xlabel(xText)
            ylabel(yText)
            hold on
        case 2
            subplot(3,1,3)
            title('Erfitt')
            xlabel(xText)
            ylabel(yText)
            hold on
        case 3
            subplot(3,1,2)
            title('Midlungs')
            xlabel(xText)
            ylabel(yText)
            hold on
        otherwise
            disp('ERROR ERROR ERROR')
    end
    plot(x_as,y_as)
end