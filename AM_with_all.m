clear all;
close all;
% блок 1 :чтение файла, запись значений в массив, АМ-модуляция, запись в новый файл для последующей демодуляции
% демодуляция: sound (a, Fs)


%% модуляция
sec = 44100;
samples = [100*sec,105*sec];
[m_sound,Fs]=audioread('K&Sh.mp3',samples);

m_sound=m_sound(:, 1).';

fd = 44100;
T = 1/fd;
T1 = 0;
T2 = length(m_sound)*T; 
t = T1:T:T2-T;
Fc = fd/4;

%y_AM = ammod(m_sound,Fc,fd);
%plot (y_AM);
x_AM=(1+m_sound).*exp(1i*(2*pi*t*Fc)); % модулированный сигнал

sizex = length(x_AM);
datasetx=zeros(1,2*sizex);

for i=1:sizex
    datasetx(2*i-1)=real(x_AM(i));
    datasetx(2*i)=imag(x_AM(i));
end

fid = fopen('/home/ann/WORK/work_qt/firstSt/Demodulation/Base/test/config/new_test_for_deAM', 'wb'); % здесь путь файла для записи модулированного сигнала
fwrite(fid,Fc,'uint64');
fwrite(fid,fd,'uint32');
fwrite(fid,sizex,'uint64');
fwrite(fid,datasetx,'double');

%% демодуляция

y_AM = abs(x_AM)-1;
sizey = length(y_AM);
datasety=zeros(1,sizey);

for i=1:sizey
    datasety(i)=y_AM(i);
end

fid = fopen('/home/ann/WORK/work_qt/firstSt/Demodulation/Base/test/config/new_output_for_deAM', 'wb'); % здесь путь файла с демодулированным образцовым
fwrite(fid,datasety,'double');


%% графики
%{
u = cos(2*pi*f*t); % несущий
U = cos(2*pi*F*t);  % модулирующий
AM = (1+m*cos(2*pi*F*t)).*cos(2*pi*f*t); % AM-сигнал
dpf_AM = fft (AM); % спектр
%}

%{
figure ()
    grid on;
    plot (t,AM);
    title ('АМ-сигнал');
    xlabel ("t , c");
    ylabel("уровень сигнала");
    
figure ()
    plot (t,u);
    title ('ВЧ-сигнал');
    xlabel ("t , c");
   ylabel("уровень сигнала");
   
figure ();
    plot (t,U);
    title ('НЧ-сигнал');
    xlabel ("t , c");
    ylabel("уровень сигнала");

figure ();
    plot (abs(dpf_AM));
    title ('Спектр');
    xlabel ("f, Гц");
    ylabel("уровень сигнала");
%}
%%
    