close all;
clear all;

Fd = 1000;
F = 100;
T = 1/Fd;
N = 2000;

t=0:T:(N*T-T);

in = t.*t.*exp(1i*t.*t*F);

out = fft(in);

fid = fopen('/home/maksim/work/w_qt/Demodulation/test/config/testDataFftwFin', 'wb');
for i=1:N
    fwrite(fid,real(in(i)),'float');
    fwrite(fid,imag(in(i)),'float');
end
fid = fopen('/home/maksim/work/w_qt/Demodulation/test/config/testDataFftwFout', 'wb');
for i=1:N
    fwrite(fid,real(out(i)),'float');
    fwrite(fid,imag(out(i)),'float');
end

inn = out;

fid = fopen('/home/maksim/work/w_qt/Demodulation/test/config/testDataFftwBin', 'wb');
for i=1:N
    fwrite(fid,real(inn(i)),'float');
    fwrite(fid,imag(inn(i)),'float');
end
outt = ifft(inn);
fid = fopen('/home/maksim/work/w_qt/Demodulation/test/config/testDataFftwBout', 'wb');
for i=1:N
    fwrite(fid,real(outt(i)),'float');
    fwrite(fid,imag(outt(i)),'float');
end