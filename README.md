# Roles A, B y C — Transmisor, Canal y Receptor · Equipo 4, Wi‑Fi / IEEE 802.11be

**Marco Zolla y Equipo 4** · MP‑6159 Interfaces de Comunicaciones — Maestría en Electrónica, TEC

Este repositorio contiene **el trabajo del rol A (transmisor), rol B (canal) y
rol C (receptor base sin validación)**, así como el segmento de video
«Historia y estandarización». La validación de métricas y la integración final
se mantienen como trabajo del equipo completo.

---

## Entregables Roles A, B y C

> **Enunciado, rol A (Transmisor):** *«Generar una forma de onda 802.11 conforme (p. ej. 802.11be / Wi-Fi 7): ancho de banda de canal, MCS, flujos espaciales (MIMO).»*

> **Enunciado, rol B (Canal):** *«Modelar un único escenario de canal representativo (alcance
> acotado: sin barrido de sensibilidad). Resultado: modelo de canal parametrizado y
> justificado con literatura o especificación del estándar.»*
>
> **Rúbrica:** «Justificación del modelo de canal» = 15 % de la rúbrica = **7.5 % de la nota final**.

| Archivo | Qué es |
|---|---|
| `matlab/transmisor.m` | **Entregable Rol A.** Script de generación de forma de onda Tx para 802.11be. |
| **`docs/JUSTIFICACION_TRANSMISOR.md`** | **Análisis de la configuración Rol A.** |
| `matlab/channel_config.m` | **Entregable Rol B.** Firma congelada por contrato con el equipo. |
| `matlab/test_channel.m` | Arnés propio: genera un PPDU real, lo pasa por el canal y produce las figuras. |
| `matlab/verificacion_regimen.m` | Caracterización del modelo: mide dónde ocurre la transición LOS→NLOS. |
| `matlab/receptor_wifi.m` | **Entregable Rol C (solo receptor).** Detecta paquete, recorta la PPDU Rx y grafica señal recibida en tiempo para comparación rápida. |
| `figuras/` | Las tres figuras del segmento de canal. |
| **`docs/JUSTIFICACION_CANAL.md`** | **El entregable de canal que se califica (15 %).** Los tres argumentos, verificación y preguntas anticipadas. |
| `docs/PROCEDENCIA_canal.md` | Diff contra el ejemplo oficial de MathWorks + valores medidos. |
| `docs/ROL_C_RECEPTOR.md` | Guía del Rol C (receptor): alcance, ejecución y prueba rápida. |
| `docs/GUION_historia_estandarizacion.md` | Guion del video (2:57). |
| `docs/INVESTIGACION_historia_estandarizacion.md` | Dossier de investigación. |
| `docs/slides/` | Láminas Beamer del segmento. |
| `docs/enunciado.pdf` | El enunciado del proyecto, como referencia. |

---

## Cómo ejecutar

```matlab
cd matlab
test_channel            % canal + PPDU real + las tres figuras
verificacion_regimen    % (opcional) mide la transicion LOS -> NLOS
receptor_wifi           % receptor base (sin validacion), con grafica Rx en tiempo
```

Salida verificada en MATLAB R2025b (WLAN Toolbox 25.2):

```
  Perfil            : Model-D a 11 m
  Tasa de muestreo  : 80 MHz
  Derivaciones      : 35
  Retardo maximo    : 390.0 ns
  RMS delay spread  : 49.4 ns
  Retardo del filtro: 7 muestras
  OK: retardo maximo (390 ns) < GI (800 ns) => sin ISI

=== Canal aplicado a una forma de onda 802.11be ===
  Forma de onda Tx  : 7922 muestras x 4 antenas
  Señal recibida    : 7922 muestras x 2 antenas
  Duracion          : 99.0 us
```

Requiere MATLAB **R2023a o posterior** con **WLAN Toolbox** (verificado en R2025b).
Comprobación — `wlanEHTMUConfig` es la que exige soporte de 802.11be:

```matlab
cfg = wlanEHTMUConfig('CBW80');   % si instancia, hay licencia y soporte EHT
ch  = wlanTGaxChannel;
```

---

## El escenario y sus tres argumentos

**TGax Model‑D, 11 m, 5.29 GHz, sin *path loss*.**

1. **Representatividad.** Model‑D es el perfil «oficina típica» del TGn/TGax: 50 ns de RMS
   delay spread, 18 derivaciones en 3 clusters. El ejemplo oficial usa Model‑B (residencial,
   5 m); la desviación es deliberada y está documentada.
2. **Coherencia con el prefijo cíclico.** El retardo máximo de Model‑D (**390 ns medidos**)
   queda holgadamente por debajo del intervalo de guarda de 800 ns: el canal es selectivo en
   frecuencia pero el CP absorbe la dispersión, **sin ISI**. Model‑F (1050 ns) sí lo excedería.
3. **Régimen NLOS, verificado por medición.** El breakpoint de Model‑D es 10 m.
   `verificacion_regimen.m` mide dónde ocurre la transición: es en **`d ≥ 10 m`**, y el factor K
   por debajo del breakpoint sale **+3 dB**, coincidiendo con el valor documentado de Model‑D.
   Operamos a 11 m, dentro de NLOS con margen.

Fuentes citables: IEEE 802.11‑03/940r4 (TGn), 802.11‑14/0882r4 (TGax), 802.11‑19/0719r1 (TGbe).

---

## Cuatro cosas que no son obvias

1. **`info()` devuelve 35 derivaciones, no las 18 de la tabla.** El número depende del ancho de
   banda (CBW20 → 18, CBW80 → 35, ambas con 390 ns). Explicado en `docs/JUSTIFICACION_CANAL.md` §9.
2. **`info(chan).AveragePathGains` ya viene en dB.** No aplicarle `10*log10()`.
3. **No fijar `Seed` con `RandomStream='mt19937ar with seed'`** si el que valida va a llamar
   `reset()` por paquete: devolvería *la misma* realización siempre y la PER quedaría sin
   sentido estadístico. Se deja en `'Global stream'`, como el ejemplo oficial.
4. **`LargeScaleFadingEffect` va en `'None'`.** `awgn(x,snr)` supone potencia de señal de
   0 dBW; con `'Pathloss'` activo la PER saldría 1 en todo el barrido.

## Contrato con el equipo

```matlab
function [chan, chanInfo] = channel_config(p, cfgEHT)
```

`p` viene de `project_config.m` (rol D) y `cfgEHT` de `tx_config.m` (rol A).
`test_channel.m` fabrica ambos localmente para poder trabajar en paralelo.
**Esta firma no se cambia sin avisar al equipo.**
