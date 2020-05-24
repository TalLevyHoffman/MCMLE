function TempHeatMap(FRanking, CodePath)

if nargin < 1
    FRanking = 'C:\Users\Tal\Documents\TAU\Thesis\Data Base\Weather\pObs 1.00\Ranking.xlsx';    
end

if nargin < 2
    CodePath = 'C:\Users\Tal\Documents\TAU\Thesis\Data Base\Weather\Processed\State Codes.xlsx';
end

[~,Code2State,~] = xlsread(CodePath);

Code2State = Code2State(2:end,:);
[~,~,Rank] = xlsread(FRanking);

States = shaperead('usastatelo');
Names  = extractfield(States,'Name');

for k = 1 : 1 : size(Rank,2)
   
    Code   = strrep(Rank{1,k},'''','');    
    IndexC = strfind(Code2State(:,2),Code);
    Index  = find(not(cellfun('isempty',IndexC)));
    
    if isempty(Index)
        
        disp('Blame Canada');
        continue;
        
    end
    
    State  = Code2State{Index,1};
    Index  = strmatch(State,Names,'exact'); %#ok<MATCH3>
    
    if isempty(Index)
        
        disp('Blame Canada');
        continue;
        
    end
    
    States(Index).Rank = Rank{2,k};
            
end

for k = 1 : 1 : length(Names)
   
    if isempty(States(k).Rank)
       
        States(k).Rank = 0;
        
    end
    
end

Label = 'Rank';

surfaceColors = makesymbolspec('Polygon', {Label, [0 max([States.(Label)])], 'FaceColor', jet(numel(States)) });

surfaceColors.FaceColor{3}(1,:) = [0 0 0];

% for k = 1 : 1 : length(Names)
%    
%     if States(k).Rank == 0
%        
%         surfaceColors.FaceColor{3}(k,:) = [0 0 0];
%         
%     end
%     
% end

geoshow(States,'DisplayType', 'polygon', 'SymbolSpec', surfaceColors);
grid on; box on;
set(gca,'Color',[0.702 0.78 1]);
set(gca,'xtick',[]);
set(gca,'ytick',[]);
colormap(jet(45));
set(gcf,'Position',[900   138   982   729]);

cbh    = colorbar;
YTickL = [1 5 10 15 20 25 30 35 40 45];
YTick  = (YTickL - 1)/44;
set(cbh,'YTick',YTick);
set(cbh,'YTickLabels',YTickL);

end