function [finimg, curr_state] = process_video_frame(frame)
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

            % En la GUI, `play_note(curr_state)` será llamado desde otro lugar.
        else
            finimg = frame;
            curr_state = zeros(1, 8); % Si no se detecta la mano, todos los dedos están "abajo"
        end
    else
        finimg = frame;
        curr_state = zeros(1, 8); % Sin manos detectadas
    end
end
