% Definujeme souřadnice bodů
Td = 1;   % Čas zpoždění
T1 = 2;   % Časový parametr
y_inf = 1; % Konečná hodnota odezvy
y1 = 0.63 * y_inf; % Odpovídá hodnotě v inflexním bodě

% Souřadnice bodů 1 a 3
t1 = Td;
t3 = Td + T1;
y3 = y_inf;

% Směrnice přímky (sklon)
slope = (y3 - y1) / (t3 - t1);

% Najdeme průsečík s osou X (y = 0)
t0 = t1 - (y1 / slope);
y0 = 0; % Y souřadnice je 0

% Vytvoření vektoru pro prodlouženou přímku
t_line = [t0, t3];
y_line = [y0, y3];

% Vykreslení přímky mezi body 1 a 3 a až k ose X
plot(t_line, y_line, 'r-', 'LineWidth', 1.5);
hold on;

% Vykreslení bodů 1 a 3
plot(t1, y1, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k'); % Bod 1
plot(t3, y3, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k'); % Bod 3
plot(t0, y0, 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b'); % Průsečík s X

% Popis os
xlabel('Čas t');
ylabel('h(t)');
title('Prodloužená tečna až k ose X');

grid on;
hold off;
