fprintf('Размеры ПГ:\n')
for i = 1:length(w1)
    fprintf('   w1 = %.1f м/с: L = %g мм, Lоб = %g мм, Lц.об = %g мм, Lкр.об = %g мм, bдн = %g мм \n', w1(i), (L(i)), (L_ob(i)), (L_cob(i)), (L_krob(i)), (b_dn(i)))
end
fprintf('\nШаг коллекторов:\n')
fprintf('   Продольный шаг коллекторов:\n')
fprintf('   S1k = %d мм\n', S1_k)
fprintf('   Поперечный шаг коллекторов:\n')
for i = 1:length(w1)
    fprintf('   w1 = %.1f м/с: S2k = %d мм\n', w1(i), S2_k(i))
end