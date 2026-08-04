# Justificación del modelo de canal — Rol B

**Equipo 4 · Wi‑Fi / IEEE 802.11be · MP‑6159 · Marco Zolla**

> **Mandato del enunciado (§3.2, rol B):** *«Modelar un único escenario de canal
> representativo (alcance acotado: sin barrido de sensibilidad). Resultado: modelo de canal
> parametrizado y justificado con literatura o especificación del estándar.»*
>
> **Consideración final (§10):** *«El escenario de canal debe tener una fuente citable (paper,
> especificación 3GPP/IEEE, o valores típicos documentados por MathWorks) — no debe elegirse
> de forma arbitraria.»*
>
> **Rúbrica:** «Justificación del modelo de canal» = 15 % de la rúbrica = **7.5 % de la nota final**.

Este documento es el entregable del rol B. El código (`../matlab/channel_config.m`) son unas
30 líneas; lo que se califica es lo que sigue.

---

## 1. El escenario

| Parámetro | Valor | Origen |
|---|---|---|
| Modelo | `wlanTGaxChannel` | WLAN Toolbox |
| Perfil de retardo | **Model‑D** | TGn/TGax — «oficina típica» |
| Distancia Tx–Rx | **11 m** | elegida respecto del breakpoint de 10 m |
| Frecuencia portadora | 5.29 GHz | centro legal de un canal de 80 MHz en U‑NII |
| Ancho de banda | CBW80 | decisión del rol A |
| MIMO | 4 Tx / 2 Rx | decisión del rol A |
| Velocidad del entorno | 0.089 km/h | valor por defecto TGax para interiores |
| *Path loss* | desactivado (`'None'`) | ver §5 |
| Efecto fluorescente | desactivado | ver §6 |

---

## 2. Primer argumento — representatividad del escenario

Model‑D es el perfil **«oficina típica»** de la familia TGn/TGax: 50 ns de dispersión de
retardo RMS, 18 derivaciones agrupadas en 3 clusters, distancia de breakpoint de 10 m.

Wi‑Fi 7 se despliega mayoritariamente en oficinas y viviendas densas, no en espacios abiertos
ni en habitaciones únicas. La definición del escenario está en el documento fuente del modelo,
no es una apreciación nuestra.

**Fuente:** V. Erceg *et al.*, «TGn Channel Models», IEEE 802.11‑03/940r4, mayo 2004, §3.

### Los seis perfiles disponibles

| Perfil | Breakpoint | RMS DS | Retardo máx. | K de Rice | Taps | Clusters | Escenario |
|---|---|---|---|---|---|---|---|
| Model‑A | 5 m | 0 ns | 0 ns | 0 dB | 1 | 1 | Desvanecimiento plano |
| Model‑B | 5 m | 15 ns | 80 ns | 0 dB | 9 | 2 | Residencial interior |
| Model‑C | 5 m | 30 ns | 200 ns | 0 dB | 14 | 2 | Residencial / oficina pequeña |
| **Model‑D** | **10 m** | **50 ns** | **390 ns** | **3 dB** | **18** | **3** | **Oficina típica** |
| Model‑E | 20 m | 100 ns | 730 ns | 6 dB | 18 | 4 | Oficina grande / bodega |
| Model‑F | 30 m | 150 ns | 1050 ns | 6 dB | 18 | 6 | Espacio interior grande |

> **Precisión sobre el factor K.** No es un parámetro del canal completo: el factor de Rice
> aplica **solo a la primera derivación del primer cluster**, y **solo cuando la distancia es
> menor que la de breakpoint** (condición LOS). Las demás derivaciones son Rayleigh, y más allá
> del breakpoint el canal es Rayleigh puro. Decir «Model‑D tiene K = 3 dB» a secas es incorrecto.

---

## 3. Segundo argumento — coherencia con el prefijo cíclico

**Este es el argumento técnico fuerte.** El criterio no es «qué perfil suena más realista», sino
**qué perfil produce el mecanismo de degradación que queremos medir, y solo ese**.

| Magnitud | Valor |
|---|---|
| Retardo máximo de Model‑D | **390 ns** (medido) |
| Intervalo de guarda elegido | **800 ns** (0.8 µs) |
| Margen | 410 ns |

Como τ_max < T_GI, el prefijo cíclico absorbe la dispersión del canal: hay **selectividad en
frecuencia pero no interferencia entre símbolos**. La degradación que medirá el rol C en la
curva de PER es atribuible al **desvanecimiento**, no a ISI.

### Y sí produce selectividad real

Con τ_rms = 49.4 ns (medido), el ancho de banda de coherencia ronda

$$B_c \approx \frac{1}{5\,\tau_{rms}} \approx 4\ \text{MHz}$$

Sobre los 80 MHz del canal eso son unos **20 desvanecimientos independientes a lo ancho de la
banda**. Es exactamente lo que muestra la figura `fig2_respuesta_frecuencia.png`. El canal es
genuinamente selectivo; no estamos simulando un caso trivial.

### Por qué no los vecinos

- **Model‑B** (80 ns) es demasiado benigno: apenas hay selectividad, el enlace se parece a AWGN
  y el ejercicio pierde interés. *(Es, sin embargo, el que usa el ejemplo oficial — ver §7.)*
- **Model‑F** (1050 ns) **excede** el intervalo de guarda de 800 ns. Ahí sí aparecería ISI, y la
  degradación medida sería una mezcla de dos causas que no podríamos separar.

**Model‑D es el punto justo, y la elección es deliberada, no cómoda.**

### Matices honestos

- La comparación τ_max vs. T_GI supone la ventana de FFT perfectamente colocada. El error real
  de sincronización de temporización consume parte de los 410 ns de margen.
- Las últimas derivaciones de Model‑F llevan muy poca potencia (visible en
  `fig3_comparacion_perfiles.png`), así que su degradación sería más suave de lo que sugiere
  «excede el intervalo de guarda».

---

## 4. Tercer argumento — régimen NLOS inequívoco

La distancia de breakpoint de Model‑D es **10 m**. La documentación de `wlanTGaxChannel` dice
que para `d < dBP` aplican los parámetros **LOS** y para `d > dBP` los **NLOS** — pero **no
define qué ocurre exactamente en `d = dBP`**.

Por eso operamos a **11 m**, apenas por encima: caemos sin ambigüedad en régimen NLOS, que es
el caso realista de oficina (el AP en el pasillo, la estación detrás de una pared) y el que
produce la selectividad en frecuencia que queremos ilustrar. A 10 m exactos el estado LOS/NLOS
sería ambiguo según la documentación, y si se resolviera como LOS tendríamos el punto *menos*
selectivo de Model‑D, justo lo contrario de lo que buscamos.

---

## 5. Por qué el *path loss* va desactivado

`LargeScaleFadingEffect = 'None'`. **No es una simplificación cómoda: activarlo sería un error.**

`awgn(x, snr)` **supone que la potencia de la señal es 0 dBW** — no la mide. Con el *path loss*
activado el canal atenúa la señal decenas de dB, y `awgn` seguiría inyectando ruido como si la
señal siguiera a 0 dBW. El SNR real sería el nominal menos la atenuación, y la PER saldría 1 en
todos los puntos del barrido. **Por eso el ejemplo oficial también usa `'None'`.**

El eje de SNR ya captura la degradación. El *path loss* se trata **cualitativamente**, que es
además lo que pide la métrica 3 del §8 del enunciado.

### El modelo, para poder explicarlo si preguntan

- Para `d ≤ dBP`: pérdida de espacio libre, exponente **n = 2**.
- Para `d > dBP`: `L(d) = L_FS(dBP) + 35·log₁₀(d/dBP)` → exponente **n = 3.5**.
- Desviación estándar del *shadow fading*: **3 dB** por debajo del breakpoint; por encima,
  **4 dB** (A/B/C), **5 dB** (D/E), **6 dB** (F).
- El TGax añade encima pérdidas por penetración de paredes y pisos.

> ⚠️ **Verificar estos coeficientes** contra 802.11‑03/940r4 §4 antes de decirlos en cámara.
> Provienen de la documentación de MathWorks y de fuentes secundarias.

---

## 6. El efecto fluorescente

`FluorescentEffect = false`. Vale mencionarlo aunque esté desactivado: el modelo TGn/TGax
incluye la modulación de amplitud que introducen las luminarias fluorescentes a 100/120 Hz, y
**solo está disponible para Model‑D y Model‑E**. Es uno de los pocos modelos de canal que
captura un artefacto de instalación real. Lo dejamos desactivado para no mezclar mecanismos de
degradación, pero conocerlo demuestra que se leyó el modelo y no solo la función.

---

## 7. Procedencia: qué cambiamos respecto del ejemplo oficial

El enunciado obliga a partir de un ejemplo oficial de MathWorks. El nuestro es
**`wlan/EHTSUPacketErrorRateExample`** (copia intacta en `proyecto_final/ejemplo_mathworks/`).

| Propiedad | Ejemplo oficial | Nuestro | |
|---|---|---|---|
| `DelayProfile` | `'Model-B'` | `'Model-D'` | desviación justificada (§2, §3) |
| `TransmitReceiveDistance` | 5 m | 11 m | desviación justificada (§4) |
| `ChannelBandwidth` | `'CBW20'` | `'CBW80'` | decisión del rol A |
| `LargeScaleFadingEffect` | `'None'` | `'None'` | **idéntico** (§5) |
| `NumTransmitAntennas` | derivado de `cfgEHT` | ídem | **adoptado del ejemplo** |
| `CarrierFrequency`, `EnvironmentalSpeed`, `FluorescentEffect` | no fijadas | explícitas | añadidos justificados |

Diff completo y errores que destapó: `PROCEDENCIA_canal.md`.

---

## 8. Alcance: lo que deliberadamente NO se hizo

El enunciado acota el rol B a **un único escenario, sin barrido de sensibilidad**. Por eso:

- **No** se simulan escenarios de canal alternativos (Model‑B, Model‑F, otras distancias).
- La figura comparativa `fig3_comparacion_perfiles.png` **solo grafica perfiles de retardo, sin
  simular** — sirve para justificar la elección sin violar la restricción.
- La sensibilidad a la degradación del canal (métrica 3 del §8) se responde
  **cualitativamente**, como el propio enunciado autoriza.

El barrido de SNR del rol C **no** viola esta restricción: la restricción aplica al escenario de
canal, no al eje de SNR, y el §4 del enunciado fija «PER / BER / throughput **vs. SNR**» como
métrica clave del equipo.

---

## 9. Verificación numérica

Ejecutando `../matlab/test_channel.m` en MATLAB R2025b (WLAN Toolbox 25.2):

| Magnitud | Medido | Documentado | |
|---|---|---|---|
| Retardo máximo | **390.0 ns** | 390 ns | ✅ |
| RMS delay spread | **49.4 ns** | 50 ns | ✅ |
| Tasa de muestreo | 80 MHz | — | coherente con CBW80 |
| Retardo del filtro de canal | 7 muestras | — | relevante para la sincronización |
| Derivaciones de `info()` | 35 | 18 | ⚠️ ver nota |

> **Nota — 35 vs. 18 derivaciones.** No es un error. Las **18** son las derivaciones del
> *modelo* (ecos físicos en 3 clusters, con retardos en el continuo). Las **35** son las de la
> *línea de retardos muestreada* que devuelve `info()`, discretizada a la tasa de muestreo: a
> 80 MHz el período es 12.5 ns y 390 / 12.5 ≈ 31 posiciones en la rejilla, más el filtro de
> interpolación. **El número depende del ancho de banda.**

---

## 10. Preguntas anticipadas

**¿Por qué Model‑D y no Model‑B, que es el del ejemplo oficial?**
Model‑B es residencial y su retardo máximo de 80 ns produce un canal casi plano sobre 80 MHz.
Queríamos un canal selectivo en frecuencia pero sin ISI, y Model‑D es el único perfil que
cumple ambas cosas con un GI de 0.8 µs.

**¿Por qué 11 m y no 10, que es el breakpoint?**
Porque la documentación define LOS para `d < dBP` y NLOS para `d > dBP`, pero no dice qué pasa
en `d = dBP`. A 11 m el régimen es inequívoco.

**¿Qué pasaría si el canal empeorara?**
Con Model‑F la dispersión de retardo se triplica y el retardo máximo (1050 ns) supera el
intervalo de guarda: aparecería ISI y, además del desplazamiento de la curva hacia SNR mayores,
un piso de error irreducible que ninguna cantidad de potencia corrige.

**¿Es legítimo simular 802.11be con un canal TGax?**
Sí. El TGbe **no definió un modelo de canal nuevo**: adoptó los del TGn/TGac/TGax. La cita es
IEEE 802.11‑19/0719r1.

**¿Por qué no activaron el *path loss*?**
Ver §5: es incompatible con `awgn(x,snr)`, que supone potencia de señal de 0 dBW.

---

## 11. Referencias

1. V. Erceg, L. Schumacher, P. Kyritsi *et al.*, «TGn Channel Models», versión 4,
   IEEE 802.11‑03/940r4, mayo 2004.
   `https://mentor.ieee.org/802.11/dcn/03/11-03-0940-04-000n-tgn-channel-models.doc`
2. J. Liu, R. Porat *et al.*, «IEEE 802.11ax Channel Model Document»,
   IEEE 802.11‑14/0882r4, 16 de septiembre de 2014.
   `https://mentor.ieee.org/802.11/dcn/14/11-14-0882-04-00ax-tgax-channel-model-document.docx`
3. J. Liu, «TGbe Channel Model Document», IEEE 802.11‑19/0719r1, 2 de mayo de 2019.
   `https://mentor.ieee.org/802.11/dcn/19/11-19-0719-01-00be-tgbe-channel-model-document.docx`
4. G. Breit, H. Sampath, S. Vermani *et al.*, «TGac Channel Model Addendum», versión 12,
   IEEE 802.11‑09/0308r12, marzo 2010.
5. J. P. Kermoal, L. Schumacher, K. I. Pedersen, P. E. Mogensen y F. Frederiksen,
   «A Stochastic MIMO Radio Channel Model with Experimental Validation»,
   *IEEE JSAC*, vol. 20, n.º 6, agosto 2002, pp. 1211–1226.
6. MathWorks, `wlanTGaxChannel` — documentación de referencia.
   `https://www.mathworks.com/help/wlan/ref/wlantgaxchannel-system-object.html`

Los documentos 1–4 son de acceso público y descargables sin cuenta desde `mentor.ieee.org`.
