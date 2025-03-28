function state = detect_finger_state(xyz, type)


    state = zeros(1, 12);
    
    % Índices de landmarks para puntas y bases de los dedos
    fingertips = [9, 13, 17, 21]; % Puntas de los dedos (sin el pulgar)
    basepoints = [6, 10, 14, 18]; % Bases de los dedos


    for i = 1:numel(xyz)
        temp = xyz{i}; 
        orientation = type{i}; 
        
        if size(temp, 1) < 21
            warning('No se han detectado suficientes landmarks. Retornando estado predeterminado.');
            return;
        end
        
        ref_dist = 1.05 * norm(temp(1, :) - temp(2, :));

        for j = 1:4 % Solo recorremos 4 dedos (sin el pulgar)
            fingertip = temp(fingertips(j), :);
            basepoint = temp(basepoints(j), :);
            dist_finger = norm(fingertip - basepoint);

            if dist_finger < ref_dist
                if orientation == 1  % Mano derecha
                    state(8 + j) = 1; 
                else  % Mano izquierda
                    state(5 - j) = 1; 
                end
            end
        end

        %pulgares
        thumb_base = temp(5, :); % Punta del pulgar
        thumb_prebase = temp(4, :); % Punto anterior a la punta
        thumb_inner = temp(1, :); % Punto base de la muñeca (para la comparación con el pulgar)
        
        dist_5_1 = norm(thumb_base - thumb_inner); % Distancia entre el pulgar y el punto base de la muñeca
        dist_4_1 = norm(thumb_prebase - thumb_inner); % Distancia entre el punto anterior al pulgar y la muñeca
        
        % Verificar si el pulgar está extendido hacia afuera
        thumb_middle = temp(6, :); % Punto intermedio del pulgar
        thumb_inner_point = temp(3, :); % Punto interior del pulgar
        
        dist_5_6 = norm(thumb_base - thumb_middle);
        dist_5_3 = norm(thumb_base - thumb_inner_point);
        
        % Condición para pulgar extendido hacia afuera
        if dist_5_6 > dist_5_3
            if orientation == 1  % Mano derecha
                state(7) = 1; % Pulgar extendido hacia afuera (mano derecha)
            else  % Mano izquierda
                state(6) = 1; % Pulgar extendido hacia afuera (mano izquierda)
            end
        end
        
        % Condición para pulgar cerrado
        if dist_5_1 < dist_4_1 
            if orientation == 1  % Mano derecha
                state(8) = 1; % Pulgar cerrado (mano derecha)
            else  % Mano izquierda
                state(5) = 1; % Pulgar cerrado (mano izquierda)
            end 
        end


    end
end

