close all;
clear;
clc;



% 1. ukol
% v = u^4 => k = 4u^3
% Derivuju
%
pocetvzorku = 100;
Tsim = 100;

s = tf("s");
G = 0.6/((2*s + 1) * (3*s + 1)^4);
% v = u^4;

[yx, tx] = step(G, Tsim);
% [yx1, tx1] = step(v, Tsim);



figure;
plot(tx, yx);

% figure
% plot(tx1, yx1);
