function state = detect_finger_state(xyz, type)
    % Inicializar estado de 5 dedos a "arriba" (1)
    state = zeros(1, 12);
    
    % Definir índices de los landmarks para los dedos
    fingertips = [5, 9, 13, 17, 21]; % Puntas de los dedos
    basepoints = [2, 6, 10, 14, 18]; % Puntos base para comparación
    
    for i = 1:numel(xyz) 
        temp = xyz{i}; 
        orientation = type{i}; % Indica si es mano derecha (1) o izquierda (0)
        
        % Verificar que haya suficientes landmarks
        if size(temp, 1) < 21
            warning('No se han detectado suficientes landmarks. Retornando estado predeterminado.');
            return;
        end
        
        ref_dist = 1.05* norm(temp(1, :) - temp(2, :)); % Distancia referencia (muñeca a punto 2)
        
        % Evaluar cada dedo (del índice 1 al 5)
        for j = 1:5
            fingertip = temp(fingertips(j), :);
            basepoint = temp(basepoints(j), :);
            
            % Calcular distancia entre la punta y la base del dedo
            dist_finger = norm(fingertip - basepoint);
            
            % Comparar con la distancia de referencia
            if dist_finger < ref_dist
                if orientation == 1  % Mano derecha
                    state(7+ j) = 1; % Dedo doblado
                else  % Mano izquierda
                    state(6 - j ) = 1; % Invertir para la mano izquierda
                end
            end
        end

        % Verificar si el pulgar está extendido hacia afuera
        thumb_base = temp(5, :); % Punto base del pulgar
        thumb_middle = temp(6, :); % Punto intermedio del pulgar
        thumb_inner = temp(3, :); % Punto interior del pulgar

        dist_5_6 = norm(thumb_base - thumb_middle);
        dist_5_3 = norm(thumb_base - thumb_inner);
        
        if dist_5_6 > dist_5_3
            if orientation == 1  % Mano derecha
                state(7) = 1; % Pulgar extendido hacia afuera (mano derecha)
            else  % Mano izquierda
                state(6) = 1; % Pulgar extendido hacia afuera (mano izquierda)
            end
        end
    end
end
