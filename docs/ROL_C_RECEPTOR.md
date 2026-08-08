# Rol C - Receptor Wi-Fi 7 (802.11be)

Este documento describe el entregable del punto C relacionado con el receptor.

## Alcance

El script del receptor implementa solo la parte de recepcion base (sin validacion de metricas), de acuerdo con la asignacion del equipo:

- deteccion de inicio de paquete,
- recorte y alineacion de la PPDU recibida,
- salida estructurada para que otro integrante haga validacion,
- grafica simple de la senal recibida en tiempo para comparacion rapida.

No incluye calculo de PER/BER/throughput.

## Archivo del receptor

- `../matlab/receptor_wifi.m`

## Requisitos

- MATLAB R2023a o posterior.
- WLAN Toolbox con soporte EHT (802.11be).

## Como correr la prueba

Desde MATLAB:

```matlab
cd matlab
receptor_wifi
```

### Modo integrado (recomendado)

Si en el workspace ya existen estas variables del flujo del equipo:

- `cfgEHT`
- `rxWaveform`

el receptor las reutiliza directamente.

### Modo demo (automatico)

Si no existen `cfgEHT` y `rxWaveform`, el script:

1. ejecuta `transmisor.m`,
2. construye el canal con `channel_config.m`,
3. genera una `rxWaveform` de prueba,
4. aplica la recepcion base.

Esto permite probar el receptor sin depender de la integracion completa.

## Salidas utiles para integracion

El script deja una estructura `rxOut` en workspace con:

- `rxOut.fs`: frecuencia de muestreo,
- `rxOut.channelBandwidth`: ancho de banda,
- `rxOut.packetOffset`: offset detectado,
- `rxOut.packetStartSample`: inicio del paquete,
- `rxOut.packetEndSample`: fin del paquete recortado,
- `rxOut.rxPPDU`: senal recortada/alineada,
- `rxOut.numRxAntennas`: numero de antenas Rx,
- `rxOut.numSamples`: cantidad de muestras.

## Visualizacion rapida

El receptor grafica:

1. senal recibida en tiempo (parte real, antena Rx1),
2. comparacion Tx vs Rx en magnitud normalizada (si `txPad` existe en workspace).

Estas graficas son solo para verificacion visual rapida de que la cadena recibe y alinea correctamente.
