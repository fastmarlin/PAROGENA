fprintf('w1, м/с |   Nu1   |     Re1    |    k_   |    q_   |    α1   |    α2   |  Fф \n')
for i = 1:length(w1)
    fprintf('  %.1f   |  %.1f  |  %.1f  |  %.1f | %.1f | %.1f | %.1f | %.1f  \n', w1(i), Nu1(i), Re1(i), k_(i), alpha1(i), alpha1(i), alpha2(i), FF(i));
end