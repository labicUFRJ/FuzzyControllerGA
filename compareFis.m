function  [avaliacao] = compareFis() 
global fis;
fis = readfis ('manual.fis');
avaliacao(1) = testaFis(fis);

fis = readfis ('manualGA.fis');
avaliacao(2) = testaFis(fis);
end