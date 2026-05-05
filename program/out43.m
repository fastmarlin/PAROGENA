fprintf('Гидравлические потери\n')
for i = 1:length(w1)
    fprintf('   w1 = %.1f м/с:\n', w1(i))
    fprintf('Δp_гк = %.2f кПа, Δp_хк = %.2f кПа, Δp_кол = %.2f кПа, Δpm_вх = %.2f кПа, Δpm_вых = %.2f кПа, Δpтр_L = %.2f кПа, Δpm_φ = %.2f кПа, Δp_ПГ = %.2f кПа\n', deltap_gk, deltap_hk, deltap_kol, deltapm_in(i), deltapm_out(i), deltaptr_L(i), deltapm_phi(i), deltap1_pg(i));
end
