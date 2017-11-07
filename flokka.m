function [teikna1,teikna2,teikna3] = flokka(gogn,tegund)
% flokka gogn sem eru gefin i 3 flokka eftir gerd
teikna1 = 0; teikna2 = 0; teikna3 = 0;
for i = 1:length(tegund)
    switch tegund(i)
        case 1
            % lettur
            teikna1(end+1) = gogn(i);
        case 2
            % erfidur
            teikna3(end+1) = gogn(i);
        case 3
            % midlungs
            teikna2(end+1) = gogn(i);
        otherwise
            disp('ERROR ERROR ERROR');
    end
end
teikna1(1) = []; teikna2(1) = []; teikna3(1) = [];