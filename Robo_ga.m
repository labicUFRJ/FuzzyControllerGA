%Universidade federal do Rio de Janeiro
%N�cleo de Computa��o Eletr�nica
%Disciplina de Intelig�ncia Computacional
%Lista 3 - Algoritmos Gen�ticos
%Professor Adriano Cruz

%Autores: Ant�nio Lacerda, Gabriel C. Abi-Abib e Marcelo Figueiredo
%Data 11/06/2014


clear all
clc

nvars = 1200;
populacao_inicial = 20;
geracoes = 120;
elitismo = 2;


options = gaoptimset ('UseParallel','always','PopulationType','bitstring','PopulationSize',populacao_inicial,'Generations',geracoes,'EliteCount',elitismo,'PlotFcns',{@gaplotbestindiv,@gaplotbestf},'StallGenLimit',geracoes);

[variavel fval] = ga (@runFitness, nvars, options);
variavel
fval

j=0;
l=1;
 for i=1:1200
        j=j+1;
        y(j)=variavel(i);
        if j==3
            variavel_int(l)=bi2de(y);
            if variavel_int(l)==0
                variavel_int(l)=1;
            end
            l=l+1;
            j=0;
        end
 end
  
    fis = readfis ('manual.fis');

    %Carregando as regras geradas pelo Algoritmo Gen�tico:
    for contador=1:200
        fis.rule(1,contador).consequent(1,1) = variavel_int(2*contador-1);
        if variavel_int(2*contador) > 5
            variavel_int(2*contador) = 5;
            fis.rule(1,contador).consequent(1,2) = variavel_int(2*contador);
        else 
            fis.rule(1,contador).consequent(1,2) = variavel_int(2*contador);
        end  
    end
    writefis(fis,'manualGA.fis');

fix(clock)