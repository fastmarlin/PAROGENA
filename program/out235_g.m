figure(Name='Re = f(w1)')
plot(w1, Re1, 'LineWidth', 1.5)
grid
title('Re = f(w_{1})')
xlabel('w_{1}, м/с')
ylabel('Re_{1}')

figure(Name='α1, α2 = f(w1)')
plot(w1, alpha1, w1, alpha2, 'LineWidth', 1.5)
grid
title('α1, α2 = f(w_{1})')
xlabel('w_{1}, м/с')
ylabel('α, Вт/(м^{2}*град)')
legend('α1', 'α2')

figure(Name='k = f(w1)')
plot(w1, k_, 'LineWidth', 1.5)
grid
title('k = f(w_{1})')
xlabel('w_{1}, м/с')
ylabel('k, Вт/(м^{2}*град)')

figure(Name='q = f(w1)')
plot(w1, q_/1e3, 'LineWidth', 1.5)
grid
title('q = f(w_{1})')
xlabel('w_{1}, м/с')
ylabel('q, кВт/м^{2}')

figure(Name='Fф = f(w1)')
plot(w1, FF, 'LineWidth', 1.5)
grid
title('F_{Ф} = f(w_{1})')
xlabel('w_{1}, м/с')
ylabel('F_{Ф}, м_{2}')