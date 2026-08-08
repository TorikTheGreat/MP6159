% =========================================================================
% ROL C - RECEPTOR Wi-Fi 7 (802.11be) - SOLO RECEPCION (sin validacion)
% Equipo 4 - Interfaces de Comunicaciones
% =========================================================================
%
% Uso recomendado (integracion con el equipo):
%   1) Ejecutar transmisor y canal para obtener: cfgEHT y rxWaveform
%   2) Ejecutar este script
%
% Este script hace:
%   - Deteccion basica de inicio de paquete
%   - Alineacion y recorte de la PPDU recibida
%   - Salida de una estructura rxOut util para quien valida (PER/BER)
%   - Grafica simple en tiempo para comparacion rapida

clearvars -except cfgEHT rxWaveform txWaveform txPad chan p
close all;

%% 0) Modo demo si no hay senal de entrada integrada -----------------------
if ~exist('cfgEHT','var') || ~exist('rxWaveform','var')
    fprintf(['No se encontro una entrada integrada (cfgEHT + rxWaveform).\n' ...
             'Ejecutando un flujo demo con transmisor y canal del repositorio...\n\n']);

    % Reusar el transmisor existente del rol A
    transmisor;

    % Parametros del canal compatibles con test_channel.m
    p.chanBW             = 'CBW80';
    p.numRxAntennas      = 2;
    p.delayProfile       = 'Model-D';
    p.txRxDistance       = 11;
    p.carrierFrequency   = 5.29e9;
    p.environmentalSpeed = 0.089;
    p.largeScaleFading   = 'None';
    p.fluorescentEffect  = false;

    [chan, ~] = channel_config(p, cfgEHT);

    release(chan);
    reset(chan);
    rxWaveform = chan(txPad);
end

%% 1) Parametros basicos de recepcion --------------------------------------
fs = wlanSampleRate(cfgEHT);
cbw = cfgEHT.ChannelBandwidth;

% Deteccion simple de inicio de paquete con la primera antena Rx
pktOffset = wlanPacketDetect(rxWaveform(:,1), cbw);
if isempty(pktOffset)
    warning(['No se detecto inicio de paquete con wlanPacketDetect. ' ...
             'Se asume inicio en la muestra 1.']);
    pktOffset = 0;
end

pktStart = pktOffset + 1;

% Longitud esperada de la PPDU para recorte rapido
ind = wlanFieldIndices(cfgEHT);
ppduLen = ind.EHTData(2);
pktEnd = min(pktStart + ppduLen - 1, size(rxWaveform,1));

rxPPDU = rxWaveform(pktStart:pktEnd, :);

% Normalizacion de amplitud para facilitar etapas posteriores
scale = max(abs(rxPPDU(:)));
if scale > 0
    rxPPDU = rxPPDU ./ scale;
end

%% 2) Salida del receptor para integracion con validacion -------------------
rxOut = struct();
rxOut.fs = fs;
rxOut.channelBandwidth = cbw;
rxOut.packetOffset = pktOffset;
rxOut.packetStartSample = pktStart;
rxOut.packetEndSample = pktEnd;
rxOut.rxPPDU = rxPPDU;
rxOut.numRxAntennas = size(rxPPDU,2);
rxOut.numSamples = size(rxPPDU,1);

fprintf('=== Receptor Wi-Fi (solo recepcion) ===\n');
fprintf('Ancho de banda           : %s\n', cbw);
fprintf('Frecuencia de muestreo   : %.2f MHz\n', fs/1e6);
fprintf('Inicio detectado         : muestra %d\n', pktStart);
fprintf('Fin de PPDU (recortado)  : muestra %d\n', pktEnd);
fprintf('Tamano rxPPDU            : %d x %d (muestras x antenas Rx)\n\n', ...
    rxOut.numSamples, rxOut.numRxAntennas);

%% 3) Grafica simple para comparacion rapida --------------------------------
t_us = (0:rxOut.numSamples-1).'/fs*1e6;

figure('Name','Receptor Wi-Fi - Senal recibida en tiempo', 'Color','w');
plot(t_us, real(rxOut.rxPPDU(:,1)), 'LineWidth', 1.0);
grid on;
xlabel('Tiempo (us)');
ylabel('Amplitud (parte real, Rx1)');
title('Senal recibida en el tiempo (PPDU recortada y normalizada)');

% Si existe Tx en workspace, mostrar comparacion visual rapida de magnitudes
if exist('txPad','var')
    txLen = min(size(txPad,1), size(rxWaveform,1));
    txMag = abs(txPad(1:txLen,1));
    rxMag = abs(rxWaveform(1:txLen,1));

    txMag = txMag ./ max(txMag + eps);
    rxMag = rxMag ./ max(rxMag + eps);
    t2_us = (0:txLen-1).'/fs*1e6;

    figure('Name','Comparacion rapida Tx/Rx', 'Color','w');
    plot(t2_us, txMag, 'LineWidth', 1.0);
    hold on;
    plot(t2_us, rxMag, 'LineWidth', 1.0);
    grid on;
    xlabel('Tiempo (us)');
    ylabel('Magnitud normalizada');
    legend('Tx (antena 1)', 'Rx (antena 1)', 'Location', 'best');
    title('Comparacion visual rapida de magnitud en tiempo');
end
