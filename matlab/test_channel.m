%TEST_CHANNEL  Arnes de prueba del rol B. Ejercita channel_config.m sin
%   depender de tx_config.m ni de project_config.m, que son de otros roles.
%
%   rol B (Marco).
%
%   Construye localmente el minimo necesario -- una struct de parametros y un
%   objeto wlanEHTMUConfig --, genera una forma de onda 802.11be REAL con
%   wlanWaveformGenerator, la APLICA al canal, y produce las tres figuras del
%   segmento de canal.
%
%   Uso:  cd matlab; test_channel
%
%   Cuando el equipo integre, channel_config recibira la p de project_config.m
%   y el cfgEHT de tx_config.m; la firma NO cambia.

clear; close all;

%% Parametros ---------------------------------------------------------------
% Los del canal son mios. Los de capa fisica son del rol A: aqui van solo
% para poder instanciar un cfgEHT coherente y generar una forma de onda.
p.chanBW             = 'CBW80';
p.numTxAntennas      = 4;
p.numRxAntennas      = 2;
p.numSTS             = 2;
p.spatialMapping     = "fourier";   % obligatorio: numTx (4) ~= sum(NSTS) (2)
p.mcs                = 10;
p.apepLength         = 2000;
p.guardInterval      = 0.8;
p.ehtLTFType         = 4;

p.delayProfile       = 'Model-D';
p.txRxDistance       = 11;          % m, por encima del breakpoint (10 m)
p.carrierFrequency   = 5.29e9;      % Hz
p.environmentalSpeed = 0.089;       % km/h
p.largeScaleFading   = 'None';
p.fluorescentEffect  = false;

p.rngSeed            = 2026;
rng(p.rngSeed);

%% Configuracion minima de Tx (solo para alimentar al canal) -----------------
cfgEHT = wlanEHTMUConfig(p.chanBW);
cfgEHT.NumTransmitAntennas         = p.numTxAntennas;
cfgEHT.RU{1}.SpatialMapping        = p.spatialMapping;
cfgEHT.User{1}.NumSpaceTimeStreams = p.numSTS;
cfgEHT.User{1}.MCS                 = p.mcs;
cfgEHT.User{1}.APEPLength          = p.apepLength;
cfgEHT.GuardInterval               = p.guardInterval;
cfgEHT.EHTLTFType                  = p.ehtLTFType;

%% El entregable del rol B ---------------------------------------------------
[chan, ci] = channel_config(p, cfgEHT);

fprintf('\n=== Canal del Equipo 4 ===\n');
fprintf('  Perfil            : %s a %g m\n', p.delayProfile, p.txRxDistance);
fprintf('  Tasa de muestreo  : %.4g MHz\n', chan.SampleRate/1e6);
fprintf('  Derivaciones      : %d\n', numel(ci.PathDelays));
fprintf('  Retardo maximo    : %.1f ns\n', ci.maxDelay_ns);
fprintf('  RMS delay spread  : %.1f ns\n', ci.rmsDelaySpread_ns);
fprintf('  Retardo del filtro: %d muestras\n', ci.ChannelFilterDelay);
fprintf('  %s\n\n', ci.justificacion);

% El argumento central: el retardo maximo cabe en el prefijo ciclico
if ci.sinISI
    fprintf('  OK: retardo maximo (%.0f ns) < GI (%.0f ns) => sin ISI\n', ...
            ci.maxDelay_ns, ci.guardInterval_ns);
end

%% APLICAR el canal a una forma de onda 802.11be real ------------------------
% El enunciado (sec. 5.4, rol B) pide "aplicar" el modelo de canal, y la
% sec. 10 obliga a generar la forma de onda con las funciones del toolbox.
txPSDU     = {randi([0 1], psduLength(cfgEHT)*8, 1)};
txWaveform = wlanWaveformGenerator(txPSDU, cfgEHT);

% Ceros al final para absorber el retardo del filtro de canal (el ejemplo
% oficial hace lo mismo). Sin esto se trunca la cola del paquete.
txPad = [txWaveform; zeros(50, cfgEHT.NumTransmitAntennas)];

release(chan);
chan.PathGainsOutputPort = true;   % queremos tambien las ganancias de trayecto
reset(chan);                       % realizacion nueva
[rxWaveform, pathGains] = chan(txPad);

fprintf('\n=== Canal aplicado a una forma de onda 802.11be ===\n');
fprintf('  PSDU              : %d bits\n', numel(txPSDU{1}));
fprintf('  Forma de onda Tx  : %d muestras x %d antenas\n', size(txWaveform,1), size(txWaveform,2));
fprintf('  Con relleno       : %d muestras (50 ceros de cola)\n', size(txPad,1));
fprintf('  Señal recibida    : %d muestras x %d antenas\n', size(rxWaveform,1), size(rxWaveform,2));
fprintf('  Duracion del PPDU : %.1f us\n', size(txWaveform,1)/chan.SampleRate*1e6);
fprintf('  Ganancias         : %s (muestras x trayectos x Tx x Rx)\n', mat2str(size(pathGains)));

%% Figura 1 - perfil de potencia-retardo ------------------------------------
GI_ns = ci.guardInterval_ns;
f1 = figure('Visible','off','Position',[100 100 700 420]);
stem(ci.PathDelays*1e9, ci.AveragePathGains, 'filled');  % ya viene en dB
hold on; xline(GI_ns,'--r','LineWidth',1.5, ...
    'Label',sprintf('GI = %.1f us',p.guardInterval), ...
    'LabelHorizontalAlignment','left');
grid on; xlim([-20 GI_ns*1.15]);
xlabel('Retardo (ns)'); ylabel('Ganancia media de trayecto (dB)');
title(sprintf('PDP - TGax %s (RMS DS = %.0f ns, %d derivaciones)', ...
      p.delayProfile, ci.rmsDelaySpread_ns, numel(ci.PathDelays)));
exportgraphics(f1, '../figuras/fig1_pdp_modelD.png', 'Resolution', 150);

%% Figura 2 - respuesta en frecuencia de la realizacion REAL ----------------
% Sintetizada a partir de las ganancias de trayecto de la transmision de
% arriba: H(f) = sum_p g_p * exp(-j*2*pi*f*tau_p).
idx = round(size(pathGains,1)/2);                 % instantanea a mitad del paquete
Nfft = 1024;
tau  = ci.PathDelays(:);
fax  = linspace(-chan.SampleRate/2, chan.SampleRate/2, Nfft).';
E    = exp(-1j*2*pi*fax*tau.');                   % Nfft x Npaths

f2 = figure('Visible','off','Position',[100 100 760 430]);
hold on;
for rx = 1:p.numRxAntennas
    g = squeeze(pathGains(idx, :, 1, rx)).';      % Tx 1 -> Rx 'rx'
    plot(fax/1e6, 20*log10(abs(E*g)), 'LineWidth', 1.1, ...
         'DisplayName', sprintf('Tx1 \\rightarrow Rx%d', rx));
end
grid on; legend('Location','south'); xlim([-40 40]);
xlabel('Frecuencia (MHz)'); ylabel('|H(f)| (dB)');
title(sprintf('Respuesta en frecuencia del canal - %s, %s (una realizacion)', ...
      p.delayProfile, p.chanBW));
exportgraphics(f2, '../figuras/fig2_respuesta_frecuencia.png', 'Resolution', 150);

%% Figura 3 - comparacion de perfiles (solo PDP, SIN simular el enlace) -----
% El enunciado prohibe barrer escenarios de canal: esto NO simula ningun
% enlace, solo grafica los perfiles de retardo nominales para justificar la
% eleccion. Cada perfil se situa por encima de SU breakpoint para que los tres
% objetos esten en el mismo regimen NLOS que nuestro escenario; esto NO cambia
% el PDP que devuelve info() (que es el promedio normalizado), pero evita que
% el rotulo diga NLOS mientras el objeto esta configurado en LOS.
perfiles = {'Model-B','Model-D','Model-F'};
distancias = [6 11 31];        % breakpoint + 1 m  (5, 10, 30)
f3 = figure('Visible','off','Position',[100 100 950 320]);
for k = 1:numel(perfiles)
    c = wlanTGaxChannel;
    c.DelayProfile            = perfiles{k};
    c.ChannelBandwidth        = p.chanBW;
    c.SampleRate              = wlanSampleRate(cfgEHT);
    c.TransmitReceiveDistance = distancias(k);    % NLOS en los tres casos
    ik = info(c);
    subplot(1,3,k);
    stem(ik.PathDelays*1e9, ik.AveragePathGains, 'filled'); hold on;
    xline(GI_ns,'--r','LineWidth',1.2); grid on;
    xlim([0 1200]); ylim([-40 2]);
    title(sprintf('%s (%g m, NLOS)', perfiles{k}, distancias(k)));
    xlabel('Retardo (ns)');
    if k==1, ylabel('Ganancia media (dB)'); end
end
sgtitle('PDP nominal - sin simulacion de enlace');
exportgraphics(f3, '../figuras/fig3_comparacion_perfiles.png', 'Resolution', 150);

fprintf('\nFiguras escritas en ../figuras/\n');
