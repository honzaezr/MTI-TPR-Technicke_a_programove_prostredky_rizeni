close all;
clear;
clc;

Tsim = 5;

%% Definice systému
s = tf('s');
G = 1 / (0.5*s + 1);
G1 = exp(-s); % Měřící senzor
Gd = 1 / (0.2*s + 1); % Přenos poruchy

%% Návrh PI regulátoru (Chien-Hrones-Reswick)
% hodnoty z tabule
Kp = 0.2;
Ti = 0.47;
R = Kp * (1 + Ti/s);

% Otevřená smyčka bez regulátoru
L1 = G * G1;
% Otevřená smyčka
L = R * G * G1;

% Uzavřená smyčka
T = L / (1 + L);


% Simulace otevřené smyčky
figure('Name', 'Simulace otevřené smyčky', 'NumberTitle','off');
step(L1);
title('Otevřená smyčka');
grid on;

% Simulace odezvy na jednotkový skok
figure;
step(T);
title('Odezva PI regulátoru');
grid on;

% Fázová bezpečnost
figure;
margin(L);
title('Bodeho diagram - Fázová bezpečnost');

% Implementace Smithova prediktoru
G_smith = G * exp(-s); % Model s dopravním zpožděním
L_smith = R * G_smith * G1;
T_smith = L_smith / (1 + L_smith);

figure;
step(T_smith);
title('Odezva se Smithovým prediktorem');
grid on;

% Testování poruchy (skok na vstupu vzduchu o 0.2)
figure;
t = 0:0.01:Tsim;
[y, t] = step(T, t);
[y_d, t] = step(Gd, t);
plot(t, y, 'b', t, y_d, 'r');
legend('Odezva na jednotkový skok', 'Odezva na poruchu');
title('Testování poruchy');
grid on;
