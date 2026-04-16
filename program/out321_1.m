fprintf('Внутренний диаметр трубки (dвн), мм: %.1f\n', d_vn)
fprintf('Площадь сечения 1 трубки (F1тр), м^2: %.5f\n', F1_tr)
fprintf('Внутренний диаметр коллекторов теплоносителя (dк вн), мм: %.1f \n', dk_vn)
fprintf('Площадь проходного сечения всех трубок:\n')
for i = 1:length(w1)
    fprintf('   w = %.1f м/с: Fn = %.1f м^2\n', w1(i), F_n(i))
end
fprintf('Число трубок пов-ти теплообмена:\n')
for i = 1:length(w1)
    fprintf('   w = %.1f м/с: n = %d\n', w1(i), n_raw(i))
end