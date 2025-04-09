clear;
close all;
clc;

loadedData = load("klima.mat"); % Načtení souboru
fieldNames = fieldnames(loadedData); % Získání názvu proměnné
data = loadedData.(fieldNames{1}); % Přístup k datům (matice 5x7309)
% 1. řádek => časový vektor t
% 3. řádek => vektor buzení u
% 4 .řádek => reakce sysstému y


data_t = data(1, 1602:7309); % Uložení prvního řádku do t
data_u = data(3, 1602:7309); % Uložení třetího řádku do u
data_y = data(4, 1602:7309); % Uložení čtvrtého řádku do y

% začíná to až po 400s, jelikož to bylo v ustáleném stavu

delka = 100;

y = movmean(data_y, delka);



figure;
plot(data_t, data_y);
hold on;
plot(data_t, y, 'b', 'LineWidth', 1.5);

figure;
plot(data_t, data_u);
hold on;
plot(data_t, data_y);

% Předpokládáme, že vektory t a u jsou již načtené
jumps = find(diff(data_u) ~= 0); % Najdi indexy, kde došlo ke skoku
segments = [1, jumps+1, length(data_u)]; % Přidej první a poslední index

% figure;
for i = 1:length(segments)-1
    % Vyber data pro aktuální segment
    idx_start = segments(i);
    idx_end = segments(i+1);
    t_seg = data_t(idx_start:idx_end);
    u_seg = data_u(idx_start:idx_end);
    
%     % Vykresli segment v novém subplotu
%     subplot(length(segments)-1, 1, i);
%     plot(t_seg, u_seg, '-o', 'MarkerSize', 4, 'LineWidth', 1.5);
%     xlabel('t'); ylabel('u');
%     title(['Segment ' num2str(i)]);
%     grid on;
end

for i = 1:length(segments)-1
    % Vyber odpovídající segmenty pro t a y
    idx_start = segments(i);
    idx_end = segments(i+1);
    t_seg = data_t(idx_start:idx_end);
    y_seg = y(idx_start:idx_end);

        % Posun X tak, aby začínalo od 0
    t_seg = t_seg - t_seg(1);
    
    % Posun Y tak, aby začínalo od 0
    y_seg = abs(y_seg - y_seg(1));

    Seg{i} = [t_seg; y_seg];
    
    % Otevři nové okno pro každý segment
    figure;
    plot(t_seg, y_seg, '-b', 'LineWidth', 1.5);
    xlabel('t'); ylabel('y');
    title(['Segment ' num2str(i)]);
    grid on;
end


% figure; hold on; % Vytvoření jednoho grafu
% colors = lines(length(segments)-1); % Barevná mapa pro různé segmenty
% 
% for i = 1:length(segments)-1
%     % Vyber odpovídající segmenty pro t a y
%     idx_start = segments(i);
%     idx_end = segments(i+1);
%     t_seg = data_t(idx_start:idx_end);
%     y_seg = y(idx_start:idx_end);
%     
%     % Posun X tak, aby začínalo od 0
%     t_seg = t_seg - t_seg(1);
%     
%     % Posun Y tak, aby začínalo od 0
%     y_seg = abs(y_seg - y_seg(1));      % ABS aby převracela funkce do 1. kvadrantu
% 
%     
%     % Vykreslení segmentu
%     plot(t_seg, y_seg, 'Color', colors(i, :), 'LineWidth', 1.5);
% end
% 
% xlabel('t (zarovnáno na 0)');
% ylabel('y (zarovnáno na 0)');
% title('Všechny segmenty zarovnané na [0,0]');
% grid on;
% legend(arrayfun(@(x) sprintf('Segment %d', x), 1:length(segments)-1, 'UniformOutput', false));
% hold off;



segment_2 = Seg{2}; 
% Extrakce časové a hodnotové osy
t_seg_2 = segment_2(1, :); % První řádek je čas
y_seg_2 = segment_2(2, :); % Druhý řádek je signál

% figure;
% plot(t_seg_2, y_seg_2);


segment_3 = Seg{3}; 
% Extrakce časové a hodnotové osy
t_seg_3 = segment_3(1, :); % První řádek je čas
y_seg_3 = segment_3(2, :); % Druhý řádek je signál

% figure;
% plot(t_seg_3, y_seg_3);


segment_4 = Seg{4}; 
% Extrakce časové a hodnotové osy
t_seg_4 = segment_4(1, 1:1601); % První řádek je čas
y_seg_4 = abs(segment_4(2, 1:1601)); % Druhý řádek je signál

% figure;
% plot(t_seg_4, y_seg_4);

figure;
plot(t_seg_2, y_seg_2,'LineWidth', 1.5);
hold on;
plot(t_seg_3, y_seg_3,'LineWidth', 1.5);
hold on;
plot(t_seg_4, y_seg_4,'LineWidth', 1.5);

xlabel('t (zarovnáno na 0)');
ylabel('y (zarovnáno na 0)');
title('Všechny segmenty zarovnané na [0,0]');
grid on;





% % --------------------------------- segment 2 ------------------------------------
% fprintf('\nPřechodová charakteristika Y2\n');
% 
% dy2 = diff(y_seg_2) ./ diff(t_seg_2);     % První derivace
% d2y2 = diff(dy2) ./ diff(t_seg_2(1:end-1)); % Druhá derivace
% 
% inflex_idx = find(d2y2(1:end-1) .* d2y2(2:end) < 0, 1); % První změna znaménka
% inflex_t2 = t_seg_2(inflex_idx+1); % Odpovídající čas
% inflex_y2 = y_seg_2(inflex_idx+1); % Odpovídající hodnota výstupu
% 
% slope2 = dy2(inflex_idx); % Směrnice tečny v inflexním bodě
% 
% if slope2 ~= 0 % Zabránění dělení nulou
%     t_min2 = inflex_t2 - inflex_y2 / slope2; % Kde tečna protne y = 0    
%     t_max2 = (0.63 - inflex_y2) / slope2 + inflex_t2; % Čas odpovídající y = 1
% else
%     t_min2 = inflex_t2;
%     t_max2 = inflex_t2; % Pokud je směrnice 0, tečna je konstantní
% end
% 
% t_tangent2 = linspace(t_min2, t_max2, 100); % Hodnoty času pro vykreslení tečny
% y_tangent2 = slope2 * (t_tangent2 - inflex_t2) + inflex_y2; % Rovnice přímky
% 
% Td2 = t_min2;
% T12 = t_max2 - t_min2;
% 
% fprintf('Dopravní zpoždění je Td = %.2f a časov konstanta je rovna T1 = %.2f.\n', Td2, T12);
% 
% K2 = max(abs(y_seg_2));
% 
% fprintf('G(s) = (%.2f/%.2fs+1)*e^-%.2fs .\n',K2 , T12, Td2);
% 
% 
% figure;
% plot(t_seg_2, y_seg_2, 'b', 'LineWidth', 1.5); hold on;
% plot(inflex_t2, inflex_y2, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Inflexní bod
% plot(t_tangent2, y_tangent2, 'g--', 'LineWidth', 1.5); % Tečna
% xlabel('Čas [s]');
% ylabel('Odezva');
% title('Přechodová charakteristika Y2');
% grid on;


% % --------------------------------- Y2 ------------------------------------
% dy2 = diff(y_seg_2) ./ diff(t_seg_2);     % První derivace
% d2y2 = diff(dy2) ./ diff(t_seg_2(1:end-1)); % Druhá derivace
% 
% inflex_idx = find(d2y2(1:end-1) .* d2y2(2:end) < 0, 1); % První změna znaménka
% inflex_t2 = t_seg_2(inflex_idx+1); % Odpovídající čas
% inflex_y2 = y_seg_2(inflex_idx+1); % Odpovídající hodnota výstupu
% 
% slope2 = dy2(inflex_idx); % Směrnice tečny v inflexním bodě
% 
% if slope2 ~= 0 % Zabránění dělení nulou
%     t_min2 = inflex_t2 - inflex_y2 / slope2; % Kde tečna protne y = 0    
%     t_max2 = (1 - inflex_y2) / slope2 + inflex_t2; % Čas odpovídající y = 1
% else
%     t_min2 = inflex_t2;
%     t_max2 = inflex_t2; % Pokud je směrnice 0, tečna je konstantní
% end
% 
% t_tangent2 = linspace(t_min2, t_max2, 100); % Hodnoty času pro vykreslení tečny
% y_tangent2 = slope2 * (t_tangent2 - inflex_t2) + inflex_y2; % Rovnice přímky
% 
% Tu2 = t_min2;
% Tn2 = t_max2 - t_min2;
% T2 = Tu2/Tn2;
% 
% figure;
% plot(t_seg_2, y_seg_2, 'b', 'LineWidth', 1.5); hold on;
% plot(inflex_t2, inflex_y2, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Inflexní bod
% plot(t_tangent2, y_tangent2, 'g--', 'LineWidth', 1.5); % Tečna
% xlabel('Čas [s]');
% ylabel('Odezva');
% title('Přechodová charakteristika Y2');
% grid on;


