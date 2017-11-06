function [Bil, stada, AA, AAhlutl] = bilGreining(madurx,madury,flugax,flugay)
    % skilgreind sem zeros til ad tau komi ut sem double array en ekki cell
    % array, ef tad kemur cell array tarf ad medhondla gognin enn frekar
    % tannig ad tad er hagstadara ad gera tetta svona
    % Astadan fyrir lengdinni er su ad 1679 er lengsti ferillinn tannig ad
    % vid skilgreinum tau svona til ad tad verdi ekki vesen tegar farid er
    % i ad teikna gognin
    Bil = zeros(1679,1);
    stada = zeros(1679,1);
    AA = zeros(1679,1);
    AAhlutl = zeros(1679,1);
    bil = 0;

    for i = 2:length(flugay)-1
        bil = sqrt((madurx(i)-flugax(i))^2 + (madury(i)-flugay(i))^2);
        if bil < 2
            stada(i) = 2;
            AA(i) = bil;
            if sqrt((madurx(i)-flugax(i-1))^2 + (madury(i)-flugay(i-1))^2) > sqrt((madurx(i)-flugax(i+1))^2 + (madury(i)-flugay(i+1))^2)
                AA(i) = - bil;
            else
                AA(i) = bil;
            end
        elseif sqrt((madurx(i)-flugax(i-1))^2 + (madury(i)-flugay(i-1))^2) > sqrt((madurx(i)-flugax(i+1))^2 + (madury(i)-flugay(i+1))^2)
            % madurinn er fyrir aftan
            stada(i) = 1;
            AA(i) =- bil;
        else
            % madurinn er fyrir framan
            stada(i) = 3;
            AA(i) =bil;
        end
        AAhlutl(i) = bil;
    end
end