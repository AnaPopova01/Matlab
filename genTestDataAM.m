clear all;
close all;
% чтение файла, запись значений в массив, АМ-модуляция, запись в новый файл для последующей демодуляции
% местная демодуляция массива и запись значений в файл


%% модуляция
close all;
clear all;

[sa_M,Fs]=audioread('/home/maksim/work/w_ml/Matlab/bin/K&Sh.mp3',[1,1]);
samples = [0*Fs+1,10*Fs];
samples = [27000+1,28000];
[sa_M,Fs]=audioread('/home/maksim/work/w_ml/Matlab/bin/K&Sh.mp3',samples);

T=1/Fs;
T1=0;
T2=length(sa_M)*T;
t=T1:T:T2-T;
Fc=5500;
A=1;

sa_M=sa_M(:,1).';

figure (1)
    plot (t, sa_M);
    grid on;
    title ('Модулирующий сигнал AM');
    xlabel ("t , c");
    ylabel("уровень сигнала");
    saveas(gcf, 'jpg./Модулирующий сигнал AM.jpg', 'jpg')

%%

y_AM=A*(1+sa_M).*exp(1i*(2*pi*t*Fc)); % модулированный сигнал
size=length(y_AM);

dpf_AM = fft (y_AM);
figure (2);
    plot (t/size*Fs*Fs,abs(dpf_AM));
    grid on;
    title ('Спектр');
    xlabel ("f, Гц");
    ylabel("уровень сигнала");
    saveas(gcf, 'jpg./Спектр AM-сигнала', 'jpg')

%%

fid = fopen('/home/maksim/work/w_qt/Demodulation/test/config/testDataAM', 'wb');
fwrite(fid,Fc,'uint64');
fwrite(fid,Fs,'uint32');
fwrite(fid,size,'uint64');

for i=1:size
    fwrite(fid,real(y_AM(i)),'float');
    fwrite(fid,imag(y_AM(i)),'float');
end

%% демодуляция

z_M = abs(y_AM)-1;

figure (3)
    plot (t, z_M);
    grid on;
    title ('Демодулированный сигнал AM');
    xlabel ("t , c");
    ylabel("уровень сигнала");
    saveas(gcf, 'jpg./Демодулированный сигнал AM.jpg', 'jpg')
    
%%

fid = fopen('/home/maksim/work/w_qt/Demodulation/test/config/testDataDAM', 'wb');

fwrite(fid,sa_M,'float');
    