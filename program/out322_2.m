fprintf('Диаметр корпуса:\n')
fprintf('   По ширине:\n')
fprintf('       D1 = %d мм\n', D1)
fprintf('   По высоте:\n')
for i = 1:length(w1)
    fprintf('       w1 = %.1f м/с: D2 = %d мм\n', w1(i), D2(i))
end
fprintf('   В качестве внутреннего диаметра корпуса принимается наибольшее из полученных значений D1 и D2:\n')
for i = 1:length(w1)
    if D(i) > 4200
        fprintf('     * ')
    else
        fprintf('       ')
    end
    fprintf('w1 = %.1f м/с: D = %d мм\n', w1(i), D(i))
end
if max(D) > 4200
    fprintf('\n     ВНИМАНИЕ!\n')
    fprintf('Диаметр корпуса превышает допустимое значение!\n')
end