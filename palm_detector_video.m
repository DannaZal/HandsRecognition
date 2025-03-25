% Configurar la cámara usando webcam
cam = webcam;  % Usa la cámara predeterminada del sistema
prev_state = ones(1, 5); % Inicializar estado de los dedos (todos arriba)

while true
    % Captura una imagen de la cámara
    frame = snapshot(cam);
   
    % Procesar la imagen
    [image, imageInput] = pre_process_palm(frame);

    % Obtener las posibles cajas (boxes) de la detección
    boxes = process_palm(imageInput);
    clear imageInput;
    
    % Obtener los centros de los puntos clave
    hands = post_process_palm(image, boxes);

    if ~isempty(hands)
        [image, coord, cut] = draw_palm(image, hands);

        if ~isempty(cut)
            [cut_processed] = pre_process_landmark(cut);
            [xyz, score, type] = process_landmarks(cut_processed);

            [cut, xyz, coord, type] = post_process_landmark(cut, xyz, score, type, coord);
            

            % Dibujar landmarks y conexiones
            finimg = draw_landmark(image, cut, xyz, coord);
             % Detectar estado de los dedos y reproducir sonido
            curr_state = detect_finger_state(xyz, type);
            disp(curr_state);

            %play_note_if_finger_drops(prev_state, curr_state);
    
            % Actualizar estado previo
            %prev_state = curr_state;

            clear imageInput boxes frame hands cut_processed cut score;
        else
            finimg = frame;
        end
    else
        finimg = frame;
    end
    
    imshow(finimg);

    key = get(gcf, 'CurrentKey'); % Obtener la tecla presionada
    if strcmp(key, 'escape') % Si la tecla es ESC
        clear cam; % Limpiar la cámara
        break; % Salir del bucle
    end
end





function play_note_if_finger_drops(prev_state, curr_state)
    % Compara el estado anterior y actual para detectar cuando un dedo baja
    freqs = [261.63, 293.66, 329.63, 349.23, 392.00]; % Notas C, D, E, F, G

    for i = 1:5
        if prev_state(i) == 1 && curr_state(i) == 0
            sound(sin(2 * pi * freqs(i) * (0:1/8000:0.2)), 8000); % Generar sonido
        end
    end
end
