function state = detect_finger_state(xyz, type)
    % Inicializar el estado con ceros
    state = zeros(1, 8);

    % Índices de landmarks para puntas y bases de los dedos
    fingertips = [9, 13, 17, 21]; % Puntas de los dedos (Índice, Medio, Anular, Meñique)
    basepoints = [6, 10, 14, 18]; % Bases de los dedos correspondientes

    for i = 1:numel(xyz)
        temp = xyz{i};
        orientation = type{i};

        % Verificar si tenemos suficientes landmarks
        if size(temp, 1) < 21
            warning('No se han detectado suficientes landmarks. Retornando estado predeterminado.');
            return;
        end

        % Distancia de referencia entre muñeca y base del pulgar
        ref_dist = 1.05 * norm(temp(1, :) - temp(2, :));

        for j = 1:4 % Recorremos solo los cuatro dedos relevantes (sin el pulgar)
            fingertip = temp(fingertips(j), :);
            basepoint = temp(basepoints(j), :);
            dist_finger = norm(fingertip - basepoint);

            % Verificar si el dedo está flexionado o extendido
            if dist_finger < ref_dist
                if orientation == 1  % Mano derecha
                    state(4 + j) = 1; % Guardar en posiciones 5 a 8
                else  % Mano izquierda
                    state(5 - j) = 1; % Guardar en posiciones 1 a 4
                end
            end
        end
    end
end
