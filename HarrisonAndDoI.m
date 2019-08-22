% Harrison's Damage Function
% Harrison, L.S., 1953. Report on the deteriorating effects of modern light sources. [online] New York: Metropolitan Museum of Art. Available at: <http://www.bcin.ca/Interface/openbcin.cgi?submit=submit&Chinkey=67513> [Accessed 2 May 2016].

wavelength  = 300:20:780;
yBarLambda  = [0, 0, 0, 0, 0, 0.0004, 0.004, 0.023, 0.06, 0.139, 0.323, 0.71, 0.954, 0.995, 0.87, 0.631, 0.381, 0.175, 0.061, 0.017, 0.0041, 0.001, 0.0003, 0.0001, 0];
DLambda     = [7.75, 4.5, 2.63, 1.45, 1.07, 0.66, 0.37, 0.2, 0.12, 0.065, 0.037, 0.021, 0.012, 0.007, 0.004, 0.002, 0.001, 0.0005, 0, 0, 0, 0, 0, 0, 0];

%%

figure, hold on
xlabel('Wavelength (nm)')

plot(wavelength,yBarLambda,'-o','DisplayName','Harrison''s $\overline{\mathrm{y}}_{\lambda}$')
plot(wavelength,DLambda,'-o','DisplayName','Harrison''s $\mathrm{D}_{\lambda}$')

%% 
% % Verify that yBarLambda == CIE 1931 yBar
%load T_xyz1931.mat %Requires PTB http://psychtoolbox.org/, or available via CIE or CVRL
%plot(SToWls(S_xyz1931),T_xyz1931(2,:))

%% Declaration of Independence Data
% Anon 1951. Preservation of the Declaration of Independence and the Constitution of the United States. [online] National Bureau of Standards. Available at: <https://cdm16009.contentdm.oclc.org/digital/collection/p16009coll4/id/10048>.

DoI_wavelength  = [546, 436, 405, 389, 365];
DoI_data        = [1, 22, 60, 90, 135];

plot(DoI_wavelength,DoI_data/100,'-o','DisplayName','Declaration of Indepedence data')

%%
legend('Interpreter','latex')
