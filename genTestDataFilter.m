close all;
clear all;

Fd = 1000;
F = 700;
T = 1/Fd;
N = 2000;
Fc = 400;
Fw = 100;


t=0:T:(N*T-T);

sig = t.*t.*exp(1i*t.*t*F);

in = fft(sig);

fid = fopen('/home/maksim/work/w_qt/Demodulation/test/config/testDataFilterIn', 'wb');
fwrite(fid,Fc,'uint64');
fwrite(fid,Fd,'uint32');
fwrite(fid,N,'uint64');
for i=1:N
    fwrite(fid,real(sig(i)),'float');
    fwrite(fid,imag(sig(i)),'float');
end

out=in;

Fl=Fc-Fw/2+Fd;
Fh=Fc+Fw/2;
fl=floor(mod(Fl,Fd)*N/Fd);
fh=floor(mod(Fh,Fd)*N/Fd);

if fl<=fh
    for i=0:fl
        out(i+1)=0;
    end
    for i=fh:(N-1)
        out(i+1)=0;
    end
end
if fl>fh
    for i=fh:fl
        out(i+1)=0;
    end
end

osig=ifft(out);
fid = fopen('/home/maksim/work/w_qt/Demodulation/test/config/testDataFilterOut', 'wb');
for i=1:N
    fwrite(fid,real(osig(i)),'float');
    fwrite(fid,imag(osig(i)),'float');
end

f=(0:(N-1))*Fd/N;

out_ex = read_complex_vector('test1000.iqf','float');
figure(1)
    plot(f,abs(fft(osig)),'.')
    hold on
    plot(f,abs(fft(out_ex)))
    xlabel ("f, Гц");
    ylabel("уровень спектра");
  
    
    
Fc=0;    
Fw=200;    

fid = fopen('/home/maksim/work/w_qt/Demodulation/test/config/testDataFilterInC0', 'wb');
fwrite(fid,Fc,'uint64');
fwrite(fid,Fd,'uint32');
fwrite(fid,N,'uint64');
for i=1:N
    fwrite(fid,real(sig(i)),'float');
    fwrite(fid,imag(sig(i)),'float');
end

out=in;

Fl=floor(Fc-Fw/2+Fd);
Fh=floor(Fc+Fw/2);
fl=floor(mod(Fl,Fd)*N/Fd);
fh=floor(mod(Fh,Fd)*N/Fd);

if fl<=fh
    for i=0:fl
        out(i+1)=0;
    end
    for i=fh:(N-1)
        out(i+1)=0;
    end
end
if fl>fh
    for i=fh:fl
        out(i+1)=0;
    end
end

osig=ifft(out);
fid = fopen('/home/maksim/work/w_qt/Demodulation/test/config/testDataFilterOutC0', 'wb');
for i=1:N
    fwrite(fid,real(osig(i)),'float');
    fwrite(fid,imag(osig(i)),'float');
end