
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEBUT DE LA FONCTION PRINCIPALE%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function gui_guidata_guihandles
data=guihandles(gcf);



% Cr�ation de l'objet Figure
figure('units','pixels',...
    'position',[250 200 600 500],...
    'color',[0.95 0.95 0.95],...
    'numbertitle','off',...
    'name','Projet Traitement de Signal : Reconnaissance vocale',...
    'menubar','none',...
    'tag','interface');

% Cr�ation de l'objet Titre
uicontrol('style','text',...
    'units','normalized',...
    'position',[0.35 0.9 0.3 0.03],... %[X,Y,Largeur,Hauteur]
    'string','Dictionnaire d''acronyme');

% Cr�ation de l'objet affich� lors d'un enregristrement audio
uicontrol('style','text',...
    'units','normalized',...
    'position',[0.5 0.5 0.3 0.03],... %[X,Y,Largeur,Hauteur]
    'string','',...
    'tag','resultat');

% Cr�ation de l'objet Uicontrol Bouton Enregistrer
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.08 0.8 0.15 0.05],...
    'string','Enregistrer',...
    'callback',@record,...
    'tag','bouton_retrancher');

% Cr�ation de l'objet Uicontrol Bouton Jouer
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.31 0.8 0.15 0.05],...
    'string','Jouer',...    
    'callback',@ecouter,...
    'tag','bouton_ecouter');

% Cr�ation de l'objet Uicontrol Bouton Reconnaitre
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.54 0.8 0.15 0.05],...
    'string','Reconnaitre',...    
    'callback',@match,...
    'tag','bouton_match');

% Cr�ation de l'objet Uicontrol Bouton Quitter
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.77 0.8 0.15 0.05],...
    'string','Quitter',...    
    'callback',@close,...
    'tag','bouton_close');

%D�finition des variables

data.resultat=blanks(1);
%Nombre de lettre que l'utilisateur a enregistr�
data.nbletter=0;
%Tableau contenant les lettres enregistr�es
data.tbcell = cell(data.nbletter,1);
%Tableau contenant les sons enregistr�s
data.tbsignaux=cell(data.nbletter,1);
%Alphabet
data.alphabet={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9'};
for i=1:length(data.alphabet)
    path=strcat(data.alphabet{i},'.wav');
    if exist(path)
        data.nbletter=data.nbletter+1;
        data.tbcell{data.nbletter,1}=data.alphabet{i};
        data.tbsignaux{data.nbletter,1}=wavread(path);
    end;
end;

data.columnName = {'Lettre'};
data.tableau=uitable('ColumnName', data.columnName,'Data', data.tbcell,'Position',[50 50 110 320]);

% Enregistrement de data dans les donn�es d'application de l'objet Figure

guidata(gcf,data)

%%%%%%%%%%%%%%%%%%%%%%%%
%FONCTIONS SECONDAIRES%
%%%%%%%%%%%%%%%%%%%%%%%%

function close(obj,event)
answer = questdlg('Etes-vous s�r(e) de vouloir quitter l''application?', ...
        'Exit Dialog','Oui','Non','Non'); 
if strcmp(answer,'Oui')
   delete(gcf); 
end


function record(obj,event)

% R�cup�ration des donn�es stock�es dans les donn�es d'application de l'objet Figure
% contenant l'objet graphique dont l'action est ex�cut�e (gcbf)
data=guidata(gcbf);
%R�cup�ration du son a enregistr�
signal=record2data(1,1,16000);
prompt=cell(1);
answer=inputdlg(prompt);
temp=answer{1,1};
%Cr�ation du nom du fichier sur base du nom donn� par l'utilisateur
pathname=strcat(temp,'.wav');
if exist(pathname)
    i=0;
    find=0;
    while(find==0)
        i=i+1;
        temp2=data.tbcell{i,1};
         if (temp2==temp)
            wavwrite(signal,pathname);
            data.tbsignaux{i,1}=signal; 
            find=1;
        end;
    end;
else
%Insertion 
data.nbletter=data.nbletter+1;
data.tbcell{data.nbletter,1}=answer{1,1};
data.tbsignaux{data.nbletter,1}=signal; 
wavwrite(signal,pathname);   
end;

%Rafraichissement du tableau
set(data.tableau, 'Data', data.tbcell);

% Enregistrement des donn�es modifi�es dans les donn�es d'application de l'objet Figure
% contenant l'objet graphique dont l'action est ex�cut�e (gcbf)
guidata(gcbf,data)


function ecouter(obj,event)
data=guidata(gcbf);
prompt=cell(1);
answer=inputdlg(prompt);
answer=answer{1,1};
temp=answer;
i=0;
find=0;
while(find==0)
    i=i+1;
    if i>length(data.tbcell)
        warndlg(sprintf('Son incorrecte'));
        break;
    end;
    if (data.tbcell{i,1}==temp)
        sound(data.tbsignaux{i,1},data.Fs);
        find=1;
    end;
end;
guidata(gcbf,data)

function match(obj,event)
data=guidata(gcbf);
recognizion=record2data(-1,1,16000);
a=diffBetweenSignals_newGen(recognizion,data.tbsignaux,16000);    
longueur_mot=length(a);
mot=blanks(longueur_mot);
for i=1:longueur_mot
    mot(i)=data.tbcell{a{1,i},1};
end
disp(mot);
mot=upper(mot);
web(strcat('http://en.wikipedia.org/wiki/',mot));


% Enregistrement des donn�es modifi�es dans les donn�es d'application de l'objet Figure
% contenant l'objet graphique dont l'action est ex�cut�e (gcbf)
guidata(gcbf,data)

