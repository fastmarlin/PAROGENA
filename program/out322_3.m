fprintf('\n Невязка по D:\n')
for i = 1:length(w1)
    if deltaD(i) > 12
        fprintf(' * ')
    else
        fprintf('   ')
    end
    fprintf('w1 = %.1f м/с: ΔD = %.1f%% \n', w1(i), deltaD(i))
end
if max(deltaD) > 12
    fprintf('\n     ВНИМАНИЕ!\n')
    fprintf('Невязка по D превышает допустимое значение!\n')
end