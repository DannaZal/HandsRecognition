%{
Laboratorio de Inteligencia y Visión Artificial: Alan Turing
ESCUELA POLITÉCNICA NACIONAL
Quito - Ecuador

autores: DannaZal - AlexanderMotoche
dannacr65@gmail.com
alexander.motoche@epn.edu.ec


02 April 2025
24.2.0.2833386 (R2024b) Update 4

%}

% ejecutar.m - Archivo de inicio del proyecto

clc;    % Limpiar la consola
clear;  % Limpiar variables
close all; % Cerrar cualquier figura abierta

disp('🔵 Iniciando el sistema de reconocimiento de manos y notas musicales...');

% Obtener la ruta del directorio actual (donde está "ejecutar.m")
projectPath = fileparts(mfilename('fullpath'));

% Agregar las carpetas necesarias al path de MATLAB
addpath(projectPath); % Carpeta principal
addpath(fullfile(projectPath, 'funciones')); % Funciones auxiliares
addpath(fullfile(projectPath, 'modelos')); % Modelos de IA
addpath(fullfile(projectPath, 'scripts')); % Otros scripts
addpath(fullfile(projectPath, 'GUI')); % Carpeta GUI

% Ruta completa al archivo .mlapp en la carpeta GUI
guiFilePath = fullfile(projectPath, 'GUI', 'hand_gesture_music_ui.mlapp');

% Verificar que la GUI "hand_gesture_music_ui" existe en la carpeta GUI
if exist(guiFilePath, 'file') == 2
    disp('✅ Archivo de la GUI encontrado en la carpeta GUI.');
else
    error('❌ ERROR: No se encontró "hand_gesture_music_ui.mlapp" en la carpeta GUI.');
end

% Ejecutar la aplicación GUI
disp('🚀 Iniciando la aplicación...');
hand_gesture_music_ui;  % Llamar la GUI