# Rol B — Modelo de canal · Equipo 4, Wi‑Fi / IEEE 802.11be

**Marco Zolla** · MP‑6159 Interfaces de Comunicaciones — Maestría en Electrónica, TEC

Este repositorio contiene **únicamente el trabajo del rol B (canal)** y el segmento de video
«Historia y estandarización». El resto de los roles (transmisor, receptor, validación,
integración) vive en el repositorio del equipo.

---

## Mi entregable

> **Enunciado, rol B:** *«Modelar un único escenario de canal representativo (alcance
> acotado: sin barrido de sensibilidad). Resultado: modelo de canal parametrizado y
> justificado con literatura o especificación del estándar.»*
>
> **Rúbrica:** «Justificación del modelo de canal» = 15 % de la rúbrica = **7.5 % de la nota final**.

El código son ~30 líneas. **Lo que se califica es la justificación citable**, no el código.

| Archivo | Qué es |
|---|---|
| `matlab/channel_config.m` | **El entregable.** Firma congelada por contrato con el equipo. |
| `matlab/test_channel.m` | Arnés propio: ejercita el canal sin depender de archivos de otros roles. |
| `figuras/` | Las tres figuras del segmento de canal. |
| **`docs/JUSTIFICACION_CANAL.md`** | **El entregable que se califica (15 %).** Los tres argumentos, verificación y preguntas anticipadas. |
| `docs/PROCEDENCIA_canal.md` | Diff contra el ejemplo oficial de MathWorks + valores medidos. |
| `docs/GUION_historia_estandarizacion.md` | Guion del video (2:57). |
| `docs/INVESTIGACION_historia_estandarizacion.md` | Dossier de investigación. |
| `docs/slides/` | Láminas Beamer del segmento. |

---

## Cómo ejecutar

```matlab
cd matlab
test_channel
```

Salida verificada en MATLAB R2025b (WLAN Toolbox 25.2):

```
  Perfil            : Model-D a 11 m
  Tasa de muestreo  : 80 MHz
  Derivaciones      : 35
  Retardo maximo    : 390.0 ns
  RMS delay spread  : 49.4 ns
  OK: retardo maximo (390 ns) < GI (800 ns) => sin ISI
```

Requiere MATLAB **R2023a o posterior** con **WLAN Toolbox**. Comprobación:

```matlab
ch = wlanTGaxChannel;   % si esto instancia, la licencia está
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
3. **Régimen NLOS inequívoco.** El breakpoint de Model‑D es 10 m. La documentación define LOS
   para `d < dBP` y NLOS para `d > dBP`, pero **no dice qué pasa en `d = dBP`**. Operar a 11 m
   evita esa ambigüedad.

Fuentes citables: IEEE 802.11‑03/940r4 (TGn), 802.11‑14/0882r4 (TGax), 802.11‑19/0719r1 (TGbe).

---

## Tres cosas que no son obvias

1. **`info(chan).AveragePathGains` ya viene en dB.** No aplicarle `10*log10()`.
2. **No fijar `Seed` con `RandomStream='mt19937ar with seed'`** si el que valida va a llamar
   `reset()` por paquete: devolvería *la misma* realización siempre y la PER quedaría sin
   sentido estadístico. Se deja en `'Global stream'`, como el ejemplo oficial.
3. **`LargeScaleFadingEffect` va en `'None'`.** `awgn(x,snr)` supone potencia de señal de
   0 dBW; con `'Pathloss'` activo la PER saldría 1 en todo el barrido.

## Contrato con el equipo

```matlab
function [chan, chanInfo] = channel_config(p, cfgEHT)
```

`p` viene de `project_config.m` (rol D) y `cfgEHT` de `tx_config.m` (rol A).
`test_channel.m` fabrica ambos localmente para poder trabajar en paralelo.
**Esta firma no se cambia sin avisar al equipo.**
