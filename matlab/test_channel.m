%TEST_CHANNEL  Arnes de prueba del rol B. Ejercita channel_config.m sin
%   depender de tx_config.m ni de project_config.m, que son de otros roles.
%
%   Duenno: rol B (Marco).
%
%   Construye localmente el minimo necesario -- una struct de parametros y un
%   objeto wlanEHTMUConfig -- llama a channel_config, imprime la informacion
%   de trazabilidad y genera las tres figuras del segmento de canal.
%
%   Uso:  cd matlab; test_channel
%
%   Cuando el equipo integre, channel_config recibira la p de project_config.m
%   y el cfgEHT de tx_config.m; la firma NO cambia.

clear; close all;

%% Parametros ---------------------------------------------------------------
% Los del canal son mios. Los de capa fisica son del rol A: aqui van solo
% para poder instanciar un cfgEHT coherente y sacar la tasa de muestreo.
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

% El argumento central del video: el retardo maximo cabe en el prefijo ciclico
GI_ns = p.guardInterval*1000;
if ci.maxDelay_ns < GI_ns
    fprintf('  OK: retardo maximo (%.0f ns) < GI (%.0f ns) => sin ISI\n', ...
            ci.maxDelay_ns, GI_ns);
else
    warning('Retardo maximo (%.0f ns) >= GI (%.0f ns): habria ISI', ...
            ci.maxDelay_ns, GI_ns);
end

%% Figura 1 - perfil de potencia-retardo ------------------------------------
f1 = figure('Visible','off','Position',[100 100 700 420]);
stem(ci.PathDelays*1e9, ci.AveragePathGains, 'filled');  % ya viene en dB
hold on; xline(GI_ns,'--r','LineWidth',1.5, ...
    'Label',sprintf('GI = %.1f us',p.guardInterval));
grid on;
xlabel('Retardo (ns)'); ylabel('Ganancia media de trayecto (dB)');
title(sprintf('PDP - TGax %s (RMS DS = %.0f ns)', ...
      p.delayProfile, ci.rmsDelaySpread_ns));
exportgraphics(f1, '../figuras/fig1_pdp_modelD.png', 'Resolution', 150);

%% Figura 2 - respuesta en frecuencia de una realizacion --------------------
% Se pide al canal que saque las ganancias de trayecto y se sintetiza H(f).
chan2 = clone(chan);
release(chan2);
chan2.PathGainsOutputPort = true;
Nfft = 1024;
x = [zeros(200, p.numTxAntennas); ...
     complex(randn(2000,p.numTxAntennas), randn(2000,p.numTxAntennas))/sqrt(2)];
[~, pg] = chan2(x);                       % pg: Nsamp x Npaths x Ntx x Nrx
g   = squeeze(pg(round(size(pg,1)/2), :, 1, 1)).';   % una instantanea, Tx1->Rx1
tau = ci.PathDelays(:);
fax = linspace(-chan.SampleRate/2, chan.SampleRate/2, Nfft);
H   = exp(-1j*2*pi*fax(:)*tau.') * g;

f2 = figure('Visible','off','Position',[100 100 700 420]);
plot(fax/1e6, 20*log10(abs(H)), 'LineWidth', 1.2); grid on;
xlabel('Frecuencia (MHz)'); ylabel('|H(f)| (dB)');
title(sprintf('Respuesta en frecuencia - %s, %s (una realizacion)', ...
      p.delayProfile, p.chanBW));
exportgraphics(f2, '../figuras/fig2_respuesta_frecuencia.png', 'Resolution', 150);

%% Figura 3 - comparacion de perfiles (solo PDP, SIN simular) ---------------
% El enunciado prohibe barrer escenarios de canal; esto solo grafica perfiles.
perfiles = {'Model-B','Model-D','Model-F'};
f3 = figure('Visible','off','Position',[100 100 900 300]);
for k = 1:numel(perfiles)
    c = wlanTGaxChannel;
    c.DelayProfile     = perfiles{k};
    c.ChannelBandwidth = p.chanBW;
    c.SampleRate       = wlanSampleRate(cfgEHT);
    ik = info(c);
    subplot(1,3,k);
    stem(ik.PathDelays*1e9, ik.AveragePathGains, 'filled'); hold on;
    xline(GI_ns,'--r'); grid on; xlim([0 1200]); ylim([-40 2]);
    title(perfiles{k}); xlabel('Retardo (ns)');
    if k==1, ylabel('Ganancia (dB)'); end
end
exportgraphics(f3, '../figuras/fig3_comparacion_perfiles.png', 'Resolution', 150);

fprintf('Figuras escritas en ../figuras/\n');
