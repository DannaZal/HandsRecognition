function play_note(banderas)
    % Frecuencias de las 12 notas
    frequencies = [
        261.63,  % Do (C)  - 261.63 Hz
        277.18,  % Do sostenido (C#) - 277.18 Hz
        293.66,  % Re (D)  - 293.66 Hz
        311.13,  % Re sostenido (D#) - 311.13 Hz
        329.63,  % Mi (E)  - 329.63 Hz
        349.23,  % Fa (F)  - 349.23 Hz
        369.99,  % Fa sostenido (F#) - 369.99 Hz
        392.00,  % Sol (G) - 392.00 Hz
        415.30,  % Sol sostenido (G#) - 415.30 Hz
        440.00,  % La (A)  - 440.00 Hz
        466.16,  % La sostenido (A#) - 466.16 Hz
        493.88   % Si (B)  - 493.88 Hz
    ];

    duration = 0.3;  % Duración del sonido en segundos
    Fs = 8000;       % Frecuencia de muestreo
    t = 0:1/Fs:duration; % Tiempo de la señal

    y = zeros(1, length(t)); % Inicializamos la señal resultante en cero

    % Verificar si alguna bandera está activada
    if all(banderas == 0)
        return;  % Si ninguna bandera está activada, no hacemos nada
    end

    % Iteramos sobre las 12 notas
    for i = 1:12
        if banderas(i) == 1  % Si la bandera está activada para esta nota
            freq = frequencies(i);  % Frecuencia de la nota correspondiente
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
