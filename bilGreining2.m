function [Bil] = bilGreining2(madurx,madury)
% Reikna vegalengdina sem bendill mannsins ferdast
    Bil = zeros(1,1679);
    bil = 0;
    for i = 2:length(madurx)
        bil = sqrt((madurx(i) - madurx(i-1))^2 + (madury(i) - madury(i-1))^2);
        Bil(i) = bil;
    end
end