clear, clc, close all

load spd_houser.mat
% - %
% Quoting from
% PTB/PsychColorimetricData/PsychColorimetricMatFiles/Contents.m :

% "401 normalised illuminant spectral power distributions from:
% Review of measures for light-source color rendition and considerations for a two-measure system for characterizing color rendition
% Kevin W. Houser, Minchen Wei, Aurélien David, Michael R. Krames, and Xiangyou Sharon Shen
% Optics Express, Vol. 21, Issue 8, pp. 10393-10411 (2013)
% http://dx.doi.org/10.1364/OE.21.010393"
% - %

% - % 
% Values of b for 5 categories of museum materials, from CIE 157 2004
% Low grade paper:              0.038
% Rag paper:                    0.0125
% Oil paints on canvas:         0.0115
% Textiles:                     0.01
% Water colours on rag paper:   0.0115
% - %

b = 0.0115;

DI = CalcDI(spd_houser,S_houser,b);
CCT = SPDToCCT(spd_houser,S_houser);

% Illuminant A reference
load spd_CIEA.mat spd_CIEA S_CIEA
DI2 = CalcDI(spd_CIEA,S_CIEA,b);
CCT2 = SPDToCCT(spd_CIEA,S_CIEA);

%%
% From personal communication with K Houser:
codes_from_excel_raw = ['H	H	G	C	C	D	E	E	E	E	F	F	H	H	H	H	H	H	H	H	H	A	A	G	G	G	G	L	L	L	L	C	C	C	C	C	C	C	C	C	D	D	D	E	E	D	D	D	D	D	C	C	C	C	C	C	C	C	C	C	C	E	E	E	E	E	H	H	H	H	H	H	I	I	I	I	H	H	H	H	B	B	B	B	B	H	H	H	H	G	H	H	H	H	H	H	H	H	H	G	G	G	G	G	G	G	G	G	G	G	G	G	G	G	G	G	A	A	A	A	A	A	A	J	J	J	J	J	J	J	J	K	K	K	K	K	K	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	E	H	H	H	H	H	H	G	G	G	G	G	H	H	H	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	I	E	E	E	E	F	H	B	A	A	B	E	E	E	F	D	B	B	B	B	B	B	B	I	H	H	H	H	H	H	H	F	F	F	D	D	B	B	B	D	D	F	D	D	D	D	D	D	D	D	D	D	D	D	C	C	F	F	F	F	E	E	E	E	L	L	D	D	D	D	D	C	C	C	C	C	C	F	E	E	E	F	E	E	E	E	A	A	A	A	A	A	A	A	A	A	A	A	A	A	A	E	F	F	F	A	A	A	A	G'];
codes_from_excel = regexprep(codes_from_excel_raw, '\t', '');
letter2number = @(c)1+lower(c)-'a';
codes_from_excel_num = letter2number(codes_from_excel);

key = {'LED Phosphor Real','LED Mixed Real','Fluorescent Broadband','Fluorescent Narrowband','HID','Tungesten Filament','LED Phosphor Models','LED Mixed Models','Fluorescent Models','Blackbody Radiation','D-Series Illuminant','Other'};
% Other: (e.g., Equal-Energy, Clipped Incan, Ideal Prime Color)


%% Plot all

figure, hold on
scatter(CCT,DI,'k','MarkerEdgeAlpha',0.2)
scatter(CCT2,DI2,'k*','DisplayName','Illuminant A reference') 
plot([min(xlim),max(xlim)],[1,1],'k--')
xlabel('CCT (K)')
ylabel('DI (normalised to Illuminant A)')

%%
colours = jet(max(codes_from_excel_num));

figure, hold on
for i = 1:max(codes_from_excel_num)
    scatter(CCT(codes_from_excel_num == i),DI(codes_from_excel_num == i),...
        [],colours(i,:),'filled',...
        'MarkerEdgeAlpha',0.5,...
        'MarkerFaceAlpha',0.5,...
        'DisplayName',key{i})
end
%scatter(CCT,DI,[],colours(codes_from_excel_num,:),'MarkerEdgeAlpha',0.5,'DisplayName',key{codes_from_excel_num})

scatter(CCT2,DI2,'k*','DisplayName','Illuminant A reference') 

legend('AutoUpdate','off','Location','best')
plot([min(xlim),max(xlim)],[1,1],'k--')
xlabel('CCT (K)')
ylabel('DI (normalised to Illuminant A)')

