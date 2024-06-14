% 1
pic = imread('DIP/Lab3/pic.jpg');
pic_h = histogram(pic);
saveas(pic_h, 'DIP/Lab3/pic_histogram.jpg');
% 2
pic_double = im2double(pic); % Преобразование изображения в double для выполнения логарифмического преобразования
c = 1/log(1 + max(pic_double(:)));
pic_log = c * log(1 + pic_double); % Выполнение логарифмического преобразования
imwrite(pic_log, 'DIP/Lab3/Log/pic_log.jpg');
pic_log_h = histogram(pic_log);
saveas(pic_log_h, 'DIP/Lab3/Log/pic_log_h.jpg');
% 3 Выполнение степенного преобразования
pic_gamma_1 = pic_double .^ 0.1; 
pic_gamma_2 = pic_double .^ 0.45; 
pic_gamma_3 = pic_double .^ 5; 
imwrite(pic_gamma_1, 'DIP\Lab3\Degree\pic_gamma_1.jpg');
imwrite(pic_gamma_2, 'DIP\Lab3\Degree\pic_gamma_2.jpg');
imwrite(pic_gamma_3, 'DIP\Lab3\Degree\pic_gamma_3.jpg');
figure; imhist(pic_gamma_1);
saveas(gcf, 'DIP\Lab3\Degree\pic_gamma_h_1.jpg');
figure; imhist(pic_gamma_2);
saveas(gcf, 'DIP\Lab3\Degree\pic_gamma_h_2.jpg');
figure; imhist(pic_gamma_3);
saveas(gcf, 'DIP\Lab3\Degree\pic_gamma_h_3.jpg');
% 4 Я взял вариант индивидуальный № 14
% Определение функции кусочно-линейного преобразования
x = [0, 50, 50, 100, 100, 150, 150, 200, 200, 255] / 255;
y = [0, 255, 0, 255, 0, 255, 0, 255, 0, 255] / 255;

% Выполнение кусочно-линейного преобразования
pic_t = pic_double;
pic_t = im2double(pic_t);
for i = 1:length(x)-1
    mask = (pic_double >= x(i)) & (pic_double < x(i+1));
    pic_t(mask) = y(i) + (y(i+1) - y(i)) * (pic_double(mask) - x(i)) / (x(i+1) - x(i));
end

imwrite(pic_t, 'DIP/Lab3/Line_Contrast/pic_t.jpg');
figure; imhist(pic_t);
saveas(gcf, 'DIP/Lab3/Line_Contrast/pic_t_h.png');
% 5
pic_eq = histeq(pic);
imwrite(pic_eq, 'DIP\Lab3\Equaliz\pic_eq.jpg');
figure; imhist(pic_eq);
saveas(gcf, 'DIP\Lab3\Equaliz\pic_eq_h.png');
% 6
% Размеры маски
mask_sizes = [3, 15, 35];

for i = 1:length(mask_sizes)
    % Создание усредняющего фильтра
    h = fspecial('average', mask_sizes(i));

    % Применение фильтра к изображению
    pic_f = imfilter(pic, h);

    % Сохранение полученного изображения
    imwrite(pic_f, sprintf('DIP\\Lab3\\Filter\\pic_f_%d.jpg', mask_sizes(i)));
end
% 7
% Создание фильтра повышения резкости
h = fspecial('unsharp');

% Применение фильтра к изображению
pic_sharp = imfilter(pic, h);

% Сохранение полученного изображения
imwrite(pic_sharp, 'DIP\\Lab3\\Filter\\pic_sharp.jpg');
% 8 
% Размеры маски
mask_sizes = [3, 9, 15];

for i = 1:length(mask_sizes)
    % Применение медианного фильтра к изображению
    pic_median = medfilt2(pic, [mask_sizes(i) mask_sizes(i)]);

    % Сохранение полученного изображения
    imwrite(pic_median, sprintf('DIP\\Lab3\\Median\\pic_median_%d.jpg', mask_sizes(i)));
end
% 9
% Выделение границ методом Робертса
pic_roberts = edge(pic, 'roberts');
imwrite(pic_roberts, 'DIP\\Lab3\\Edge\\pic_roberts.jpg');

% Выделение границ методом Превитта
pic_prewitt = edge(pic, 'prewitt');
imwrite(pic_prewitt, 'DIP\\Lab3\\Edge\\pic_prewitt.jpg');

% Выделение границ методом Собеля
pic_sobel = edge(pic, 'sobel');
imwrite(pic_sobel, 'DIP\\Lab3\\Edge\\pic_sobel.jpg');
% 10
% Добавление шума "соль и перец"
noisy_pic = imnoise(pic, 'salt & pepper', 0.1);

% Сохранение зашумленного изображения
imwrite(noisy_pic, 'DIP\\Lab3\\Filter\\noisy_pic.jpg');

% Выполнение пространственной фильтрации зашумленного изображения
% Здесь я решил использовать медианный фильтр, который хорошо работает для устранения шума "соль и перец"
filtered_pic = medfilt2(noisy_pic);

% Сохранение отфильтрованного изображения
imwrite(filtered_pic, 'DIP\\Lab3\\Filter\\filtered_pic.jpg');
