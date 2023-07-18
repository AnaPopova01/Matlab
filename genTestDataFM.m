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
    title ('Модулирующий сигнал FM');
    xlabel ("t , c");
    ylabel("уровень сигнала");
    saveas(gcf, 'jpg./Модулирующий сигнал FM.jpg', 'jpg')

%%
s_int=0*t;
s_int(1)=sa_M(1);
for i=2:length(t)
        s_int(i)=s_int(i-1)+sa_M(i);
end

y_FM=A*exp(1i*(2*pi*(t*Fc+s_int)));
size=length(y_FM);

dpf_FM = fft (y_FM);
figure (2);
    plot (t/size*Fs*Fs,abs(dpf_FM));
    grid on;
    title ('Спектр');
    xlabel ("f, Гц");
    ylabel("уровень спектра");
    saveas(gcf, 'jpg./Спектр FM-сигнала', 'jpg')

%%

fid = fopen('/home/maksim/work/w_qt/Demodulation/test/config/testDataFM', 'wb');
fwrite(fid,Fc,'uint64');
fwrite(fid,Fs,'uint32');
fwrite(fid,size,'uint64');

for i=1:size
    fwrite(fid,real(y_FM(i)),'float');
    fwrite(fid,imag(y_FM(i)),'float');
end

%%

y_FM=y_FM./exp(1i*2*pi*t*Fc);

z_M=angle(y_FM);
z_M(1)=z_M(1)/2/pi;
temp=z_M(1);
for i=2:size
    dif=(z_M(i)-temp)/2/pi;
    if dif>0.5
        dif=dif-1;
    end
    if dif<-0.5
        dif=dif+1;
    end
    temp = z_M(i);
    z_M(i)=dif;
end

figure (3)
    plot (t, z_M);
    grid on;
    title ('Демодулированный сигнал');
    xlabel ("t , c");
    ylabel("уровень сигнала");
    saveas(gcf, 'jpg./Демодулированный сигнал FM.jpg', 'jpg')

%%
fid = fopen('/home/maksim/work/w_qt/Demodulation/test/config/testDataDFM', 'wb');

fwrite(fid,sa_M,'float');