close all;
clear all;

W=10;
size = 4096*16;
ansam = 8;
A=sqrt(1.5*W/size);

levW = zeros(1,size);
for i=1:size
    levW(i)=W;
end

x=1i*(rand(ansam,size)-0.5)+(rand(ansam,size)-0.5);
x=x*2*A;   
yn=zeros(1,size);
for j=1:ansam
    ddd = fft(x(j,:));
    yn=yn+abs(ddd).*abs(ddd);
end

yn(1)=0;
yn=yn/ansam;

figure(1)
    plot(yn)
    hold on
    plot(levW,'.')
    xlabel ("f, Гц");
    ylabel("уровень спектра");
    
out_ex = read_complex_vector('testNoise1.iqf','float');
figure(2)
    plot(abs(out_ex))
    xlabel ("f, Гц");
    ylabel("уровень спектра");
    
levW = zeros(1,length(out_ex));
for i=1:length(out_ex)
    levW(i)=W;
end

figure(3)
    plot(abs(out_ex).*abs(out_ex))
    hold on
    plot(levW,'.')
    xlabel ("f, Гц");
    ylabel("уровень спектра");
