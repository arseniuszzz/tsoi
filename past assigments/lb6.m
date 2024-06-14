% Загрузка изображения
image = imread('5.jpeg');

% Преобразование изображения в цветовое пространство HSV
hsvo_image = rgb2hsv(image);

% Извлечение канала S (Saturation), который отражает насыщенность цвета
saturation = hsv_image(:,:,2);

% Извлечение канала V (Value), который отражает яркость цвета
value = hsv_image(:,:,3);

% Определение синего цвета в изображении
% Синий цвет в HSV: H (Hue) примерно от 0.5 до 0.7
blue_mask = (hsv_image(:,:,1) >= 0.5) & (hsv_image(:,:,1) <= 0.7);

% Учитываем только те области, где насыщенность и яркость высоки
blue_object_mask = blue_mask & (saturation > 0.5) & (value > 0.5);

% Определение области с наибольшим количеством синего цвета
blue_object_area = bwareafilt(blue_object_mask, 1);

% Выделение наиболее синего объекта
most_blue_object = bsxfun(@times, image, cast(blue_object_area, 'like', image));
most_blue_object(~blue_object_area) = 255;
% Отображение наиболее синего объекта
subplot(2,4,1); imshow(image); title('Исходное изображение');
subplot(2,4,2); imshow(hsvo_image); title('Изображение в HSV');
subplot(2,4,3); imshow(saturation); title('Насыщенность цветов');
subplot(2,4,4); imshow(value); title('Яркость цветов');
subplot(2,4,5); imshow(blue_mask); title('Маска для синего цвета');
subplot(2,4,6); imshow(blue_object_mask); title('Применение маски');
subplot(2,4,7); imshow(blue_object_area); title('Определение большего объекта');
subplot(2,4,8); imshow(most_blue_object); title('Результат');

% Сохранение изображений
imwrite(image, fullfile('DIP/Lab6/Исходное_изображение.jpeg'));
imwrite(hsvo_image, fullfile('DIP/Lab6/Изображение_HSV.jpeg'));
imwrite(saturation, fullfile('DIP/Lab6/Насыщенность_цветов.jpeg'));
imwrite(value, fullfile('DIP/Lab6/Яркость_цветов.jpeg'));
imwrite(blue_mask, fullfile('DIP/Lab6/Маска_для_синего_цвета.jpeg'));
imwrite(blue_object_mask, fullfile('DIP/Lab6/Применение_маски.jpeg'));
imwrite(blue_object_area, fullfile('DIP/Lab6/Определение_большего_объекта.jpeg'));
imwrite(most_blue_object, fullfile('DIP/Lab6/Результат.jpeg'));

