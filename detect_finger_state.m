function state = detect_finger_state(xyz, type)
    persistent prev_state; % Estado previo de los dedos
    
    if isempty(prev_state)
        prev_state = zeros(1, 12); % Inicializar si es la primera vez
    end

    state = zeros(1, 12);
    
    % Índices de landmarks para puntas y bases de los dedos
    fingertips = [9, 13, 17, 21]; % Puntas de los dedos (sin el pulgar)
    basepoints = [6, 10, 14, 18]; % Bases de los dedos

    % Frecuencias asignadas por mano y dedo
    frequencies_left = [261.63, 293.66, 329.63, 349.23]; % Do, Re, Mi, Fa
    frequencies_right = [392.00, 440.00, 493.88, 523.25]; % Sol, La, Si, Do subtono
    duration = 0.2; % Duración del sonido
    Fs = 8000; % Frecuencia de muestreo

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
    end

    % Comparar con el estado anterior y reproducir sonido si cambia
    for k = 1:4 % Solo recorrer los 4 dedos (sin el pulgar)
        if state(8 + k) ~= prev_state(8 + k) && state(8 + k) == 1  % Mano derecha
            play_note(frequencies_right(k), duration, Fs);
        elseif state(5 - k) ~= prev_state(5 - k) && state(5 - k) == 1  % Mano izquierda
            play_note(frequencies_left(k), duration, Fs);
        end
    end

    prev_state = state; % Actualizar el estado previo
end

% Función para generar y reproducir la nota musical
function play_note(freq, duration, Fs)
    t = 0:1/Fs:duration;
    y = sin(2 * pi * freq * t);
    sound(y, Fs);
    pause(duration); % Pausa para evitar sonidos superpuestos
end
