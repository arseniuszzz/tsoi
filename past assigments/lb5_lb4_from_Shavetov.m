% 1 пункт
% Чтение изображения
I = imread('2.jpg');

% Преобразование в двоичное изображение
bw = im2bw(I, 0.2);

% Создание структурирующего элемента
se = strel('disk', 5);

% Морфологическая эрозия для устранения выступов
erodedI = imerode(bw, se);

% Морфологическая дилатация для заполнения дырок
dilatedI = imdilate(bw, se);

% Морфологическое открытие
openI = imopen(bw, se);

% Морфологическое закрытие
closeI = imclose(bw, se);

% Отображение результатов
subplot(1,5,1), imshow(I), title('Исходное изображение');
subplot(1,5,2), imshow(erodedI), title('После эрозии');
subplot(1,5,3), imshow(dilatedI), title('После дилатации');
subplot(1,5,4), imshow(openI), title('Открытите');
subplot(1,5,5), imshow(closeI), title('Закрытие');
pause;

% 2 пункт
I2 = imread('3.jpg');
bw2 = im2bw(I2, 0.8);

% Создание структурирующего элемента
se2 = strel('disk', 5);

% Эрозия для разделения объектов
bw_eroded = imerode(bw2, se2);

% Дилатация для восстановления размера объектов
bw_dilated = imdilate(bw_eroded, se2);

t = graythresh (I2);
Inew = im2bw (I2, t);
Inew = ~ Inew;
BW2 = bwmorph (Inew , 'erode' , 35);
BW2 = bwmorph (BW2 , 'thicken', Inf );
Inew = ~( Inew & BW2 );
imshow(Inew);
boundaries = bwperim(Inew);
% Отображение результатов
subplot(1,5,1), imshow(I2), title('Исходное изображение');
subplot(1,5,2), imshow(bw_eroded), title('После эрозии');
subplot(1,5,3), imshow(bw_dilated), title('После дилатации');
subplot(1,5,4), imshow(Inew), title('Разделение');
subplot(1,5,5), imshow(boundaries), title('Контуры объектов');
pause;
% 3 пункт
rgb = imread ('4.jpg');
A = rgb2gray ( rgb );
B = strel ('disk' ,9);
C = imerode (A , B );
Cr = imreconstruct (C , A );
Crd = imdilate ( Cr , B );
Crdr = imreconstruct ( imcomplement ( Crd ) , ...
imcomplement ( Cr ));
Crdr = imcomplement ( Crdr );
fgm = imregionalmax ( Crdr );
A2 = A ;
A2 ( fgm ) = 255;
B2 = strel ( ones (5 ,5));
fgm = imclose ( fgm , B2 );
fgm = imerode ( fgm , B2 );
fgm = bwareaopen ( fgm ,20);
A3 = A ;
A3 ( fgm ) = 255;
bw = imbinarize ( Crdr );
D = bwdist ( bw );
L = watershed ( D );
bgm = L == 0;
hy = fspecial ('sobel');
hx = hy';
Ay = imfilter ( double ( A ) , hy , 'replicate');
Ax = imfilter ( double ( A ) , hx , 'replicate');
grad = sqrt ( Ax .^2 + Ay .^2);
grad = imimposemin ( grad , bgm | fgm );
L = watershed ( grad );
A4 = A ;
A4 ( imdilate ( L == 0 , ...
ones (3 ,3)) | bgm | fgm ) = 255;
Lrgb = label2rgb (L , 'jet' , 'w' , 'shuffle');
subplot(2,2,1); imshow(rgb), title('Исходное изображение');
subplot(2,2,2); imshow(fgm), title('Маркеры переднего плана');
subplot(2,2,3); imshow(Lrgb), title('Результат сегментации');

% Предположим, что 'rgb' - это ваше исходное изображение,
% а 'Lrgb' - это результат сегментации

% Создание композитного изображения
overlayImage = imfuse(rgb, Lrgb, 'blend');

subplot(2,2,4); imshow(overlayImage), title('Сегментация наложенная на исходное изображение');
