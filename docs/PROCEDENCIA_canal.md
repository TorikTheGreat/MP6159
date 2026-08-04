# Procedencia — diff contra el ejemplo oficial de MathWorks

El enunciado (§10) obliga a **partir de un ejemplo oficial de MathWorks antes de
modificar parámetros propios**. Este documento demuestra esa procedencia con el diff
real, no con una afirmación.

## El ejemplo

| | |
|---|---|
| Identificador | **`wlan/EHTSUPacketErrorRateExample`** |
| Título | *802.11be Packet Error Rate Simulation for an EHT MU Single‑User Packet Format* |
| Extraído con | `openExample('wlan/EHTSUPacketErrorRateExample','workDir',...)` |
| Release | MATLAB **R2025b** (WLAN Toolbox 25.2) |
| Archivo | `../../ejemplo_mathworks/EHTSUPacketErrorRateExample.m` — 12 958 bytes, **sin modificar** |

> ⚠️ El identificador que figuraba en el plan (`EHTMUPacketErrorRateExample`) era una
> conjetura y **estaba mal**. El correcto es `EHTSUPacketErrorRateExample`.

**No editar el ejemplo.** Vive en `proyecto_final/ejemplo_mathworks/`, fuera de este repo, y es la prueba de procedencia.

---

## Configuración del ejemplo (verbatim, líneas 32–57)

```matlab
chanBW = 'CBW20';
cfgEHT = wlanEHTMUConfig(chanBW);
cfgEHT.User{1}.APEPLength = 1e3;
numTx = 2;
numRx = 2;
cfgEHT.NumTransmitAntennas = numTx;
cfgEHT.User{1}.NumSpaceTimeStreams = numTx;   % NSTS = numTx  =>  SpatialMapping "direct"
mcs = 13;

tgaxChannel = wlanTGaxChannel;
tgaxChannel.DelayProfile = 'Model-B';
tgaxChannel.NumTransmitAntennas = cfgEHT.NumTransmitAntennas;
tgaxChannel.NumReceiveAntennas = numRx;
tgaxChannel.TransmitReceiveDistance = 5;
tgaxChannel.ChannelBandwidth = chanBW;
tgaxChannel.LargeScaleFadingEffect = 'None';
fs = wlanSampleRate(chanBW);
tgaxChannel.SampleRate = fs;
```

---

## Diff del canal (`channel_config.m`)

| Propiedad | Ejemplo | Nuestro | Tipo |
|---|---|---|---|
| `DelayProfile` | `'Model-B'` | `'Model-D'` | **desviación justificada** |
| `TransmitReceiveDistance` | `5` | `11` | **desviación justificada** |
| `ChannelBandwidth` | `'CBW20'` | `'CBW80'` | desviación (decisión del rol A) |
| `NumTransmitAntennas` | `cfgEHT.NumTransmitAntennas` | ídem | **adoptado del ejemplo** |
| `NumReceiveAntennas` | `numRx` | `p.numRxAntennas` | equivalente |
| `LargeScaleFadingEffect` | `'None'` | `'None'` | idéntico |
| `SampleRate` | `wlanSampleRate(chanBW)` | `wlanSampleRate(cfgEHT)` | equivalente (misma tasa) |
| `CarrierFrequency` | *no fijada* (5.25 GHz) | `5.29e9` | añadido justificado |
| `EnvironmentalSpeed` | *no fijada* | `0.089` (= defecto) | añadido explícito |
| `FluorescentEffect` | *no fijada* | `false` (= defecto) | añadido explícito |

---

## Errores que el diff destapó

Estos son cambios que la comparación con el fuente real forzó. **Ninguno era detectable
leyendo solo la documentación.**

### 1. `NormalizeChannelOutputs` / `NormalizePathGains` — atribución falsa y error de 3 dB

El plan afirmaba que fijar `NormalizeChannelOutputs = false` y `NormalizePathGains = true`
era «la combinación que usa el ejemplo oficial».

**El ejemplo no fija ninguna de las dos** (`grep -c` → 0 coincidencias). La afirmación
venía de un resumen automático de la página de ayuda que las inventó.

No es cosmético. `NormalizeChannelOutputs` vale `true` por defecto y normaliza la salida
por el número de antenas receptoras. Ponerlo en `false` con 2 antenas Rx cambia la potencia
de salida en un factor 2, y como `awgn(x,snr)` **supone potencia de señal de 0 dBW**, eso
desplaza el SNR efectivo unos **3 dB**. La curva de PER habría salido corrida respecto de
la del ejemplo, sin ningún aviso.

**Corregido:** ambas líneas eliminadas. Se usan los valores por defecto, como el ejemplo.

### 2. Faltaba el relleno de ceros antes del canal

El ejemplo añade cola al paquete antes de pasarlo por el canal (línea 159):

```matlab
txPad = [tx; zeros(50,cfgEHT.NumTransmitAntennas)];
```

Sin eso, el retardo del filtro de canal trunca el final del paquete. **Añadido** a
`main_wifi7_link.m`; hay que replicarlo en `run_per_sweep.m`.

### 3. El patrón de aleatoriedad del ejemplo es mejor que el del plan

El plan proponía un `rng(2026)` global único. El ejemplo hace algo más fino (líneas 140–142):

```matlab
stream = RandStream('combRecursive',Seed=99);
stream.Substream = isnr;          % un substream por punto de SNR
RandStream.setGlobalStream(stream);
```

Reproducible **y** compatible con `parfor`, porque cada punto de SNR tiene su propio
substream independiente. El objeto de canal se queda en `'Global stream'` y `reset()`
por paquete saca realización nueva — confirma la corrección del plan de no usar
`'mt19937ar with seed'`. **Adoptar este patrón en `run_per_sweep.m`.**

---

## Lo que el diff confirmó

- **`psduLength(cfgEHT)`** es la función correcta (línea 155), no `getPSDULength`.
- **`wlanEHTOFDMInfo('EHT-Data',cfgEHT)`** existe y es el nombre correcto (línea 131).
  En el plan estaba marcado como no confirmado.
- **`convertSNR(snr,"snrsc","snr",FFTLength=...,NumActiveSubcarriers=...)`** — sintaxis exacta.
- **El orden de la cadena de recepción del plan §4.3 es correcto**, verificado línea por línea:
  `wlanPacketDetect` (169) → `wlanCoarseCFOEstimate` (178) → `wlanSymbolTimingEstimate` (183)
  → `wlanFineCFOEstimate` (198) → `wlanEHTDemodulate` (203) → `wlanEHTLTFChannelEstimate` (204)
  → `wlanEHTDemodulate` (208) → `wlanEHTTrackPilotError` (211) → `wlanEHTDataNoiseEstimate` (214)
  → `wlanEHTEqualize` (222) → `wlanEHTDataBitRecover` (225).
- **La trampa del `SpatialMapping`**: el ejemplo pone `NumSpaceTimeStreams = numTx`
  precisamente para quedarse en `"direct"`. Nuestro 4 Tx / 2 STS **exige** `"fourier"`.

---

## Parámetros del barrido, para comparar

| | Ejemplo | Nuestro |
|---|---|---|
| MCS | 13 (4096‑QAM, 5/6) | 10 (1024‑QAM, 3/4) |
| `snrRange` | `37:5:57` | `30:2:46` — **calibrar** |
| APEP length | 1000 bytes | 2000 bytes |
| MIMO | 2×2, 2 STS | 4×2, 2 STS |

El `snrRange` del ejemplo está ajustado a MCS 13 en CBW20. Con MCS 10 el umbral baja, pero
con Model‑D y 4×2 se mueve otra vez. **Correr tres puntos gruesos (25, 35, 45 dB) antes de
lanzar el barrido completo.**


---

## Valores medidos (MATLAB R2025b, WLAN Toolbox 25.2)

Ejecutando `matlab/test_channel.m`:

| Magnitud | Medido | Documentado | |
|---|---|---|---|
| Retardo máximo | **390.0 ns** | 390 ns | ✅ coincide |
| RMS delay spread | **49.4 ns** | 50 ns | ✅ coincide |
| Tasa de muestreo | 80 MHz | — | coherente con CBW80 |
| Retardo del filtro de canal | 7 muestras | — | a tener en cuenta en la sincronización |
| Derivaciones que devuelve `info()` | **35** | 18 | ⚠️ ver abajo |

**El argumento del prefijo cíclico queda verificado numéricamente:** 390 ns < 800 ns.

### ⚠️ Por qué `info()` dice 35 derivaciones y la documentación dice 18

No es un error. Son dos cosas distintas y conviene tener la respuesta lista:

- **18** son las derivaciones del *modelo* TGn/TGax — los ecos físicos agrupados en 3 clusters,
  con retardos arbitrarios en el continuo.
- **35** son las derivaciones de la *línea de retardos muestreada* que devuelve `info()`, ya
  discretizada a la tasa de muestreo. A 80 MHz el período de muestreo es 12.5 ns, y
  390 / 12.5 ≈ 31 posiciones en la rejilla; el filtro de interpolación añade unas pocas más.

Es decir: el número que devuelve `info()` **depende del ancho de banda**. Con CBW20 (20 MHz,
período 50 ns) saldrían muchas menos. Si alguien pregunta en el video por qué la figura del PDP
tiene más puntos que las 18 de la tabla, esa es la respuesta.
