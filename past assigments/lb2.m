% 1
empty_image = uint8(zeros(800, 800));

% 2
noise_density = 0.1;
noise_image = imnoise(empty_image, 'salt & pepper', noise_density);
imshow(noise_image)
title(['Полутоновое изображение с шумом'])
pause

% 3
histogram(noise_image(:));
xlabel('Яркость пикселя');
ylabel('Частота');
title(['Гистограмма распределения полученного изображения шума'])
saveas(gcf, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab2\noise_histogram.png');

% 4
obj1 = uint8(ones(800, 800) * 255);
x1 = 200; y1 = 1; % верхний левый угол
x2 = 600; y2 = 800; % нижний правый угол
obj1(y1:y2, x1:x2) = 0; % заполняю прямоугольник черным


imwrite(obj1, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab2\object_image.png');

% 5
scaled_image_nearest = imresize(obj1, 2, 'nearest');
scaled_image_bilinear = imresize(obj1, 2, 'bilinear');
imwrite(scaled_image_nearest, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab2\scaled_image_nearest.png');
imwrite(scaled_image_bilinear, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab2\scaled_image_bilinear.png');

% 6
obj2 = uint8(ones(800, 800) * 255);
x1 = 200; y1 = 1; % верхний левый угол
x2 = 600; y2 = 800; % нижний правый угол
obj2(y1:y2, x1:x2) = 0; % делаю опять прямоугольник
obj2(x1:x2, y1:y2) = 0; % накладываю такой же прямоугольник, чтобы плюсик получился

% фигуру квадрат в квадрате сделал просто наложением 4-х квадратов то черный, то белый
obj3 = uint8(ones(800, 800) * 255);
obj3(:) = 0;
obj3(50:750, 50:750) = 255;
obj3(150:650, 150:650) = 0;
obj3(200:600, 200:600) = 255; 
%imshow(obj3)

plane = uint8(ones(2400, 2400));
plane(1:2400, 1:2400) = 255;

% Располагаю изображения на плоскости
plane(1:800, 1:800) = obj2; % 2 объект в левом верхнем углу
plane(801:1600, 801:1600) = obj1; % 1 объект в центре
plane(1601:2400, 1601:2400) = obj3; % 3 объект внизу справа
noise_plane = imnoise(plane, 'salt & pepper', noise_density);
%imshow(noise_plane)

% 7. Зеркальное отражение по горизонтали
img_flip_hor = flip(noise_plane, 2);
imwrite(img_flip_hor, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab2\img_flip_hor.png');

% 8. Зеркальное отражение по вертикали
img_flip_ver = flip(noise_plane, 1);
imwrite(img_flip_ver, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab2\img_flip_ver.png');

% 9. Поворот изображения по часовой стрелке на 45°
img_rot_45_cw = imrotate(noise_plane, -45);
imwrite(img_rot_45_cw, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab2\img_rot_45_cw.png');

% 10. Поворот изображения против часовой стрелки на 45°
img_rot_45_ccw = imrotate(noise_plane, 45);
imwrite(img_rot_45_ccw, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab2\img_rot_45_ccw.png');

% 11. Выбор изображения фона
fon = imread('C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab2\Fon\Fon.png');
% 12
crop_fon = imcrop(fon, [1 1 799 799]); 
% 13
dark_fon = crop_fon / 4;
% 14
gray_dark_fon = rgb2gray(dark_fon);
scaled_gray_dark_fon = imresize(gray_dark_fon, 2, 'nearest');
scaled_gray_dark_fon(1:800, 1:800) = obj2; % 2 объект в левом верхнем углу
scaled_gray_dark_fon(801:1600, 801:1600) = obj1; % 1 объект внизу справа
noise_sgdf = imnoise(scaled_gray_dark_fon, 'salt & pepper', noise_density);
imwrite(noise_sgdf, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab2\fon_obj12_noise.png');
% 15
neg_ns = imcomplement(noise_sgdf);
imwrite(neg_ns, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab2\neg.png');
% 16
gray_dark_fon2 = rgb2gray(dark_fon);
scaled_gray_dark_fon2 = imresize(gray_dark_fon2, 2, 'nearest');
scaled_gray_dark_fon2(401:1200, 401:1200) = obj3; % 3 объект в центре
noise_sgdf2 = imnoise(scaled_gray_dark_fon2, 'salt & pepper', noise_density);
imwrite(noise_sgdf2, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab2\fon_obj3_noise.png');
% 17
diff = abs(noise_sgdf) - (noise_sgdf2);
imwrite(diff, 'C:\Users\arsen\OneDrive\Desktop\ЦОИ\DIP\Lab2\diff.png');
