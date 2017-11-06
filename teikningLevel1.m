function teikningLevel1(x_as,y_as,tegund)
    switch tegund
        case 1
            subplot(3,1,1)
        case 2
            subplot(3,1,3)
        case 3
            subplot(3,1,2)
        otherwise
            disp('ERROR ERROR ERROR')
    end
    plot(x_as,y_as)
end