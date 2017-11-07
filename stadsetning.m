function [framan,a,aftan] = stadsetning(stadsetning)
% tekur inn stadsetninguna a formatinu sem vid erum ad nota. 
% 0= oskilgreint, 1= fyrir aftan flugu, 2= a flugu, 3= fyrir framan flugu
% Notum tolur tar sem tar taka minna vinnsluminni heldur en strengir og 
% ta verdur forritid okkar fljotara ad keyra
    framan = 0; a = 0; aftan = 0; summa = 0;
    for i = 1:length(stadsetning)
        if stadsetning(i) == 1
            aftan = aftan + 1;
        elseif stadsetning(i) == 2
            a = a + 1;
        elseif stadsetning(i) == 3
            framan = framan + 1;
        else
            %oskilgreint
        end
    end
    summa = framan + aftan + a;
    framan = (framan/summa)*100;
    aftan = (aftan/summa)*100;
    a = (a/summa)*100;
end     