clear all;
close all;
% АМ-модуляция 
% демодуляция: sound (a, Fs)

sec = 44100;
samples = [100*sec,120*sec];
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
y_AM=(1+m_sound).*exp(1i*(2*pi*t*Fc)); %модулированный сигнал


%vect = hilbert (y_AM);
size = length(y_AM);
dataset=zeros(1,2*size);

for i=1:size
    dataset(2*i-1)=real(y_AM(i));
    dataset(2*i)=imag(y_AM(i));
end

fid = fopen('data_for_deAM', 'wb');
fwrite(fid,Fc,'int64');
fwrite(fid,fd,'uint32');
fwrite(fid,size,'uint64');
fwrite(fid,dataset,'float');

% a = read_vector("44100.iqf","float");


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

    