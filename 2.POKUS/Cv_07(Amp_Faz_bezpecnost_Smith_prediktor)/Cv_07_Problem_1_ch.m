close all;
clear;
clc;

%% Definice systému
s = tf('s');
Gs = 0.75 / ((0.5*s + 1) * (3*s + 1)^3 * (10*s + 1));

% Regulátor pro r0 = 0.2
r0 = 0.2;
Rs = r0 * (1 + 1/(3.3*s));
L = Rs * Gs;
T = L / (1 + L);

%% Bodeho diagram a stabilitní analýza
figure('Name','Bodeho diagram','NumberTitle','off');
margin(L);
title('Bodeho diagram pro r_0 = 0.2');

%% Odezeva na jednotkový skok
figure('Name','Odezva na jednotkový skok','NumberTitle','off');
step(T);
title('Odezva na jednotkový skok pro r_0 = 0.2');
grid on;

%% Nyquistův graf
figure('Name','Nyquistův graf','NumberTitle','off');
nyquist(L);
title('Nyquistův graf');
grid on;
axis equal;

%% Dopravní zpoždění
Tds = [5, 10];
figure('Name','Odezvy se zpožděním','NumberTitle','off');
hold on;
step(T);
for Td = Tds
    G_delay = Gs * exp(-Td * s);
    L_delay = Rs * G_delay;
    T_delay = L_delay / (1 + L_delay);
    step(T_delay);
end
legend('Td = 0', 'Td = 5', 'Td = 10');
title('Odezvy se zpožděním pro r_0 = 0.2');
grid on;
hold off;


% %% Různé hodnoty r_0 bez zpoždění
% r_values = [0.5, 1, 2];
% figure;
% hold on;
% for r0 = r_values
%     R = r0 * (1 + 1/(3.3*s));
%     L = R * G;
%     T = L / (1 + L);
%     step(T);
% end
% legend('r0 = 0.5', 'r0 = 1', 'r0 = 2');
% title('Odezvy pro různé hodnoty r_0 bez zpoždění');
% grid on;
% hold off;
