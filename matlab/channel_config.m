function [chan, chanInfo] = channel_config(p, cfgEHT)
%CHANNEL_CONFIG  Canal TGax del Equipo 4: Model-D, 11 m, 5.29 GHz.
%   rol B (Marco).
%
%   [chan, chanInfo] = CHANNEL_CONFIG(p, cfgEHT)
%     chan     : System object wlanTGaxChannel, listo para llamar chan(x)
%     chanInfo : info(chan) + campos anadidos a mano para trazabilidad
%
%   PROCEDENCIA. Derivado del bloque "Channel Configuration" (lineas 48-57)
%   del ejemplo oficial de MathWorks EHTSUPacketErrorRateExample, copia
%   intacta en matlab/baseline/. Diff completo en baseline/PROCEDENCIA.md.
%
%     ejemplo oficial (lin. 49-57)     este proyecto      razon
%     ---------------------------------------------------------------------
%     DelayProfile 'Model-B'        -> 'Model-D'          oficina tipica, no
%                                                         residencial: 50 ns
%                                                         de RMS delay spread,
%                                                         18 taps, 3 clusters
%     TransmitReceiveDistance 5 m   -> 11 m               el breakpoint de
%                                                         Model-D es 10 m; a
%                                                         11 m el regimen NLOS
%                                                         es inequivoco
%     ChannelBandwidth 'CBW20'      -> 'CBW80'            decision del rol A
%     (no fijadas)                  -> CarrierFrequency   5.29 GHz: centro
%                                                         legal de un canal de
%                                                         80 MHz (el defecto
%                                                         5.25 GHz es centro
%                                                         de uno de 160 MHz)
%     (no fijadas)                  -> EnvironmentalSpeed explicitas para poder
%                                      FluorescentEffect  justificarlas en el
%                                                         video; ambas iguales
%                                                         al valor por defecto
%
%   Todo lo demas se deja EXACTAMENTE como el ejemplo, incluidos los valores
%   por defecto de NormalizeChannelOutputs y NormalizePathGains: el ejemplo
%   NO los toca, y cambiarlos alteraria la potencia de salida y por tanto el
%   SNR efectivo del barrido (awgn supone potencia de senal de 0 dBW).
%
%   Fuentes citables (criterio "justificacion del modelo de canal", 15 % de
%   la rubrica):
%     [1] V. Erceg et al., "TGn Channel Models", IEEE 802.11-03/940r4, 2004.
%     [2] J. Liu, R. Porat et al., "IEEE 802.11ax Channel Model Document",
%         IEEE 802.11-14/0882r4, 2014.
%     [3] J. Liu, "TGbe Channel Model Document", IEEE 802.11-19/0719r1, 2019.
%
%   INTEGRACION. Quien llame a esta funcion debe
%   cumplir tres condiciones, o los resultados salen mal en silencio:
%
%     1. Rellenar la forma de onda con ceros antes de pasarla por el canal,
%        para absorber el retardo del filtro (7 muestras en esta config.):
%           txPad = [txWaveform; zeros(50, cfgEHT.NumTransmitAntennas)];
%     2. Llamar reset(chan) UNA VEZ POR PAQUETE, para obtener una realizacion
%        independiente. Sin reset, todos los paquetes ven el mismo canal.
%     3. NO fijar chan.Seed ni chan.RandomStream. Ver la nota mas abajo.
%
%   Ver tambien: wlanTGaxChannel, info, docs/JUSTIFICACION_CANAL.md

% --- Validacion del punto de contacto con el rol A --------------------------
% Falla ruidosamente en la integracion en vez de producir resultados
% silenciosamente erroneos.
if ~isequal(cfgEHT.ChannelBandwidth, p.chanBW)
    error('channel_config:anchoDeBandaInconsistente', ...
        ['El ancho de banda del transmisor (%s) no coincide con p.chanBW (%s). ' ...
         'Si no coinciden, la correlacion espacial y el filtrado del canal ' ...
         'quedan mal escalados.'], cfgEHT.ChannelBandwidth, p.chanBW);
end

chan = wlanTGaxChannel;
chan.DelayProfile            = p.delayProfile;              % 'Model-D'
% Las tres siguientes se derivan del OBJETO del transmisor, no de p: asi no
% pueden desincronizarse si alguien toca project_config.m a medias.
chan.NumTransmitAntennas     = cfgEHT.NumTransmitAntennas;
chan.ChannelBandwidth        = cfgEHT.ChannelBandwidth;
chan.SampleRate              = wlanSampleRate(cfgEHT);      % el ejemplo pasa la
                                                            % cadena chanBW; el
                                                            % objeto tambien
                                                            % contempla el
                                                            % sobremuestreo
chan.NumReceiveAntennas      = p.numRxAntennas;             % no lo sabe el Tx
chan.TransmitReceiveDistance = p.txRxDistance;              % 11 m
chan.LargeScaleFadingEffect  = p.largeScaleFading;          % 'None'

% --- Añadido respecto del ejemplo: parametros que queremos poder justificar --
chan.CarrierFrequency        = p.carrierFrequency;    % 5.29 GHz
chan.EnvironmentalSpeed      = p.environmentalSpeed;  % 0.089 km/h (= defecto)
% FluorescentEffect SOLO existe para Model-D y Model-E. Fijarlo con cualquier
% otro perfil hace que el System object emita un aviso de propiedad irrelevante,
% asi que se fija condicionalmente.
if any(strcmpi(p.delayProfile, {'Model-D','Model-E'}))
    chan.FluorescentEffect   = p.fluorescentEffect;   % false (= defecto)
end

% RandomStream se deja en su valor por defecto ('Global stream') a propósito.
% Con 'mt19937ar with seed' + Seed fijo, reset() reinicializa el generador y
% devuelve LA MISMA realizacion en cada paquete, lo que invalida la PER.
% El ejemplo oficial obtiene reproducibilidad sin tocar el objeto: fija el
% flujo global por punto de SNR con RandStream('combRecursive',Seed=99) y un
% Substream distinto por iteracion. Replicar ese patron en run_per_sweep.m.

% --- Trazabilidad para el video y para el rol C -----------------------------
ci = info(chan);   % campos: ChannelFilterDelay, ChannelFilterCoefficients,
                   %         PathDelays, AveragePathGains, Pathloss
chanInfo                   = ci;
chanInfo.maxDelay_ns       = ci.PathDelays(end)*1e9;
chanInfo.rmsDelaySpread_ns = localRMSDelaySpread(ci);

% El intervalo de guarda y la distancia de breakpoint se DERIVAN, no se
% escriben a mano: si el rol A cambia el GI (0.8 / 1.6 / 3.2 us) o si aqui se
% cambia el perfil, la cadena y el veredicto lo siguen automaticamente.
chanInfo.guardInterval_ns  = cfgEHT.GuardInterval*1000;
chanInfo.breakpoint_m      = localBreakpoint(p.delayProfile);
chanInfo.sinISI            = chanInfo.maxDelay_ns < chanInfo.guardInterval_ns;
chanInfo.esNLOS            = p.txRxDistance > chanInfo.breakpoint_m;

if chanInfo.sinISI
    veredictoISI = sprintf('retardo max %.0f ns < GI %.0f ns: sin ISI', ...
        chanInfo.maxDelay_ns, chanInfo.guardInterval_ns);
else
    veredictoISI = sprintf('retardo max %.0f ns >= GI %.0f ns: HAY ISI', ...
        chanInfo.maxDelay_ns, chanInfo.guardInterval_ns);
    warning('channel_config:excedeGI', ...
        ['El retardo maximo del canal (%.0f ns) alcanza o supera el intervalo ' ...
         'de guarda (%.0f ns). Habria interferencia entre simbolos, y la ' ...
         'degradacion medida ya no seria atribuible solo al desvanecimiento.'], ...
        chanInfo.maxDelay_ns, chanInfo.guardInterval_ns);
end

if chanInfo.esNLOS
    veredictoLOS = sprintf('%g m > breakpoint %g m => NLOS', ...
        p.txRxDistance, chanInfo.breakpoint_m);
else
    veredictoLOS = sprintf('%g m <= breakpoint %g m => LOS (primera derivacion Rice)', ...
        p.txRxDistance, chanInfo.breakpoint_m);
end

chanInfo.justificacion = sprintf('%s a %g m (%s). %s. %s', ...
    p.delayProfile, p.txRxDistance, veredictoLOS, veredictoISI, ...
    'IEEE 802.11-03/940r4, 802.11-14/0882r4, 802.11-19/0719r1.');
end

% ---------------------------------------------------------------------------
function ds = localRMSDelaySpread(ci)
%LOCALRMSDELAYSPREAD  info() no devuelve el RMS delay spread: se calcula aqui.
%   Importante: ci.AveragePathGains viene EN dB, no en lineal.
g   = 10.^(ci.AveragePathGains(:).'/10);
g   = g/sum(g);
tau = ci.PathDelays(:).';
ds  = sqrt(sum(g.*tau.^2) - (sum(g.*tau))^2)*1e9;   % ns
end

% ---------------------------------------------------------------------------
function dbp = localBreakpoint(perfil)
%LOCALBREAKPOINT  Distancia de breakpoint por perfil de retardo, en metros.
%   Por debajo de dBP aplican los parametros LOS (primera derivacion Rice);
%   por encima, los NLOS (Rayleigh puro).
%   Fuente: IEEE 802.11-03/940r4 (TGn Channel Models), tabla de perfiles.
switch upper(perfil)
    case {'MODEL-A','MODEL-B','MODEL-C'}, dbp = 5;
    case 'MODEL-D',                       dbp = 10;
    case 'MODEL-E',                       dbp = 20;
    case 'MODEL-F',                       dbp = 30;
    case 'NONE',                          dbp = NaN;   % sin desvanecimiento
    otherwise
        error('channel_config:perfilDesconocido', ...
              'Perfil de retardo no reconocido: %s', perfil);
end
end
