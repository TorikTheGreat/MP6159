# Guion — «Historia y estandarización» (Marco)

**Proyecto:** MP‑6159, Equipo 4 — Wi‑Fi / IEEE 802.11be
**Base:** `INVESTIGACION_historia_estandarizacion.md` · **Láminas:** `slides_historia.tex`
**Requisito del enunciado (§7.1):** *«Origen del estándar, organismo responsable, evolución de versiones»* — 2 a 3 min
**Revisión 2** — tras verificación adversaria de contenido y de encaje en el video

## Auditoría de duración (contada, no estimada)

| Bloque | Palabras | @150 pal/min |
|---|---|---|
| Introducción del video | 41 | 0:16 |
| 1 · Origen | 116 | 0:46 |
| 2 · Evolución | 110 | 0:44 |
| 3 · Organismo responsable | 82 | 0:33 |
| 4 · El proceso | 79 | 0:32 |
| 5 · Cierre | 15 | 0:06 |
| **Total** | **443** | **2:57** |

> A 130 pal/min esto sale **3:24**. El ritmo de 150 no es opcional: hay que ensayarlo con cronómetro. **Si hay que recortar**, el bloque 4 completo sale sin romper nada (−32 s) y deja el segmento en 2:25, que es lo que presupuesta el plan §6.3.

---

## [0:00 – 0:16] Introducción del video

> **Lámina 1 — portada**

Somos el Equipo 4 y nuestro tema es Wi‑Fi: **IEEE 802.11be**, o **Wi‑Fi 7**. El video cubre historia y estandarización, arquitectura, formato de trama, aplicaciones, tendencias, la evidencia de nuestra simulación en MATLAB, y un cierre con preguntas anticipadas. Arranco yo.

---

## [0:16 – 1:02] Bloque 1 — El origen

> **Lámina 2 — línea de tiempo 1985 → 1999**

Wi‑Fi nace de una decisión **regulatoria**, no técnica. El **9 de mayo de 1985** la FCC estadounidense autorizó el espectro ensanchado **sin licencia** en las bandas ISM, entre ellas la de 2.4 gigahertz. Es lo que permite vender un equipo de radio sin comprar espectro.

El IEEE formó el **grupo de trabajo 802.11 en 1990**, presidido por **Vic Hayes**. El primer estándar llegó **siete años después, en 1997**: hasta dos megabits por segundo. Fracasó — era más lento que el Ethernet de entonces.

En **1999** se publicaron dos enmiendas **el mismo año**: **802.11a**, con OFDM a 54 megabits en 5 gigahertz, y **802.11b**, con once en 2.4. Ganó la lenta, porque llegó antes **al mercado**: el radio de 5 gigahertz era caro.

---

## [1:02 – 1:46] Bloque 2 — La evolución de versiones

> **Lámina 3 — tabla de enmiendas**

La evolución tiene **dos grandes etapas**. La primera persigue **velocidad pico**: en 2003, **802.11g** lleva OFDM a 2.4 gigahertz; en 2009, **802.11n** introduce **MIMO** y multiplica la tasa por más de diez — es la inflexión más importante de la serie; en 2013, **802.11ac** suma canales de 160 megahertz y 256‑QAM.

La segunda **cambia de objetivo**. **802.11ax**, de 2021, busca **eficiencia en escenarios densos** con OFDMA, y llega a la banda de **6 gigahertz** que la FCC abrió en 2020: sin esos 1200 megahertz nuevos no existirían los canales de **320 megahertz**. Y en **802.11be** lo verdaderamente nuevo no es el 4096‑QAM, sino **Multi‑Link Operation**, que Marcelo explicará.

---

## [1:46 – 2:19] Bloque 3 — El organismo responsable

> **Lámina 4 — IEEE vs. Wi‑Fi Alliance, dos columnas**

¿Quién es el responsable? Dos organizaciones que suelen confundirse. El **IEEE escribe la norma**. La **Wi‑Fi Alliance no escribe ninguna**: es un consorcio industrial que **certifica interoperabilidad** y pone los nombres comerciales. «Wi‑Fi 7» **no es terminología IEEE** — la numeración por generaciones se inventó el **3 de octubre de 2018** y se asignó hacia atrás hasta 802.11n.

Un detalle del IEEE: **formalmente se vota como individuo**, no como empresa. En la práctica, **diez compañías concentran la mitad** del padrón de votantes.

---

## [2:19 – 2:51] Bloque 4 — El proceso

> **Lámina 5 — cronología de 802.11be**

Y el proceso es **lento**. 802.11be tuvo su autorización de proyecto en **marzo de 2019** y se publicó el **22 de julio de 2025**: **seis años y cuatro meses**. El mercado no espera: la Wi‑Fi Alliance **certificó Wi‑Fi 7 en enero de 2024**, dieciocho meses antes de que el estándar existiera.

Un detalle revelador: el borrador se titulaba **«Enmienda 8»** y la norma publicada, **«Enmienda 2»** — porque en el medio salió una nueva revisión consolidada del estándar base.

---

## [2:51 – 2:57] Bloque 5 — Cierre

> *(sin lámina propia: se queda la 5, o se pasa a la de **Referencias** durante el relevo)*

El pipeline sigue abierto, pero eso lo cierra Diego. Le paso la palabra a **Marcelo**, con la arquitectura.

---

# Notas de producción

## Correcciones aplicadas en la revisión 2

Verificación adversaria de contenido: **los 16 datos comprobados salieron correctos**. Los cambios vinieron del revisor de *encaje*:

| # | Problema | Corrección |
|---|---|---|
| 1 | 498 palabras = **3:19**, no 2:55 | Reescrito a 443 = 2:57, con auditoría contada por bloque |
| 2 | «Evolución de versiones» (mandato del §7.1) era el bloque más débil: faltaba **802.11n / MIMO**, 802.11g y la apertura de 6 GHz | Bloque 2 reescrito: ahora es el más largo del segmento |
| 3 | Exceso de procedimiento de balotaje frente a evolución técnica, para audiencia de electrónica | Eliminada la votación fallida del 64 %; bloque 4 recortado de 44 s a 32 s |
| 4 | **Colisión con las «Tendencias» de Diego**: el cierre sobre Wi‑Fi 8 y Wi‑Fi 9 es literalmente el contenido que el §7.1 le asigna a él | Cierre reducido a un puente sin contenido; eliminada la lámina del pipeline |
| 5 | Explicar MLO invade el segmento de arquitectura de Marcelo | Se nombra la característica y se le pasa explícitamente («que Marcelo explicará») |
| 6 | La intro enumeraba **cinco** secciones; el §7.1 manda **seis** + preguntas anticipadas de la rúbrica | Intro corregida a la lista completa |
| 7 | «Ganó la lenta… llegó antes» contradecía «publicadas el mismo año» | Ahora: «llegó antes **al mercado**», con la razón (costo del radio de 5 GHz) |
| 8 | «Se vota como individuo» a secas suena ingenuo ante quien conoce 802.11 | Añadido el contraste: formalmente individuos, en la práctica diez empresas = mitad del padrón |
| 9 | «Y **por eso** Wi‑Fi 1, 2 y 3 no existen» era un *non sequitur* | Sustituido por el hecho verificable: la asignación retroactiva llegó solo hasta 802.11n |
| 10 | «La primera autorización general **del mundo**» — superlativo sin cita puntual | Eliminado el superlativo |
| 11 | «PAR» y «letter ballot» sin glosa | «Autorización de proyecto»; eliminada la referencia al balotaje |
| 12 | Ninguna fuente en pantalla, incoherente con el rigor del resto del proyecto | Las láminas 2–5 llevan pie de fuente |

## Qué se dejó fuera deliberadamente

Está todo en el dossier. Sirve para **preguntas anticipadas** o si sobra tiempo:

- ALOHAnet y el linaje del acceso aleatorio; por qué CSMA/**CA** y no CSMA/CD.
- WEP roto en 2001 y la reparación con 802.11i‑2004.
- Las revisiones consolidadas (802.11‑2007/2012/2016/2020/2024) en detalle.
- La pelea regulatoria por la parte alta de 6 GHz entre Wi‑Fi y celular (WRC‑23; Europa, 2025).
- Patentes: *Letters of Assurance*, RAND, el caso CSIRO.
- 802.11bf (*sensing*), publicada en septiembre de 2025.
- El mito de que «Wi‑Fi» significa *Wireless Fidelity* (no significa nada).

## Reglas que me impuse

1. **Solo datos verificados contra fuente primaria.** Nada marcado ⚠️ en el dossier entró aquí.
2. **Ninguna cifra de tasa pico de Wi‑Fi 7.** Los 46 Gbit/s están disputados (8 vs. 16 flujos espaciales) y ningún producto se acerca. Si alguien pregunta, la respuesta está en el dossier §2.3.
3. **Ningún nombre de empresa** en lo de patentes; sí el agregado del padrón de votantes, que es público y verificable.
4. **Fechas exactas solo donde están verificadas:** 9‑may‑1985, 1990, 1997, 1999, 2003, 2009, 2013, 2020, 2021, 3‑oct‑2018, mar‑2019, ene‑2024, 22‑jul‑2025.

## Sobre las láminas

`slides_historia.tex` → 7 páginas: **5 de contenido + 2 de referencias** (16 entradas en estilo IEEE). Compila con `pdflatex slides_historia.tex` dos veces; sin dependencias fuera de una instalación estándar de TeX Live.

Cada lámina de contenido lleva **pie de fuente con citas numeradas** —`[1]`, `[6]–[9]`, etc.— que remiten a la bibliografía del final. Las de referencias **no se narran**: quedan disponibles para que el profesor pause, y sirven de respaldo si alguien pide una fuente en el segmento de preguntas.

## Cómo grabarlo

- Ritmo objetivo **150 palabras/min**. Cronometrar cada bloque por separado antes de grabar seguido.
- Las **cifras y las fechas** son el contenido: decirlas despacio. El texto conectivo puede ir rápido.
- Coordinar con Marcelo para que no repita la definición de Multi‑Link Operation, y con Diego para que Wi‑Fi 8 y Wi‑Fi 9 sean suyos y solo suyos.
