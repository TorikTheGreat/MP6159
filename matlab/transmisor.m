% =========================================================================
% ROL A - TRANSMISOR WI-FI 7 (802.11be)
% Equipo 4 - Interfaces de Comunicaciones
% =========================================================================

% --- CONFIGURACIÓN DEL TRANSMISOR (COMPATIBLE CON ROL B) ---

% 1. Crear el objeto de capa física, ajustado a CBW80 (esperado por Rol B)
cfgEHT = wlanEHTMUConfig('CBW80');

% 2. Configurar parámetros espaciales (MIMO 4x2 esperado por Rol B)
cfgEHT.NumTransmitAntennas = 4;
cfgEHT.User{1}.NumSpaceTimeStreams = 2;

% 3. Mapeo espacial obligatorio: numTx (4) ~= numSTS (2) requiere Fourier
cfgEHT.RU{1}.SpatialMapping = 'Fourier';

% 4. Configurar el esquema de modulación y codificación (MCS 10)
cfgEHT.User{1}.MCS = 10; 

% 5. Generar el payload adaptado a EHT (2000 bytes)
cfgEHT.User{1}.APEPLength = 2000;
psduLength = cfgEHT.User{1}.APEPLength;
datosMAC = randi([0 1], psduLength * 8, 1);

% 6. Generar la señal final conforme al estándar
txWaveform = wlanWaveformGenerator(datosMAC, cfgEHT);

% 7. Añadir relleno (Padding)
txPad = [txWaveform; zeros(50, cfgEHT.NumTransmitAntennas)];

disp('¡Forma de onda Tx 100% compatible generada!');

% --- VISUALIZACIÓN DE LA SEÑAL ---

% 8. Extraer la frecuencia de muestreo automáticamente
fs = wlanSampleRate(cfgEHT); 

% 9. Graficar en el dominio del tiempo (Magnitud)
figure; 
plot(abs(txPad)); 
title('Dominio del Tiempo: Magnitud de la Forma de Onda Wi-Fi 7 (4 Antenas)');
xlabel('Número de Muestra');
ylabel('Magnitud');
grid on;

% 10. Graficar en el dominio de la frecuencia (Espectro)
analizador = spectrumAnalyzer('SampleRate', fs, ...
    'Title', 'Espectro de Frecuencia de la Señal Wi-Fi 7 (CBW80)', ...
    'SpectrumType', 'Power density');
analizador(txPad);