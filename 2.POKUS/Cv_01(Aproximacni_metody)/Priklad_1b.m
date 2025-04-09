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


Td1 = t_min1;
T11 = t_max1 - t_min1;

fprintf('Dopravní zpoždění je Td = %.2f a časov konstanta je rovna T1 = %.2f.\n', Td1, T11);

K1 = max(abs(y1));

fprintf('G(s) = (%.2f/%.2fs+1)*e^-%.2fs .\n',K1 , T11, Td1);


figure;
plot(t, y1, 'b', 'LineWidth', 1.5); hold on;
plot(inflex_t1, inflex_y1, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Inflexní bod
plot(t_tangent1, y_tangent1, 'g--', 'LineWidth', 1.5); % Tečna
xlabel('Čas [s]');
ylabel('Odezva');
title('Přechodová charakteristika Y1');
grid on;

% --------------------------------- Y2 ------------------------------------
fprintf('\nPřechodová charakteristika Y2\n');

dy2 = diff(y2) ./ diff(t);     % První derivace
d2y2 = diff(dy2) ./ diff(t(1:end-1)); % Druhá derivace

inflex_idx = find(d2y2(1:end-1) .* d2y2(2:end) < 0, 1); % První změna znaménka
inflex_t2 = t(inflex_idx+1); % Odpovídající čas
inflex_y2 = y2(inflex_idx+1); % Odpovídající hodnota výstupu

slope2 = dy2(inflex_idx); % Směrnice tečny v inflexním bodě

if slope2 ~= 0 % Zabránění dělení nulou
    t_min2 = inflex_t2 - inflex_y2 / slope2; % Kde tečna protne y = 0    
    t_max2 = (0.63 - inflex_y2) / slope2 + inflex_t2; % Čas odpovídající y = 1
else
    t_min2 = inflex_t2;
    t_max2 = inflex_t2; % Pokud je směrnice 0, tečna je konstantní
end

t_tangent2 = linspace(t_min2, t_max2, 100); % Hodnoty času pro vykreslení tečny
y_tangent2 = slope2 * (t_tangent2 - inflex_t2) + inflex_y2; % Rovnice přímky

Td2 = t_min2;
T12 = t_max2 - t_min2;

fprintf('Dopravní zpoždění je Td = %.2f a časov konstanta je rovna T1 = %.2f.\n', Td2, T12);

K2 = max(abs(y2));

fprintf('G(s) = (%.2f/%.2fs+1)*e^-%.2fs .\n',K2 , T12, Td2);


figure;
plot(t, y2, 'b', 'LineWidth', 1.5); hold on;
plot(inflex_t2, inflex_y2, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Inflexní bod
plot(t_tangent2, y_tangent2, 'g--', 'LineWidth', 1.5); % Tečna
xlabel('Čas [s]');
ylabel('Odezva');
title('Přechodová charakteristika Y2');
grid on;

% --------------------------------- Y3 ------------------------------------
fprintf('\nPřechodová charakteristika Y3\n');

dy3 = diff(y3) ./ diff(t);     % První derivace
d2y3 = diff(dy3) ./ diff(t(1:end-1)); % Druhá derivace

inflex_idx = find(d2y3(1:end-1) .* d2y3(2:end) < 0, 1); % První změna znaménka
inflex_t3 = t(inflex_idx+1); % Odpovídající čas
inflex_y3 = y3(inflex_idx+1); % Odpovídající hodnota výstupu

slope3 = dy3(inflex_idx); % Směrnice tečny v inflexním bodě

if slope3 ~= 0 % Zabránění dělení nulou
    t_min3 = inflex_t3 - inflex_y3 / slope3; % Kde tečna protne y = 0
    t_max3 = (0.63 - inflex_y3) / slope3 + inflex_t3; % Čas odpovídající y = 1
else
    t_min3 = inflex_t3;
    t_max3 = inflex_t3; % Pokud je směrnice 0, tečna je konstantní
end

t_tangent3 = linspace(t_min3, t_max3, 100); % Hodnoty času pro vykreslení tečny
y_tangent3 = slope3 * (t_tangent3 - inflex_t3) + inflex_y3; % Rovnice přímky

Td3 = t_min3;
T13 = t_max3 - t_min3;

fprintf('Dopravní zpoždění je Td = %.2f a časov konstanta je rovna T1 = %.2f.\n', Td3, T13);

K3 = max(abs(y3));

fprintf('G(s) = (%.2f/%.2fs+1)*e^-%.2fs .\n',K3 , T13, Td3);


figure;
plot(t, y3, 'b', 'LineWidth', 1.5); hold on;
plot(inflex_t3, inflex_y3, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Inflexní bod
plot(t_tangent3, y_tangent3, 'g--', 'LineWidth', 1.5); % Tečna
xlabel('Čas [s]');
ylabel('Odezva');
title('Přechodová charakteristika Y3');
grid on;

% --------------------------------- Y4 ------------------------------------
fprintf('\nPřechodová charakteristika Y4\n');

dy4 = diff(y4) ./ diff(t);     % První derivace
d2y4 = diff(dy4) ./ diff(t(1:end-1)); % Druhá derivace

inflex_idx = find(d2y4(1:end-1) .* d2y4(2:end) < 0, 1); % První změna znaménka
inflex_t4 = t(inflex_idx+1); % Odpovídající čas
inflex_y4 = y4(inflex_idx+1); % Odpovídající hodnota výstupu

slope4 = dy4(inflex_idx); % Směrnice tečny v inflexním bodě

if slope4 ~= 0 % Zabránění dělení nulou
    t_min4 = inflex_t4 - inflex_y4 / slope4; % Kde tečna protne y = 0
    t_max4 = (0.63 - inflex_y4) / slope4 + inflex_t4; % Čas odpovídající y = 1
else
    t_min4 = inflex_t4;
    t_max4 = inflex_t4; % Pokud je směrnice 0, tečna je konstantní
end

t_tangent4 = linspace(t_min4, t_max4, 100); % Hodnoty času pro vykreslení tečny
y_tangent4 = slope4 * (t_tangent4 - inflex_t4) + inflex_y4; % Rovnice přímky


Td4 = t_min4;
T14 = t_max4 - t_min4;

fprintf('Dopravní zpoždění je Td = %.2f a časov konstanta je rovna T1 = %.2f.\n', Td4, T14);

K4 = max(abs(y4));

fprintf('G(s) = (%.2f/%.2fs+1)*e^-%.2fs .\n',K4 , T14, Td4);


figure;
plot(t, y4, 'b', 'LineWidth', 1.5); hold on;
plot(inflex_t4, inflex_y4, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Inflexní bod
plot(t_tangent4, y_tangent4, 'g--', 'LineWidth', 1.5); % Tečna
xlabel('Čas [s]');
ylabel('Odezva');
title('Přechodová charakteristika Y4');
grid on;

