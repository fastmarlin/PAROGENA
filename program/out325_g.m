figure(Name='D = f(w1)')
plot(w1, D, 'LineWidth', 1.5)
grid
title('D = f(w_{1})')
xlabel('w_{1}, м/с')
ylabel('D, мм')

figure(Name='L = f(w1)')
plot(w1, L, 'LineWidth', 1.5)
grid
title('L = f(w_{1})')
xlabel('w_{1}, м/с')
ylabel('L, мм')

figure(Name='Lср = f(w1)')
plot(w1, L_sr, 'LineWidth', 1.5)
grid
title('L_{ср} = f(w_{1})')
xlabel('w_{1}, м/с')
ylabel('L_{ср}, м')

figure(Name='n = f(w1)')
plot(w1, n, 'LineWidth', 1.5)
grid
title('q = f(w_{1})')
xlabel('w_{1}, м/с')
ylabel('n, шт.')