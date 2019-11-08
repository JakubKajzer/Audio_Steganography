clear all;
[y, Fs] = audioread("output.wav",'native');

%samples = y*32768;
%sample_int = int16(samples);

ack='0100011100000110000111001011'; % '#ACK' binarnie


sample_int=y;
for i=1:length(sample_int)
   
    wynik(i)=mod(sample_int(i),2);
end
final = int2str(wynik);
final = final(~isspace(final));

final_string=string(final);
ack_string=string(ack);

miejsca=strfind(final_string,ack_string);

dlugosc_kodu=(miejsca(2)-miejsca(1)-length(ack))/7;

for i=1 : length(miejsca)-1
    
    if(miejsca(i)+length(ack) < length(final))
        choppedText(i,:)=final(miejsca(i)+length(ack):miejsca(i+1)-1); 
    end
    
end

MoreChoppedText = vec2mat(choppedText,7);

Wycinek=MoreChoppedText(1:dlugosc_kodu,:);
Wycinek=bin2dec(Wycinek);
Wycinek=char(Wycinek);
Wycinek=transpose(Wycinek);
Wycinek=string(Wycinek)
