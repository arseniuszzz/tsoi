function main

% 1

pic = imread('DIP/Lab4/pic.jpg');
F = fft2(double(pic)); % Получение двумерного преобразования Фурье изображения
F_shift = fftshift(F); % Центрирование спектра
amp_spectrum = abs(F_shift); % Получение амплитудного спектра
imwrite(mat2gray(log(1 + amp_spectrum)), 'DIP/Lab4/pic_spectrum.jpg');

% 2

[M, N] = size(pic); % Размеры изображения
D0_values = [5, 10, 50, 250];

% Применение идеального фильтра низких частот
for D0 = D0_values
    ILPF = idealLowPassFilter(D0, M, N);
    filtered_image = real(ifft2(ifftshift(F_shift .* ILPF)));
    imwrite(mat2gray(filtered_image), sprintf('DIP/Lab4/Low/Ideal/pic_ILPF_%d.jpg', D0));
end

% Применение фильтра Баттерворта низких частот
n = 2; % Порядок фильтра
for D0 = D0_values
    BLPF = butterworthLowPassFilter(D0, n, M, N);
    filtered_image = real(ifft2(ifftshift(F_shift .* BLPF)));
    imwrite(mat2gray(filtered_image), sprintf('DIP/Lab4/Low/Butter/pic_BLPF_%d.jpg', D0));
end

% Применение фильтра Гаусса низких частот
for D0 = D0_values
    GLPF = gaussianLowPassFilter(D0, M, N);
    filtered_image = real(ifft2(ifftshift(F_shift .* GLPF)));
    imwrite(mat2gray(filtered_image), sprintf('DIP/Lab4/Low/Gaus/pic_GLPF_%d.jpg', D0));
end

% 3

% Применение идеального фильтра высоких частот
for D0 = D0_values
    IHPF = 1 - idealLowPassFilter(D0, M, N);
    filtered_image = real(ifft2(ifftshift(F_shift .* IHPF)));
    imwrite(mat2gray(filtered_image), sprintf('DIP/Lab4/High/Ideal/pic_IHPF_%d.jpg', D0));
end

% Применение фильтра Баттерворта высоких частот
for D0 = D0_values
    BHPF = 1 - butterworthLowPassFilter(D0, n, M, N);
    filtered_image = real(ifft2(ifftshift(F_shift .* BHPF)));
    imwrite(mat2gray(filtered_image), sprintf('DIP/Lab4/High/Butter/pic_BHPF_%d.jpg', D0));
end

% Применение фильтра Гаусса высоких частот
for D0 = D0_values
    GHPF = 1 - gaussianLowPassFilter(D0, M, N);
    filtered_image = real(ifft2(ifftshift(F_shift .* GHPF)));
    imwrite(mat2gray(filtered_image), sprintf('DIP/Lab4/High/Gaus/pic_GHPF_%d.jpg', D0));
end

function ILPF = idealLowPassFilter(D0, M, N)
    u = 0:(M-1);
    v = 0:(N-1);
    idx = find(u>M/2);
    u(idx) = u(idx)-M;
    idy = find(v>N/2);
    v(idy) = v(idy)-N;
    [V, U] = meshgrid(v, u);
    D = sqrt(U.^2+V.^2);
    ILPF = double(D<=D0);
end

function BLPF = butterworthLowPassFilter(D0, n, M, N)
    u = 0:(M-1);
    v = 0:(N-1);
    idx = find(u>M/2);
    u(idx) = u(idx)-M;
    idy = find(v>N/2);
    v(idy) = v(idy)-N;
    [V, U] = meshgrid(v, u);
    D = sqrt(U.^2+V.^2);
    BLPF = 1./(1 + (D./D0).^(2*n));
end

function GLPF = gaussianLowPassFilter(D0, M, N)
    u = 0:(M-1);
    v = 0:(N-1);
    idx = find(u>M/2);
    u(idx) = u(idx)-M;
    idy = find(v>N/2);
    v(idy) = v(idy)-N;
    [V, U] = meshgrid(v, u);
    D = sqrt(U.^2+V.^2);
    GLPF = exp(-(D.^2)./(2*(D0^2)));
end

% 4
% Я решил не фильтровать заново, а склеить готовые изображения от каждого 
% фильтра в одно, чтобы посмотреть как выглядит каждый фильтр в сравнении
pic_ILPF = imread('DIP/Lab4/Low/Ideal/pic_ILPF_250.jpg');
pic_BLPF = imread('DIP/Lab4/Low/Butter/pic_BLPF_250.jpg');
pic_GLPF = imread('DIP/Lab4/Low/Gaus/pic_GLPF_250.jpg');
pic_IHPF = imread('DIP/Lab4/High/Ideal/pic_IHPF_250.jpg');
pic_BHPF = imread('DIP/Lab4/High/Butter/pic_BHPF_250.jpg');
pic_GHPF = imread('DIP/Lab4/High/Gaus/pic_GHPF_250.jpg');

% Объединение изображений
combined_pic = cat(2, pic_ILPF, pic_BLPF, pic_GLPF, pic_IHPF, pic_BHPF, pic_GHPF);

% Сохранение объединенного изображения
imwrite(combined_pic, 'DIP/Lab4/combined_pic.jpg');

% 5
% мм крута, в методичке сказано сохранить всё по папкам только в самом
% конце, ну ладно, сделано!
end
