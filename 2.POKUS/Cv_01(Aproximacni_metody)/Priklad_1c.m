clear
close all;
clc;

load("data_TPR_01.mat");

%% --------------------- Nalezení inflexního bodu -------------------------
% --------------------------------- Y1 ------------------------------------
fprintf('Přechodová charakteristika Y1\n');

dy1 = diff(y1) ./ diff(t);     % První derivace
d2y1 = diff(dy1) ./ diff(t(1:end-1)); % Druhá derivace

inflex_idx = find(d2y1(1:end-1) .* d2y1(2:end) < 0, 1); % První změna znaménka
inflex_t1 = t(inflex_idx+1); % Odpovídající čas
inflex_y1 = y1(inflex_idx+1); % Odpovídající hodnota výstupu

%tečna
slope1 = dy1(inflex_idx); % Směrnice tečny v inflexním bodě

if slope1 ~= 0 % Zabránění dělení nulou
    t_min1 = inflex_t1 - inflex_y1 / slope1; % Kde tečna protne y = 0
    t_max1 = (0.63 - inflex_y1) / slope1 + inflex_t1; % Čas odpovídající y = 1
else
    t_min1 = inflex_t1;
    t_max1 = inflex_t1; % Pokud je směrnice 0, tečna je konstantní
end

t_tangent1 = linspace(t_min1, t_max1, 100); % Hodnoty času pro vykreslení tečny
y_tangent1 = slope1 * (t_tangent1 - inflex_t1) + inflex_y1; % Rovnice přímky

K1 = max(abs(y1));

Td1 = t_min1;

primka_t = [inflex_t1, t_max1];
primka_y = [inflex_y1, K1];


slope = (K1 - inflex_y1) / (t_max1 - inflex_t1);
% Najdeme průsečík s osou X (y = 0)
t0 = Td1 - (inflex_y1 / slope);
y0 = 0; % Y souřadnice je 0

figure;
plot(t, y1, 'b', 'LineWidth', 1.5); hold on;
plot(inflex_t1, inflex_y1, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Inflexní bod
plot(t_tangent1, y_tangent1, 'g--', 'LineWidth', 1.5); % Tečna
plot(t_max1, K1, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r')
plot(primka_t, primka_y, 'r-', 'LineWidth', 1.5);
xlabel('Čas [s]');
ylabel('Odezva');
title('Přechodová charakteristika Y1');
grid on;
