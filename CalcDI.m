function DI = CalcDI(SPD,S_SPD,b)

% Function to calculate damage index, as defined by "CIE 157:2004 Control of damage to museum objects by optical radiation"
% Currently required PsychToolbox for SToWls, T_CIE_Y2.mat, SplineCmf

%%

% Set damage function
if ~exist('b','var') % if b is not provided...
    b = 0.0115; %default: `oil paints on canvas' and `Water colours on rag paper'
end
S_dm_rel = exp(-b*(SToWls(S_SPD)-300)); % eq 2.5 from CIE 157:2004
%S_dm_rel = (1./SToWls(S_SPD)); %LM alternative version

% Set photopic luminance function
load T_CIE_Y2.mat T_CIE_Y2 S_CIE_Y2 %2 degree observer
if S_CIE_Y2 ~= S_SPD
    T_CIE_Y2 = SplineCmf(S_CIE_Y2,T_CIE_Y2,S_SPD); %set to same wavelength range and sampling interval
    S_CIE_Y2 = S_SPD;
end

%% Compute DI

F_dm_rel = SPD' * S_dm_rel;  %Eq. 1.3 from CIE 157:2004
F_v_rel  = SPD' * T_CIE_Y2'; %Eq. 1.4 from CIE 157:2004
DI = F_dm_rel./F_v_rel;      %Eq. 1.5 from CIE 157:2004

%% Normalise

% Load reference illuminant (CIE Illuminant A)
load spd_CIEA.mat spd_CIEA S_CIEA
if S_CIEA ~= S_CIE_Y2
    spd_CIEA = SplineCmf(S_CIEA,spd_CIEA,S_CIE_Y2); %set to same wavelength range and sampling interval
    S_CIEA = S_CIE_Y2;
end

% Calc DI for reference illuminant
F_dm_rel_ref = spd_CIEA' * S_dm_rel;  %Eq. 1.3 from CIE 157:2004
F_v_rel_ref  = spd_CIEA' * T_CIE_Y2'; %Eq. 1.4 from CIE 157:2004
DI_ref = F_dm_rel_ref./F_v_rel_ref;   %Eq. 1.5 from CIE 157:2004

% Normalise by DI_ref
DI = DI/DI_ref;


%%

% % alternative:
% % %-% Padfield terminology:
% %
% % http://research.ng-london.org.uk/scientific/spd/?page=info#Relative_Spectral_Sensitivity
% % Following:
% % 2: S. Aydinli, E. Krochmann, G.S. Hilbert, J. Krochmann: On the deterioration of exhibited museum objects by optical radiation, CIE Technical Collection 1990, CIE 089-1991, ISBN 978 3 900734 26 8
% %
% % b = 0.0115;
% % a = 1/exp(-b*300);
% % S_dm_rel = a*exp(-b*spd_lambda);
% %
% % %-%

end

