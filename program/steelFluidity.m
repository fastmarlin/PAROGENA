function a=steelFluidity(t)

eps0=0.1; %точность

dd0=[20 100 150 200 250 300 350 400 450 500];


 % 08Х18Н10Т
aa0=[220 210 200 190 190 180 170 170 160 150];

%интерполяция
dd1=linspace(20,500, 10001);
aa1=interp1(dd0, aa0, dd1, 'makima');
%поиск нужного значения
id = min(find(abs(dd1 - t) <= eps0));
a=aa1(id);
end

