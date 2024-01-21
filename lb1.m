% 1, 2
f = imread('C:\Users\arsen\OneDrive\Desktop\ЦОИ\1.jpg'); 
% 3
imshow(f) 
title('Исходное изображение');
pause
% 4
imwrite(f, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\1_1.jpg'); 
% 5
imwrite(f, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\1_1.png'); 
% 6
info_f1 = imfinfo('C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\1_1.jpg'); 
info_f2 = imfinfo('C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\1_1.png'); 
% 7
%% Рассчитать и сравнить степень сжатия изображений в форматах jpg и png по формуле:
%% Ks = ((W*H*Bit)/8) / FileSize, где Ks – степень сжатия изображения; 
%% W H, – высота и ширина изображения в пикселях; Bit – разрядность изображения в бит; 
%% FileSize – размер файла изображения в байтах.
W = length(f); 
H = width(f);
Bit1 = info_f1.BitDepth;
Bit2 = info_f2.BitDepth;
FS1 = info_f1.FileSize;
FS2 = info_f2.FileSize;
Ks_1 = ((W*H*Bit1)/8)/FS1;
Ks_2 = ((W*H*Bit2)/8)/FS2;
Ks_dif = Ks_1 - Ks_2; 
% 8
g = rgb2gray(f); 
imshow(g);
title('Полутоновое изображение');
pause
imwrite(g, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\1_g.jpg');
% 9
BW25 = im2bw(g, 0.25); 
BW50 = im2bw(g, 0.50);
BW75 = im2bw(g, 0.75);
imshow(BW25);
title('Полутоновое с порогом 25%');
pause
imshow(BW50);
title('Полутоновое с порогом 50%');
pause
imshow(BW75);
title('Полутоновое с порогом 75%');
pause
imwrite(BW25, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\Logical\1_25.jpg');
imwrite(BW50, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\Logical\1_50.jpg');
imwrite(BW75, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\Logical\1_75.jpg');
% 10
% Преобразование полутонового изображения в 8-битовое
bitImage = im2uint8(g);

% Разбиение на битовые плоскости
bitPlanes = zeros(size(bitImage, 1), size(bitImage, 2), 8, 'uint8');
for i = 1:8
    bitPlanes(:,:,i) = bitget(bitImage, i);
end

% Вывод каждой битовой плоскости на экран
for i = 1:8
    figure;
    imshow(logical(bitPlanes(:,:,i))); % Преобразует каждую битовую плоскость в двоичное изображение
    title(['Битовая плоскость ', num2str(i)]);
end

% Сохранение каждой отдельной битовой плоскости в директорию
for i = 1:8
    imwrite(logical(bitPlanes(:,:,i)), ['C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\BitPlane\8bit_', num2str(i), '.jpg']);
end
% 11
BLK5 = blkproc(g, [5 5],'mean2(x)*ones(size(x))');
BLK10 = blkproc(g, [10 10],'mean2(x)*ones(size(x))');
BLK20 = blkproc(g, [20 20],'mean2(x)*ones(size(x))');
BLK50 = blkproc(g, [50 50],'mean2(x)*ones(size(x))');
imwrite(BLK5, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\Discret\BLK5.jpg');
imwrite(BLK10, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\Discret\BLK10.jpg');
imwrite(BLK20, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\Discret\BLK20.jpg');
imwrite(BLK50, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\Discret\BLK50.jpg');
% 12
quantized_4 = imquantize(g, linspace(0, 255, 4));
quantized_16 = imquantize(g, linspace(0, 255, 16));
quantized_32 = imquantize(g, linspace(0, 255, 32));
quantized_64 = imquantize(g, linspace(0, 255, 64));
quantized_128 = imquantize(g, linspace(0, 255, 128));
imwrite(quantized_4, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\Quantiz\quantized_4.jpg');
imwrite(quantized_16, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\Quantiz\quantized_16.jpg');
imwrite(quantized_32, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\Quantiz\quantized_32.jpg');
imwrite(quantized_64, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\Quantiz\quantized_64.jpg');
imwrite(quantized_128, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\Quantiz\quantized_128.jpg');
% 13
Y = length(g)/2;
X = width(g)/2;
Crop = imcrop(g,[X-50 Y-50 99 99])
pause
imshow(Crop)
title('Обрезанное изображение');
imwrite(Crop, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1\Crop\Crop.jpg');
% 14
N1 = g(21,18:21)
N2_1 = g(16,12)
N2_2 = g(17,13)
N2_3 = g(18,14)
N2_4 = g(19,15)
N2 = [N2_1, N2_2, N2_3, N2_4]
N3 = g(19,89:96)
% 15
MBL = mean(g(:));
% 16
Mg = g;

if MBL < 128
    lc = 255; % Белый цвет
else
    lc = 0; % Черный цвет
end

lSize = 20; % Размер квадрата метки

Mg(1:lSize, 1:lSize) = lc; % Левый верхний угол
Mg(1:lSize, end-lSize+1:end) = lc; % Правый верхний угол
Mg(end-lSize+1:end, 1:lSize) = lc; % Левый нижний угол
Mg(end-lSize+1:end, end-lSize+1:end) = lc; % Правый нижний угол
centerX = floor(size(Mg, 2) / 2);
centerY = floor(size(Mg, 1) / 2);
Mg(centerY-lSize/2:centerY+lSize/2, centerX-lSize/2:centerX+lSize/2) = lc; % Центр

figure;
imshow(Mg);
title('Изображение с метками');

imwrite(Mg, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab1/Marks/Marks.jpg');
