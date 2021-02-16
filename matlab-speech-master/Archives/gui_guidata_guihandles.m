
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEBUT DE LA FONCTION PRINCIPALE%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function gui_guidata_guihandles

% Cr�ation de l'objet Figure
figure('units','pixels',...
    'position',[250 250 500 500],...
    'color',[0.925 0.913 0.687],...
    'numbertitle','off',...
    'name','[GUI] Utilisation de GUIDATA',...
    'menubar','none',...
    'tag','interface');

% Cr�ation de l'objet Uicontrol Pushbutton -
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.1 0.1 0.1 0.05],...
    'string','-',...    
    'callback',@retrancher,...
    'tag','bouton_retrancher');

% Cr�ation de l'objet Uicontrol Pushbutton +
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.3 0.1 0.1 0.05],...
    'string','+',...    
    'callback',@ajouter,...
    'tag','bouton_ajouter');

% Cr�ation de l'objet Uicontrol Text r�sultat
uicontrol('style','text',...
    'units','normalized',...
    'position',[0.1 0.2 0.3 0.05],...
    'string','0',...
    'tag','resultat');

% G�n�ration de la structure contenant les identifiants des objects graphiques dont la 
% propri�t� Tag a �t� utilis�e.

data=guihandles(gcf);

% D'apr�s les Tag utilis�s pour les objets graphiques cr�es pr�c�demment, la structure data 
% contient les champs suivant :
%   data.interface
%   data.resultat
%   data.bouton_ajouter
%   data.bouton_retrancher
%

% Initialisation de la variable repr�sentant la valeur courante du compteur nCompteur � 0
% Note : nCompteur est ici un champ de la structure data
data.nCompteur=0;

% Enregistrement de data dans les donn�es d'application de l'objet Figure
guidata(gcf,data)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIN DE LA FONCTION PRINCIPALE%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEBUT DE LA SOUS-FONCTION RETRANCHER%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function retrancher(obj,event)

data=guidata(gcbf);
% R�cup�ration des donn�es stock�es dans les donn�es d'application de l'objet Figure
% contenant l'objet graphique dont l'action est ex�cut�e (gcbf)

% Diminution de la valeur de nCompteur
data.nCompteur=data.nCompteur-1;

% Modification de sa propri�t� String
set(data.resultat,'string',num2str(data.nCompteur));

% Enregistrement des donn�es modifi�es dans les donn�es d'application de l'objet Figure
% contenant l'objet graphique dont l'action est ex�cut�e (gcbf)
guidata(gcbf,data)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIN DE LA SOUS-FONCTION RETRANCHER%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEBUT DE LA SOUS-FONCTION AJOUTER%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ajouter(obj,event)

% R�cup�ration des donn�es stock�es dans les donn�es d'application de l'objet Figure
% contenant l'objet graphique dont l'action est ex�cut�e (gcbf)
data=guidata(gcbf);

% Augmentation de la valeur de nCompteur
data.nCompteur=data.nCompteur+1;

% Modification de sa propri�t� String
set(data.resultat,'string',num2str(data.nCompteur));

% Enregistrement des donn�es modifi�es dans les donn�es d'application de l'objet Figure
% contenant l'objet graphique dont l'action est ex�cut�e (gcbf)
guidata(gcbf,data)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIN DE LA SOUS-FONCTION AJOUTER%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%