clear, clc, close all

load spd_houser.mat

DI = CalcDI(spd_houser,S_houser);

%histogram(log(DI),50)
%xlabel('log(DI)')

histogram(DI,50)
xlabel('DI')

ylabel(['Count (n=',num2str(length(DI)),')'])



