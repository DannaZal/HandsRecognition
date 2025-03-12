function image = draw_landmark(original, cut, xyz, coord) 
    % Número de imágenes
    num_images = numel(cut);

    % Definir conexiones entre landmarks (según la estructura anatómica de la mano)
    connections = [ ...
        1, 2; 2, 3; 3, 4; % Pulgar
        5, 6; 6, 7; 7, 8; % Índice
        9, 10; 10, 11; 11, 12; % Medio
        13, 14; 14, 15; 15, 16; % Anular
        17, 18; 18, 19; 19, 20; % Meñique
        0, 5; 0, 9; 0, 13; 0, 17; % Conexiones base dedos
        5, 9; 9, 13; 13, 17; % Conexiones entre bases
    ];

    % Recorrer cada imagen
    for i = 1:num_images
        % Extraer el conjunto de landmarks para la imagen i
        temp = xyz{i};  % Matriz 21x3 de coordenadas de los landmarks
        [cap_height, cap_width, ~] = size(cut{i});  % Dimensiones de la imagen

        % Coordenadas de referencia (cx, cy) para la rotación
        row = coord(i, :); % Fila con coordenadas de referencia
        cx = row(3);  % Punto de rotación X
        cy = row(4);  % Punto de rotación Y
        degree = row(5);  % Ángulo de rotación en grados
        cap_width = row(6);
        cap_height = row(7);

        % Matriz de rotación
        theta = deg2rad(degree);  % Convertir a radianes
        R = [cos(theta), -sin(theta); sin(theta), cos(theta)];  % Matriz de rotación 2D

        % Almacenar coordenadas rotadas
        rotated_landmarks = zeros(21, 2);

        for j = 1:21
            % Coordenadas (x, y) de cada landmark, escaladas a la imagen original
            landmark_x = temp(j, 1) * cap_width + row(1);
            landmark_y = temp(j, 2) * cap_height + row(2);

            % Aplicar rotación
            rotated_coords = R * [landmark_x - cx; landmark_y - cy] + [cx; cy];

            % Almacenar coordenadas rotadas
            rotated_landmarks(j, :) = rotated_coords;

            % Dibujar el punto en la imagen
            original = insertShape(original, 'FilledCircle', [rotated_coords(1), rotated_coords(2), 5], 'Color', 'blue', 'Opacity', 1);
        end

        % Dibujar conexiones entre los puntos clave
        for k = 1:size(connections, 1)
            idx1 = connections(k, 1) + 1; % Ajuste de índice (MATLAB usa 1-based index)
            idx2 = connections(k, 2) + 1;

            % Obtener coordenadas de los dos puntos a conectar
            point1 = rotated_landmarks(idx1, :);
            point2 = rotated_landmarks(idx2, :);

            % Dibujar la línea
            original = insertShape(original, 'Line', [point1(1), point1(2), point2(1), point2(2)], 'Color', 'green', 'LineWidth', 2);
        end
    end

    % Devolver la imagen con puntos y conexiones
    image = original;
end
