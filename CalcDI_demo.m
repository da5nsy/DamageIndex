clear, clc, close all

load spd_houser.mat

DI = CalcDI(spd_houser,S_houser);

hist(log(DI),50)
xlabel('log(DI)')



