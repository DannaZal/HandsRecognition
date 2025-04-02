function play_note(banderas)
    % Frecuencias de las notas según la nueva lógica
    frequencies = [
        261.63,  % Do (C) - Mano izquierda, Índice
        293.66,  % Re (D) - Mano izquierda, Medio
        329.63,  % Mi (E) - Mano izquierda, Anular
        349.23,  % Fa (F) - Mano izquierda, Meñique
        392.00,  % Sol (G) - Mano derecha, Índice
        440.00,  % La (A) - Mano derecha, Medio
        493.88,  % Si (B) - Mano derecha, Anular
        523.25   % Do subtono (C') - Mano derecha, Meñique
    ];

    duration = 0.3;  % Duración del sonido en segundos
    Fs = 8000;       % Frecuencia de muestreo
    t = 0:1/Fs:duration; % Tiempo de la señal

    y = zeros(1, length(t)); % Inicializamos la señal resultante en cero

    % Verificar si alguna bandera está activada
    if all(banderas == 0)
        return;  % Si ninguna bandera está activada, no hacemos nada
    end

    % Mapeo de banderas a frecuencias
    mapping = [1, 2, 3, 4, 5, 6, 7, 8];

    % Iteramos sobre las 8 posibles notas (4 dedos por mano)
    for i = 1:8
        if banderas(mapping(i)) == 1  % Si la bandera está activada para esta nota
            freq = frequencies(i);    % Frecuencia de la nota correspondiente
            y = y + sin(2 * pi * freq * t);  % Sumamos la señal correspondiente
        end
    end
    
    % Aplicar una envolvente de ataque y decaimiento (usando una función de coseno)
    envelope = 0.1 * (1 - cos(2 * pi * t / duration));  % Envolvente de coseno
    y = y .* envelope;  % Multiplicamos la señal por la envolvente

    % Normalizamos la señal para evitar distorsión
    y = y / max(abs(y));  % Normaliza la señal para que su amplitud sea entre -1 y 1

    % Reproducir el sonido
    sound(y, Fs);
end
