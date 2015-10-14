function  [avaliacao] = testaFis() 
global termStatus;
global fis;

fi_inicial = -pi/2;
yci_inicial = 6;
yf = 100;
r = 6;
numTestes = 0;
fis=readfis('manualGAOld.fis');

while (yci_inicial <= yf - r)
    while (fi_inicial <= 1.58) %1.58 = pi/2
        xci = 6;
        yci = yci_inicial;
        fi = fi_inicial;
        %disp(xci)
        %disp(yci)
        %disp(fi)
        %robot = robotCreate(6, randAB(10, 90), randAB(-60, 60), 'Random');
        robot = robotCreate(xci, yci, fi, 'Manual');
        %environ = environCreate(5);
        %environ = environCreate([128.31 25.87; 71.43 26.05; 55.65 47.52; 39.60 34.77; 183.81 47.07]);
        environ = environCreate('obstMain.mat');
        %environ = environCreate('obstRandom.mat');
        %environ = environCreate('obstRandom.mat', 42);
        %ui = uiPlotCreate(0.001, 1);
        [robotResult] = runSimulation(environ, robot);
        numTestes = numTestes + 1;
        resultado(numTestes,1) = termStatus.colideWall + termStatus.colideObst;
        resultado(numTestes,2) = termStatus.success;
        resultado(numTestes,3) = xci;
        resultado(numTestes,4) = yci;
        resultado(numTestes,5) = fi;
        resultado(numTestes,6) = robotResult{1}.x;
        resultado(numTestes,7) = robotResult{1}.y;
        resultado(numTestes,8) = robotResult{1}.phi;
        termStatus.colideObst = 0;
        termStatus.colideWall = 0;
        termStatus.success = 0;
        fi_inicial = fi_inicial + pi/10;

    end
  
    yci_inicial = yci_inicial + 5;
    fi_inicial = -pi/2;
end

total_erros = 0;
for i =1:numTestes
    total_erros = total_erros + resultado(i,1);
end

total_acertos = numTestes - total_erros
percentual_acertos = (total_acertos)/numTestes;
totalTestes = numTestes/100
avaliacao = 1 - (total_acertos/numTestes)
end
