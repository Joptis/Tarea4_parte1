%% Seteo inicial de la interfaz
% coprocessorTesting_Oficial.m 
% Creado por Reiner López y José Cayo
% Funcion: Implementa la interfaz para establecer la comunicación
% serial con la FPGA y y comprobar el funcionamiento correcto de las
% operaciones

% Elimina los valores del workspace, las ventanas y linea de comandos
clear all; 
close all;
clc;
pause('on')

N=1024   ;  % Define el numero de elementos de cada vector

%Genera vectores A y B de 1024 elementos con numeros positivos 
%(puede adaptarse facilmente si usan negativos y positivos).
A=ceil(rand(N,1)*100);
B=ceil(rand(N,1)*100);

%Guarda vectores A y B (cada uno de una columna de 1024 filas) en un
%archivo de texto. Cada linea del archivo contiene un elemento.
h= fopen('VectorA.txt', 'w');
fprintf(h, '%i\n', A);
fclose(h);

h= fopen('VectorB.txt', 'w');
fprintf(h, '%i\n', B);
fclose(h);

% Códigos asignados a cada operación
BRAMA = 1;
BRAMB = 2;
readVec_A = 3;
readVec_B = 4;
sumVec = 5;
avgVec = 6;
eucDist = 7; 
manDist = 8;

% Calcula valores de referencia para las operaciones, realizadas en forma local en el host
sumVec_host = A+B;
avgVec_host = (A+B)/2;
man_host = sum(abs(A-B));
euc_host = sqrt(sum((A-B).^2));

if ~isempty(instrfind)
     fclose(instrfind);
     delete(instrfind);
end

%% A partir de aca se realizan las operaciones por medio de comandos al coprocesador

% Primero setear puerto serial, y primero se busca los puertos disponibles
ports=serialportlist("available");

% Se abre ventana para elegir el puerto
[indx,tf] = listdlg('PromptString',...
{'Seleccione uno de los puertos','Asegúrese de tener conectado la FPGA en el puerto libre correspondiente',''},...
'SelectionMode','single','ListString',ports);

%Asignacion del puerto
COM_port=serialport(ports(indx),115200);

%Importo datos al workspace
A = importdata('vectorA.txt');
B = importdata('vectorB.txt'); 

% Escribe un vector almacenado en un archivo de texto 
% en la BRAM indicada por medio de la UART
write2dev(BRAMA,A,COM_port); 
write2dev(BRAMB,B,COM_port); 

% Lee el vector almacenado en el bloque de memoria correspondiente
VecA_device = command2dev(readVec_A, COM_port,N);
VecB_device = command2dev(readVec_B, COM_port,N);

% Calcula la suma elemento a elemento de los vectores A y B previamente
% almacenados.
sumVec_device = command2dev(sumVec, COM_port,N);
avgVec_device = command2dev(avgVec, COM_port,N);

% Comando para ejecutar operacion de la distancia de Manhattan.
 write(COM_port,eucDist,'uint8'); 
 man_device=read(COM_port,3,'uint8');
 tmp=dec2bin( [man_device(1) ; man_device(2) ; man_device(3)],8 );
 man_device=reshape(tmp.',1,[]);
 man_device=bin2dec(man_device);
 

% Comando para ejecutar operacion de  la distancia euclideana. 
 write(COM_port,manDist,'uint8');
 euc_device=read(COM_port,3,'uint8');
 tmp=dec2bin( [euc_device(1) ; euc_device(2) ; euc_device(3)],8 );
 euc_device=reshape(tmp.',1,[]);
 euc_device=bin2dec(euc_device);


%% Validacion.
% Cálculo de error para cada operación
euc_diff = euc_host - euc_device;
sumVec_diff = sum(sumVec_host - sumVec_device.');
avgVec_diff = sum(avgVec_host - avgVec_device.');
man_diff = man_host - man_device;
euc_diff = euc_host - euc_device;
