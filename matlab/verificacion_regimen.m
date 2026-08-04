%VERIFICACION_REGIMEN  Caracterizacion del modelo: donde ocurre la transicion
%   LOS -> NLOS, y cuanto vale el factor K de Rice.
%
%   rol B (Marco).
%
%   NO es un barrido de sensibilidad. El escenario entregado sigue siendo UNO
%   (Model-D a 11 m). Aqui no se transmite nada -- la entrada es un vector de
%   ceros --, no se mide PER, BER ni throughput, y no se comparan rendimientos
%   entre escenarios. Solo se lee una propiedad estadistica del objeto de canal.
%   El enunciado (sec. 8, metrica 3) define el barrido prohibido como el del
%   margen de desempeno; esto caracteriza el modelo, no el enlace.
%
%   Por que hace falta: la pagina de referencia de wlanTGaxChannel dice que los
%   parametros LOS aplican para d < dBP y los NLOS para d > dBP, sin definir el
%   caso d = dBP. El ejemplo oficial, en cambio, usa exactamente d = dBP = 5 m
%   y lo rotula NLOS. Este script resuelve la discrepancia midiendola.
%
%   Metodo: en LOS la primera derivacion tiene componente especular, asi que su
%   media compleja es NO nula (Rice). En NLOS es Rayleigh y la media tiende a
%   cero. El factor K de Rice es, por definicion, la razon entre la potencia de
%   la componente especular y la de la difusa:  K = |E[h]|^2 / var(h).
%
%   Piso del estimador: con N realizaciones, una variable de media nula produce
%   |media muestral|^2 ~ var/N, es decir K_piso = -10*log10(N). Por debajo de
%   ese valor el resultado NO mide un K pequeno: significa "media compleja
%   indistinguible de cero".

clear;

%% Mismo escenario que el entregable ----------------------------------------
N       = 400;                       % realizaciones por distancia
perfil  = 'Model-D';
d_test  = [5 8 9.9 10 10.1 11 15];   % m

% Configuracion identica a la de channel_config.m, para caracterizar EL canal
% del proyecto y no uno generico con los valores por defecto.
mk = @(d) iMakeChannel(perfil, d);

K_piso = -10*log10(N);
rng(7);

fprintf('\nCaracterizacion LOS/NLOS - TGax %s, CBW80, 4x2, 5.29 GHz\n', perfil);
fprintf('N = %d realizaciones por distancia; piso del estimador = %.1f dB\n\n', N, K_piso);
fprintf('  %6s | %10s | %8s | %8s | %s\n', 'd (m)', '|E[h1]|', 'std(h1)', 'K (dB)', 'regimen');
fprintf('  %s\n', repmat('-',1,60));

K   = zeros(size(d_test));
esL = false(size(d_test));

for k = 1:numel(d_test)
    c  = mk(d_test(k));
    x  = zeros(64, c.NumTransmitAntennas);
    h1 = zeros(N, 1);
    for n = 1:N
        reset(c);                     % realizacion independiente
        [~, pg] = c(x);
        h1(n) = pg(1,1,1,1);          % primera derivacion, Tx1 -> Rx1
    end
    mu     = abs(mean(h1));
    sg     = std(h1);
    K(k)   = 10*log10(mu^2/sg^2);
    % LOS solo si el estimador supera su propio piso con holgura (10 dB)
    esL(k) = K(k) > K_piso + 10;
    if esL(k), reg = 'LOS  (Rice)'; else, reg = 'NLOS (Rayleigh, media ~ 0)'; end
    fprintf('  %6.1f | %10.4f | %8.4f | %+8.2f | %s\n', d_test(k), mu, sg, K(k), reg);
end

%% Conclusion DERIVADA de los datos, no escrita a mano -----------------------
iLOS = find(esL); iNLOS = find(~esL);
fprintf('\n--- Conclusion (derivada de la tabla) ---\n');

if isempty(iLOS) || isempty(iNLOS)
    fprintf('No se observo transicion en el rango probado.\n');
    return
end
if max(iLOS) > min(iNLOS)
    fprintf('ATENCION: los regimenes no estan separados; revisar el estimador.\n');
    return
end

ultLOS = d_test(max(iLOS));
priNLOS = d_test(min(iNLOS));
fprintf('Ultima distancia LOS : %.1f m   (K = %+.2f dB)\n', ultLOS, K(max(iLOS)));
fprintf('Primera NLOS         : %.1f m   (K = %+.2f dB, bajo el piso)\n', priNLOS, K(min(iNLOS)));
fprintf('=> La transicion ocurre en d = %.1f m, es decir el criterio es d >= dBP.\n', priNLOS);

Kmedio = mean(K(iLOS));
fprintf('K medio en LOS       : %+.2f dB\n', Kmedio);
fprintf('K documentado (%s)   : 3 dB  -> diferencia %.2f dB\n', perfil, abs(Kmedio-3));
if abs(Kmedio - 3) < 1
    fprintf('=> Coincide con el valor documentado: el modelo hace lo que la tabla promete.\n');
else
    fprintf('=> NO coincide con el valor documentado. Revisar.\n');
end

% ---------------------------------------------------------------------------
function c = iMakeChannel(perfil, d)
%IMAKECHANNEL  Mismo canal que channel_config.m, parametrizado por distancia.
c = wlanTGaxChannel;
c.DelayProfile            = perfil;
c.ChannelBandwidth        = 'CBW80';
c.SampleRate              = 80e6;
c.NumTransmitAntennas     = 4;
c.NumReceiveAntennas      = 2;
c.TransmitReceiveDistance = d;
c.CarrierFrequency        = 5.29e9;
c.EnvironmentalSpeed      = 0.089;
c.LargeScaleFadingEffect  = 'None';
c.PathGainsOutputPort     = true;
end
