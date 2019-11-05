clear all;
[y, Fs] = audioread("sample.wav",[4*44100 7*44100],'native');



tajne=file2bin('tajne.txt');


samples = y*32768;
sample_int = int16(samples);
sample_int_abs = abs(sample_int);

scalar_matrix = sample_int./sample_int_abs;
scalar_matrix2 = scalar_matrix;
for i=1:numel(scalar_matrix)
    if scalar_matrix(i)==0        
        scalar_matrix2(i)=1;
    end
end


for i=1:length(samples) %zamiast tego mo�na przesun�� o bit w prawo a potem bit lewo, prostsze w implementacji na FPGA
   
    if mod(samples(i),2)== 1;
        samples(i)=samples(i)-1;
    end
end

for i=1:length(bity)
   
    yout(i)=yout(i)+bity(i);
end



%%%%%NORMALIZACJA I ZMIANA NA DOUBLE%%%%%%%%%
% double_y=double(y);
% 
% maxy=max(double_y);
% miny=min(double_y);
% 
% if abs(maxy) > abs(miny)
%     dzielnik=maxy;
% else
%     dzielnik=miny;
% end
% 
% double_y=double_y./dzielnik;
% 


%sound(yout,Fs);
%yout=transpose(yout);
audiowrite('output.wav',yout,Fs,'BitsPerSample',32);
