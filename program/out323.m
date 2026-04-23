fprintf('Длина трубок ПТО:\n')

for i = 1:length(w1)
    if L_sr(i) > 14 || L_max(i) > 16
        fprintf(' * ')
    else
        fprintf('   ')
    end
    fprintf('w1 = %.1f м/с: Lср = %.1f м, Lmax = %.1f м, Lmin = %.1f м, Lпр = %.1f м \n', w1(i), L_sr(i), L_max(i), L_min(i), L_pr(i))
end

if max(L_sr) > 14
    fprintf('\n     ВНИМАНИЕ!\n')
    fprintf('Средняя длина трубок ПТО превышает допустимое значение!\n')
end

if max(L_max(i)) > 17
    fprintf('\n     ВНИМАНИЕ!\n')
    fprintf('Максимальная длина трубок ПТО превышает допустимое значение!\n')
end

fprintf('\nРадиус гиба трубок ПТО:\n')
fprintf('   Минимальный радиус гиба трубок ПТО: Rmin = %d мм \n', R_min)

for i = 1:length(w1)
    if L_sr(i) > 14
        fprintf(' * ')
    else
        fprintf('   ')
    end
    fprintf('w1 = %.1f м/с: Rср = %g мм, Rmax = %g мм \n', w1(i), R_sr(i), R_max(i))
end