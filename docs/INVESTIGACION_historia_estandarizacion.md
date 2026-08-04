# Investigación — Historia y estandarización de Wi‑Fi (IEEE 802.11)

**Para:** MP‑6159, Equipo 4 (Wi‑Fi), segmento de video de Marco (2–3 min)
**Fecha de corte de la investigación:** 3 de agosto de 2026
**Naturaleza de este documento:** red amplia. Contiene mucho más de lo que cabe en 3 minutos, a propósito. El guion reducido está en `GUION_historia_estandarizacion.md`.

## Convención de confianza

| Marca | Significado |
|---|---|
| ✅ | Verificado contra fuente primaria (IEEE‑SA, ieee802.org, FCC, sentencia judicial, comunicado oficial) |
| 🟡 | Corroborado por fuente secundaria fiable, sin primaria |
| 🟠 | Prensa especializada / vendor — solo corroboración |
| ⚠️ | **No verificado o fuentes en conflicto — NO decir en cámara sin comprobar** |

---

# Parte I — Orígenes (1971–1999)

## 1.1 La prehistoria

**ALOHAnet** (Universidad de Hawái, Norman Abramson), operativa desde **1971**. 🟡 Su aporte real a 802.11 es el **acceso aleatorio al medio**: la idea de que varias estaciones compartan un canal transmitiendo cuando tienen algo que enviar y resolviendo las colisiones a posteriori. De ahí desciende CSMA, y de CSMA desciende el CSMA/CA de 802.11.

> ⚠️ **Matiz para no exagerar:** ALOHAnet no «inventó Wi‑Fi». Lo que hereda 802.11 es el linaje conceptual del acceso aleatorio, vía Ethernet (CSMA/CD) y luego adaptado a radio (CSMA/**CA**, porque en radio no se puede detectar colisión mientras se transmite — el propio transmisor se ensordece). Esa sustitución de *Collision Detection* por *Collision Avoidance* es el punto técnico interesante, no la genealogía.

## 1.2 El acto fundacional: la FCC, mayo de 1985

**FCC Docket 81‑413**, «Amendment of the rules to authorize spread spectrum and other wideband emissions in the Public Safety and Industrial, Scientific, Medical Bands».

- **Adoptado el 9 de mayo de 1985; publicado el 24 de mayo de 1985.** ✅
- Fue la **primera autorización general del mundo para espectro ensanchado civil**. ✅
- Abrió al uso **sin licencia** las bandas ISM de **902–928 MHz, 2400–2483.5 MHz y 5725–5850 MHz**. ✅
- Impulsor: **Michael Marcus**, ingeniero de la FCC. El *Notice of Inquiry* que abrió el expediente fue aprobado el 30 de junio de 1981 bajo su dirección. ✅
- Fuente: https://www.fcc.gov/document/amendment-rules-authorize-spread-spectrum-and-other-wideband y https://marcus-spectrum.com/page2/index.html

**Por qué importa y cómo enunciarlo con precisión.** Sin espectro sin licencia no hay Wi‑Fi: cualquier fabricante puede vender un equipo sin pedir permiso a nadie ni comprar una banda. Pero la afirmación «la FCC creó Wi‑Fi» es una simplificación. Lo correcto: **la FCC creó la posibilidad económica**; el estándar tardó otros 12 años.

**El detalle que casi nadie menciona y que sí es notable:** «ISM» significa **Industrial, Scientific and Medical**. Esa banda estaba asignada a usos **no de comunicación** — el horno de microondas doméstico opera a 2.45 GHz precisamente ahí. Wi‑Fi es un **invitado** en una banda de basura electromagnética, y todo su diseño (ensanchado, salto de frecuencia, CSMA/CA, reintentos) es una respuesta a esa hostilidad. 🟡

## 1.3 Los productos propietarios previos

- **NCR / AT&T WaveLAN**, 1990: WLAN propietaria a 2.4 GHz, ~2 Mbit/s. 🟡 Es el linaje directo: NCR fue el impulsor del grupo de trabajo IEEE.
- Motorola **Altair** (18 GHz), **Proxim**, **Symbol Technologies**: soluciones incompatibles entre sí. 🟡
- El problema que motivó la estandarización: **cada fabricante tenía su propia radio y nada interoperaba**. Es exactamente el mismo problema que Ethernet había resuelto en cable.

## 1.4 El grupo de trabajo y el estándar original

- **IEEE 802.11 Working Group formado en 1990.** ✅ (ethw.org, Wikipedia)
- **Vic Hayes** (NCR → AT&T → Lucent) lo presidió **de 1990 a 2000**; se le llama «el padre del Wi‑Fi». ✅
- **IEEE Std 802.11‑1997**: 1 y 2 Mbit/s, tres capas físicas alternativas — **FHSS**, **DSSS** e **infrarrojo difuso** — y un MAC basado en **CSMA/CA** con dos funciones de coordinación: **DCF** (distribuida, la que se usa) y **PCF** (centralizada, que nunca se implementó en la práctica). ✅ en cuanto a tasas y PHYs.
- **Tardó 7 años** (1990 → 1997). Y **fracasó comercialmente**: 2 Mbit/s era menos que Ethernet 10BASE‑T, y los equipos eran caros. 🟡

## 1.5 1999: el año en que Wi‑Fi despega

Tres cosas ocurren casi simultáneamente:

1. **802.11b‑1999** — 11 Mbit/s en 2.4 GHz mediante **CCK** (HR‑DSSS). ✅
2. **802.11a‑1999** — 54 Mbit/s en 5 GHz mediante **OFDM**. ✅ Técnicamente superior, pero llegó al mercado años después: la electrónica de 5 GHz era cara y la banda no estaba disponible en todas partes.
3. **Apple AirPort** (julio de 1999): tarjeta 802.11b a **99 USD** y estación base a 299 USD en un iBook. 🟡 Es lo que convirtió a Wi‑Fi en producto de consumo masivo.

> **Punto para el video:** 802.11a y 802.11b se publicaron **el mismo año**, y ganó el técnicamente inferior. La lección de estandarización es que **el mercado no elige la mejor tecnología, elige la que llega barata y a tiempo**. OFDM tuvo que esperar a 802.11g (2003) para llegar a 2.4 GHz y recién ahí se impuso.

## 1.6 El nombre «Wi‑Fi»

- **WECA** (Wireless Ethernet Compatibility Alliance) se funda en **1999** para certificar interoperabilidad. 🟡
- El nombre «Wi‑Fi» lo acuñó la consultora de marca **Interbrand** en 1999. 🟡
- ⚠️ **«Wi‑Fi» NO significa «Wireless Fidelity».** Es un juego fonético con «Hi‑Fi», sin expansión oficial. El eslogan «The Standard for Wireless Fidelity» se usó brevemente y la propia alianza lo retiró por confuso. Es un mito muy repetido; desmentirlo en cámara queda bien.
- WECA se renombró **Wi‑Fi Alliance**. ⚠️ **Año no verificado** (se cita habitualmente 2002). No decir el año sin comprobar en wi-fi.org.

---

# Parte II — La evolución del estándar

## 2.1 Tabla maestra de enmiendas PHY

⚠️ **Las fechas de esta tabla son de Wikipedia salvo donde se indica ✅.** Antes de poner una fecha exacta en una lámina, comprobarla en `standards.ieee.org`.

| Enmienda | Nombre Wi‑Fi Alliance | Año | Banda | Ancho de canal | Modulación / PHY | Flujos máx. | Tasa PHY máx. teórica | Innovación definitoria |
|---|---|---|---|---|---|---|---|---|
| 802.11‑1997 | — | 1997 | 2.4 GHz | 22 MHz | FHSS / DSSS / IR | 1 | 2 Mbit/s | Existir |
| 802.11b | — | 1999 | 2.4 GHz | 22 MHz | HR‑DSSS (CCK) | 1 | 11 Mbit/s | Tasa utilizable + precio |
| 802.11a | — | 1999 | 5 GHz | 20 MHz | **OFDM** | 1 | 54 Mbit/s | **OFDM entra en Wi‑Fi** |
| 802.11g | — | 2003 | 2.4 GHz | 20 MHz | OFDM | 1 | 54 Mbit/s | OFDM en la banda popular |
| 802.11n | **Wi‑Fi 4** | 2009 | 2.4 + 5 GHz | 20/40 MHz | HT — **MIMO**‑OFDM | 4 | 600 Mbit/s | **MIMO** y agregación de tramas |
| 802.11ac | **Wi‑Fi 5** | 2013 | 5 GHz | hasta 160 MHz | VHT, 256‑QAM, **MU‑MIMO DL** | 8 | 6 933 Mbit/s | Multiusuario en bajada |
| 802.11ax | **Wi‑Fi 6** | 2021 | 2.4 + 5 (+6) GHz | hasta 160 MHz | HE, **OFDMA**, 1024‑QAM | 8 | 9 608 Mbit/s | **OFDMA**: eficiencia en densidad |
| 802.11be | **Wi‑Fi 7** | **pub. 22‑jul‑2025** ✅ | 2.4 + 5 + 6 GHz | hasta **320 MHz** | EHT, **4096‑QAM** | 8 (ver §2.3) | ~23 Gbit/s | **Multi‑Link Operation** |

**Cambio de eje narrativo — el mejor resumen de toda la evolución:** de 802.11‑1997 a 802.11ac el objetivo fue **velocidad pico**. Desde 802.11ax el objetivo es **eficiencia en escenarios densos** (OFDMA, BSS coloring, TWT), y con 802.11bn pasa a ser **fiabilidad y latencia**. El estándar dejó de perseguir el número grande.

## 2.2 Enmiendas no‑PHY que importan históricamente

| Enmienda | Año | Qué hizo |
|---|---|---|
| **802.11h** | 2003 | **DFS** y **TPC** — impuestas por los reguladores europeos para proteger radares en 5 GHz. Ejemplo puro de regulación entrando al estándar. |
| **802.11i** | 2004 | **WPA2 / CCMP‑AES**. Reparó el desastre de **WEP**, que fue roto públicamente en 2001. |
| **802.11e** | 2005 | **QoS** (EDCA), base de WMM. |
| 802.11k/r/v | 2008‑11 | Medición de radio, *fast roaming*, gestión de red. |
| 802.11p / bd | 2010 / 2022 | Vehicular (V2X). |
| 802.11ad / ay | 2012 / 2021 | 60 GHz (WiGig). |
| 802.11ah | 2016 | **HaLow**, sub‑1 GHz para IoT. |
| **802.11bh** | pub. **4‑jun‑2025** ✅ | Direcciones MAC aleatorizadas — identificación de dispositivo sin permitir rastreo. **Amendment 1** a 802.11‑2024. |
| **802.11bk** | pub. **5‑sep‑2025** ✅ | Posicionamiento con canales de 320 MHz. **Amendment 3**. |
| **802.11bf** | pub. **26‑sep‑2025** ✅ | **WLAN Sensing** — detección de personas/gestos/respiración usando la respuesta del canal. **Amendment 4**. PAR aprobado 25‑sep‑2020 → **5 años**. |

## 2.3 ⚠️ El punto disputado: ¿8 o 16 flujos espaciales en 802.11be?

La cifra de marketing **46 Gbit/s** para Wi‑Fi 7 supone **320 MHz × 4096‑QAM (MCS 13) × 16 flujos × GI 0.8 µs**. La aritmética es correcta: 2 882 Mbit/s por flujo × 16 = 46.1 Gbit/s.

**Pero:**
- Literatura arbitrada de 2025 leyendo la enmienda publicada (arXiv 2507.09613) afirma que **el tope es 8 flujos** → **23 Gbit/s**. Wikipedia coincide: *«8 spatial streams (initial 16 but removed from the specs in 2024)»*.
- White papers de fabricantes (p. ej. H3C, marzo 2025) siguen imprimiendo 16×16 y 46.1 Gbit/s. 🟠

**Cómo tratarlo sin arriesgarse:** presentar la aritmética, decir que la cifra de 46 Gbit/s exige 16 flujos, señalar que la literatura arbitrada de 2025 sostiene que la enmienda publicada topa en 8, y aterrizar en **el punto que nadie discute: ningún producto real se acerca**. Los clientes Wi‑Fi 7 de consumo son 2×2 (≈5.8 Gbit/s pico) y los APs tope de gama 4×4 (≈11.5 Gbit/s), y solo a ~40 dB de SNR, es decir a pocos metros y sin obstáculos.

> **Dato de oro relacionado:** el PAR de 802.11be exigía *«maximum throughput of at least 30 Gbps»* ✅. Un solo enlace 8×8 da 23 Gbit/s. **El objetivo de 30 Gbps solo se alcanza agregando enlaces con MLO** — es decir, la meta del PAR obligó a inventar la característica arquitectónica del estándar.

## 2.4 Las revisiones consolidadas (clave para entender la numeración)

| Revisión base | Aprobación / publicación | Enmiendas que absorbe |
|---|---|---|
| 802.11‑1999 | 1999 | — |
| 802.11‑2007 | 2007 | a, b, d, e, g, h, i, j |
| 802.11‑2012 | 2012 | k, n, p, r, s, u, v, w, y, z |
| 802.11‑2016 | 2016 | aa, ac, ad, ae, af |
| 802.11‑2020 | 2020 | ah, ai, aj, ak, aq |
| **802.11‑2024** | SASB **26‑sep‑2024**, **publicada 28‑abr‑2025** ✅ | ax, ay, az, ba, bb, bc, bd |

Cada revisión consolidada **reinicia el contador de enmiendas**. Sobre la base 802.11‑2024 la secuencia es: **Amd 1 = 802.11bh**, **Amd 2 = 802.11be**, **Amd 3 = 802.11bk**, **Amd 4 = 802.11bf**, y 802.11bi será Amd 5. ✅

---

# Parte III — Cómo funciona la estandarización IEEE

## 3.1 La jerarquía

**IEEE** → **IEEE Standards Association (IEEE‑SA)** → **IEEE 802 LAN/MAN Standards Committee (LMSC)** → **IEEE 802.11 Working Group** → **Task Groups** (TGbe, TGbn, …). Grupos hermanos dentro de 802: 802.1 (puentes), 802.3 (Ethernet), 802.15 (WPAN/Bluetooth), etc.

## 3.2 El ciclo de vida de una enmienda

**TIG** (Topic Interest Group) → **Study Group** → **PAR** (Project Authorization Request) → aprobación de **NesCom/SASB** → se constituye el **Task Group** → borradores sucesivos → **Letter Ballot** dentro del WG (**umbral 75 %**) → recirculaciones → **Sponsor Ballot (SA ballot)** → **RevCom** → aprobación del **IEEE‑SA Standards Board** → **publicación**.

**Dato crítico y contraintuitivo: la aprobación no es la publicación.** 802.11be fue aprobada por el Standards Board el **26 de septiembre de 2024** y publicada el **22 de julio de 2025**: **~10 meses de retraso puramente editorial** con el contenido técnico ya congelado. ✅ La prensa confunde estas dos fechas sistemáticamente.

## 3.3 802.11be como caso de estudio completo ✅

Todas las fechas verificadas contra `ieee802.org/11/Reports/802.11_Timelines.htm` y las páginas de estado de los task groups.

| Hito | Fecha |
|---|---|
| Topic Interest Group «Beyond 11ax» | mayo 2018 🟠 |
| Study Group EHT, primera reunión | septiembre 2018 |
| **PAR aprobado** | **21‑mar‑2019** |
| Primera reunión de TGbe | mayo 2019 |
| D1.0 (comment collection) | mayo 2021 |
| **D2.0 — primer letter ballot: 64 % → FALLA** (se requiere 75 %) | 4‑jul‑2022 |
| D3.0 → 80 % (pasa) | 2‑mar‑2023 |
| D4.0 → 90 % | 13‑ago‑2023 |
| D5.0 → 95 % | 16‑dic‑2023 |
| **Wi‑Fi Alliance lanza Wi‑Fi CERTIFIED 7** | **8‑ene‑2024 (CES)** |
| D5.0 — **primer sponsor ballot: 82 %** | 2‑feb‑2024 |
| D7.0 — 2ª recirculación: 97 % | 10‑ago‑2024 |
| **Aprobación RevCom + IEEE‑SA Standards Board** | **26‑sep‑2024** |
| **PUBLICADA: IEEE Std 802.11be‑2024** | **22‑jul‑2025** |

**Los números que hay que sacar de aquí:**
- **TIG → publicación = 7 años y 2 meses.**
- **PAR → publicación = 6 años y 4 meses.**
- **La certificación comercial precedió a la publicación en 18 meses y medio.** Y no solo eso: cuando la Wi‑Fi Alliance lanzó Wi‑Fi CERTIFIED 7 (8‑ene‑2024), el documento IEEE **ni siquiera había completado su primer sponsor ballot** (cerró el 2‑feb‑2024 con apenas 82 %).
- Silicio y routers Wi‑Fi 7 basados en borrador se vendían desde **principios de 2023**, ~2.5 años antes de la publicación. 🟠
- **Los primeros letter ballots fallan de rutina**: 802.11be D2.0 sacó 64 %; 802.11ax D1.0 sacó 58 %. Es proceso normal, no disfunción.

## 3.4 La numeración de enmiendas — el mejor punto docente

**802.11be/D7.0 se titulaba «Amendment 8». La norma publicada se titula «Amendment 2».** No es contradicción entre fuentes:

- El borrador D7.0 se numeraba contra la base vigente entonces, **802.11‑2020**, donde era la octava enmienda en curso.
- Al publicarse ya existía la nueva base consolidada **802.11‑2024**, y sobre ella 802.11be es la **segunda** enmienda (después de 802.11bh).

Es decir: **el número de enmienda no es una propiedad del documento, sino de su relación con la base vigente en el momento de publicar.** Si el ciclo de consolidación se cruza con el ciclo de la enmienda, el número cambia.

## 3.5 Las letras

802.11 agotó el alfabeto simple y pasó a dos letras: aa, ab, ac … ax, ay, az, ba, bb … be … bn, bp, bq, br, bt. No se usan letras confundibles (l, o). ⚠️ **No afirmar en cámara por qué se saltaron bj, bm o bs — no lo pude verificar.** La «b» de «be» y «bn» es simplemente secuencial, no significa nada.

## 3.6 IEEE vs. Wi‑Fi Alliance — la distinción crucial

| | **IEEE** | **Wi‑Fi Alliance** |
|---|---|---|
| Qué es | Organismo de normalización | Consorcio industrial |
| Qué produce | **El estándar** (documento normativo) | **Certificación de interoperabilidad** |
| Cómo se vota | Individuos | Empresas miembro |
| Nombres | 802.11be | «Wi‑Fi 7» |
| Cuándo actúa | Termina años después | Certifica sobre **borradores** |

- La **numeración generacional** (Wi‑Fi 4/5/6) la introdujo la Wi‑Fi Alliance el **3 de octubre de 2018**, junto con «Wi‑Fi 6» para 802.11ax. ✅ Asignó retroactivamente Wi‑Fi 4 a 802.11n y Wi‑Fi 5 a 802.11ac, y **nunca definió Wi‑Fi 1/2/3** — no existen oficialmente. **«Wi‑Fi 6» no es terminología IEEE.**
- **Wi‑Fi 6E** no es una enmienda IEEE. Es 802.11ax operando en 6 GHz: una etiqueta regulatoria + de certificación. ✅
- **WPA / WPA2 / WPA3** son programas de la Wi‑Fi Alliance; **802.11i / 802.11w** son las enmiendas IEEE correspondientes.
- **Certificación pre‑estándar:** el patrón «Draft N» (2007) se repitió con Wi‑Fi 6 y con Wi‑Fi 7, y se repetirá con Wi‑Fi 8. Es **estructural, no accidental**: el mercado no puede esperar 6 años.

## 3.7 Quién escribe realmente el estándar ✅

**El padrón de votantes de 802.11 es público** (CSV con nombre y afiliación): https://www.ieee802.org/11/members.html → `members-public.csv`. Instantánea del **21 de julio de 2026**: 948 filas, de las cuales **703 votantes**.

| # | Empresa | Votantes | % | Acumulado |
|---|---|---|---|---|
| 1 | **Huawei** | 63 | 9.0 % | 9.0 % |
| 2 | NXP | 38 | 5.4 % | 14.4 % |
| 3 | MediaTek | 37 | 5.3 % | 19.6 % |
| 4 | Samsung | 37 | 5.3 % | 24.9 % |
| 5 | Qualcomm | 36 | 5.1 % | 30.0 % |
| 6 | Apple | 31 | 4.4 % | 34.4 % |
| 7 | Cisco | 30 | 4.3 % | 38.7 % |
| 8 | ZTE | 28 | 4.0 % | 42.7 % |
| 9 | Lenovo | 28 | 4.0 % | 46.7 % |
| 10 | Broadcom | 27 | 3.8 % | **50.5 %** |

**Diez empresas concentran el 50.5 % de los votos**, sobre 149 afiliaciones distintas. Y el mayor bloque no es estadounidense.

**La regla formal, sin embargo, es de membresía individual** (802 LMSC WG P&P rev. 25, 15‑jul‑2022) ✅:
> «Working Group membership is by individual. […] Working Group members shall participate in the consensus process in a manner consistent with their **professional expert opinion as individuals, and not as organizational representatives**.»

Y el requisito para tener voto:
> «Credited Attendance in at least **75 % of the meeting slots** at the Sessions of the Working Group for **two out of the last four Plenary Sessions**»

**El filtro estructural:** un asiento con voto cuesta aproximadamente una semana‑persona de viaje internacional varias veces al año, indefinidamente, y **se pierde si dejás de asistir**. Por eso el padrón se parece a una lista de fabricantes de silicio.

**Regla antidominancia** (IEEE‑SA Bylaws §5.2.1.3) ✅: la acción correctiva por defecto es que **los votos de los individuos afiliados a la parte dominante se combinan en un solo voto**. El *Signs of Dominance Toolkit* de 802 pone el umbral de alerta (de bajo poder diagnóstico) en **≥25 % de los votos de una misma afiliación** — que ninguna empresa alcanza. La concentración en 802.11 es **colectiva**, no de entidad única, y la regla solo captura la segunda.

## 3.8 Patentes: LOA y RAND ✅

- El mecanismo son las **Letters of Assurance (LOA)**: el titular de una patente esencial declara ante el IEEE si licenciará (a) gratis, (b) a *Reasonable Rates*, (c) renuncia a ejercerla, o (d) **se niega**. Es irrevocable una vez aceptada.
- **El IEEE no verifica nada**: sus propios estatutos dicen que no es responsable de identificar patentes esenciales, ni de determinar su validez o esencialidad, ni de juzgar si los términos son razonables. Y **se prohíbe discutir esencialidad o validez en las reuniones**.
- **Es RAND, no FRAND.** El texto del IEEE no usa ninguna de las dos siglas: dice «*Reasonable Rates*» y «*demonstrably free of any unfair discrimination*». No hay componente «fair».
- **El episodio de 2015–2023**, muy citable: tras un cambio de política en 2015 (respaldado por una *business review letter* del DOJ), **el 77 % de las LOA de Wi‑Fi entre enero de 2016 y junio de 2019 fueron negativas** — titulares que se negaron a comprometerse. Consecuencia: **en 2019 el ANSI se negó a aprobar dos enmiendas propuestas al estándar 802.11**. El DOJ lo documentó en su carta suplementaria del **10 de septiembre de 2020**. En **2023** el IEEE revirtió parcialmente la política de 2015.
- ⚠️ **No nombrar empresas concretas** como firmantes de LOA negativas: el agregado del 77 % está documentado, los nombres no los pude verificar.

**CSIRO y la patente US 5,487,069 «Wireless LAN»** (organismo científico australiano; inventor principal **John O'Sullivan**; prioridad 1992, concedida 23‑ene‑1996) ✅. Es la patente de OFDM en interiores que quedó dentro de 802.11a/g/n/ac.
- El dato revelador, tomado de la propia sentencia del Circuito Federal (*CSIRO v. Cisco*, 3‑dic‑2015): CSIRO **presentó una LOA para 802.11a y luego se negó repetidamente** a presentarla para 802.11g, n y ac, «*después de que la patente quedó encerrada en el estándar*». ✅
- Muestra la debilidad central del sistema: **el compromiso es voluntario y por revisión de estándar**. Se puede entrar con una LOA y luego no renovarla para las enmiendas que generan el volumen.
- ⚠️ Las cifras de dinero (≈229 M por el acuerdo con las operadoras en 2012, ≈430 M totales) **no están verificadas y la moneda es ambigua** (AUD vs USD). No decirlas en cámara.

---

# Parte IV — Regulación del espectro

## 4.1 Las bandas

- **2.4 GHz (ISM)**: gratis, global, saturada. 3 canales no solapados de 20 MHz en la práctica.
- **5 GHz (U‑NII)**: la FCC asignó 300 MHz en enero de 1997 🟡. Sub‑bandas U‑NII‑1/2A/2C/3. Las de radar exigen **DFS** y **TPC** — de ahí 802.11h‑2003.
- **6 GHz (5.925–7.125 GHz)**: la FCC abrió **1200 MHz** en **abril de 2020** 🟡. Es el evento de espectro más importante de la historia de Wi‑Fi.

## 4.2 Por qué 6 GHz lo cambia todo

En 5 GHz caben ~2 canales de 160 MHz. En 6 GHz caben **siete**. **Un canal de 320 MHz no cabe en 5 GHz**: la característica estrella de Wi‑Fi 7 existe solo porque existe la banda de 6 GHz. Regulación → estándar, en línea directa.

Regímenes de potencia en 6 GHz: **LPI** (baja potencia, interior), **Standard Power con AFC** (coordinación automática de frecuencia para proteger enlaces fijos incumbentes) y **VLP** (muy baja potencia).

## 4.3 La divergencia regulatoria — muy relevante para «tendencias»

- **EE. UU.**: los 1200 MHz completos sin licencia. ✅
- **WRC‑23 (dic. 2023)**: mediante la nota 5.6A12, **6425–7125 MHz en la Región 1** quedó identificada para **IMT** (celular) *al mismo tiempo* que para WAS/RLAN (Wi‑Fi). Una doble identificación deliberada que no resuelve nada y traslada la pelea a los reguladores regionales. ✅
- **Europa, noviembre de 2025**: el **RSPG** concluyó que de los 700 MHz de la parte alta de 6 GHz, **540 MHz deberían reservarse a móvil/celular** y los 160 MHz restantes quedar en espera hasta **WRC‑27**. Informe final del CEPT previsto para **julio de 2027**. 🟠
- **Consecuencia práctica:** los canales de 320 MHz son en buena medida un fenómeno de EE. UU. / Región 2. En gran parte de Europa, el ancho de banda estrella de Wi‑Fi 7 puede no estar disponible.

---

# Parte V — Estado actual y futuro (agosto de 2026)

## 5.1 802.11bn / Wi‑Fi 8 — «Ultra High Reliability»

**El giro narrativo más importante del tema.** El PAR de TGbn ✅ **no fija ningún objetivo de tasa pico**. Fija tres:

> - «At least one mode of operation capable of **increasing throughput by 25 %** […] **in at least one SINR level (Rate‑vs‑Range)**»
> - «At least one mode […] **reducing latency by 25 % for the 95th percentile** of the latency distribution»
> - «At least one mode […] **reducing MPDU loss by 25 %** […] **especially for transitions between BSSs**»

Es decir: **el pico teórico de Wi‑Fi 8 es el mismo que el de Wi‑Fi 7** — no hay más ancho de banda que 320 MHz ni modulación superior a 4096‑QAM. Lo que mejora es cobertura, latencia de cola y pérdidas en el traspaso entre APs.

**Estado a agosto de 2026** ✅: **Draft 2.0, en letter ballot de 30 días** iniciado tras el plenario de Montreal (12–17 julio 2026). El D1.0 había **fallado con 61 %** el 6‑oct‑2025; se resolvieron ~4 800 comentarios en seis sesiones para llegar a D2.0.

**Proyección del propio WG** 🔵: D3.0 en enero 2027, sponsor ballot mayo 2027, **aprobación final mayo 2028**. ⚠️ **La prensa dice «Wi‑Fi 8 en 2028» — eso es la *aprobación*, no la publicación.** Por analogía con el retraso editorial de 802.11be, la publicación realista es **2029**.

**Característica central:** **Multi‑AP Coordination (MAPC)** — coordinación entre puntos de acceso vecinos (TDMA coordinado, reuso espacial coordinado, *beamforming* coordinado). **No estaba en 802.11be publicado**: la enmienda actual *«carece de los mensajes y mecanismos necesarios para soportar comunicación entre APs»*. Se difirió entera a 802.11bn.

## 5.2 La tensión de fondo, en una frase citable ✅

MAPC *«implicará un verdadero cambio de paradigma en Wi‑Fi, que históricamente se ha apoyado en el CSMA/CA inherentemente no determinista, para cumplir con la regulación del espectro sin licencia que obliga al uso de listen‑before‑talk»*.

**Wi‑Fi no puede escapar del LBT; solo puede coordinarse dentro de él.** Esa es la diferencia estructural con 5G y la respuesta honesta a «¿por qué Wi‑Fi no se vuelve simplemente 5G?»: **802.11 estandariza un enlace (MAC y PHY); 3GPP estandariza un sistema completo (núcleo + acceso radio).**

## 5.3 El pipeline en agosto de 2026 ✅

- **Publicado:** 802.11‑2024 (base), 802.11bh, **802.11be (Wi‑Fi 7)**, 802.11bk, **802.11bf (sensing)**.
- **En curso:** 802.11bi (privacidad, D5.0 — el más avanzado, aprobación prevista sep. 2026), 802.11mf (mantenimiento), **802.11bn (Wi‑Fi 8, D2.0)**, 802.11bp (energía ambiental), 802.11bq (mmWave integrado), 802.11br (comunicación por luz), **802.11bt (criptografía poscuántica** — el task group más nuevo, PAR 10‑sep‑2025).
- **Grupos de estudio:** **AI Offload SG** (marzo 2026, el AP como nodo de cómputo de IA) y **WIN SG** (julio 2026, *«la base de lo que será Wi‑Fi 9»*). 🟠

> **Frase de cierre:** en agosto de 2026, **Wi‑Fi 7 está publicado, Wi‑Fi 8 está en borrador 2.0 y el grupo de estudio de Wi‑Fi 9 ya existe.** El pipeline corre tres generaciones en paralelo, permanentemente.

---

# Parte VI — Material listo para usar

## 6.1 Los cinco datos con mayor rendimiento por segundo de video

1. **9 de mayo de 1985**: la FCC abre las bandas ISM sin licencia. Sin eso no hay Wi‑Fi. ✅
2. **802.11a y 802.11b se publicaron el mismo año (1999) y ganó el peor.** El mercado no premia la mejor tecnología.
3. **Wi‑Fi CERTIFIED 7 salió 18 meses antes que el estándar** — y antes incluso de que terminara el primer sponsor ballot. El IEEE estandariza; el mercado no espera.
4. **«Amendment 8» en borrador → «Amendment 2» publicada.** El número de enmienda depende de la base consolidada vigente.
5. **Wi‑Fi 8 no promete más velocidad**, promete −25 % de latencia en el percentil 95 y −25 % de pérdidas en el traspaso. El estándar cambió de objetivo.

## 6.2 Mitos a desmentir (todos aptos para cámara)

- «Wi‑Fi» **no** significa «Wireless Fidelity».
- **«Wi‑Fi 6» no es terminología IEEE** — es marca de la Wi‑Fi Alliance desde el 3‑oct‑2018. Wi‑Fi 1, 2 y 3 no existen.
- **Wi‑Fi 6E no es una enmienda**, es 802.11ax en 6 GHz.
- **Aprobación ≠ publicación** (802.11be: 10 meses de diferencia).
- Los **46 Gbit/s de Wi‑Fi 7 no los alcanza ningún producto**; un cliente 2×2 real llega a ~5.8 Gbit/s en condiciones ideales.

## 6.3 Fuentes principales

**Primarias IEEE**
- Cronogramas oficiales del WG: https://www.ieee802.org/11/Reports/802.11_Timelines.htm
- Estado de TGbe: https://www.ieee802.org/11/Reports/tgbe_update.htm
- Estado de TGbn: https://www.ieee802.org/11/Reports/tgbn_update.htm
- PAR de UHR (Wi‑Fi 8): https://www.ieee802.org/11/Reports/uhr_update.htm
- Padrón público de miembros: https://www.ieee802.org/11/members.html
- IEEE Std 802.11be‑2024: https://standards.ieee.org/ieee/802.11be/7516/
- IEEE Std 802.11‑2024: https://standards.ieee.org/ieee/802.11/10548/
- IEEE‑SA Standards Board Bylaws (patentes, cláusula 6; dominancia, §5.2.1.3): https://standards.ieee.org/wp-content/uploads/import/documents/other/sb_bylaws.pdf
- 802 LMSC WG Policies & Procedures rev. 25: https://mentor.ieee.org/802-ec/dcn/21/ec-21-0207-25-0PNP-ieee-802-lmsc-working-group-policies-and-procedures.pdf

**Regulación**
- FCC Docket 81‑413 (1985): https://www.fcc.gov/document/amendment-rules-authorize-spread-spectrum-and-other-wideband
- Historia del espectro ensanchado, Michael Marcus: https://marcus-spectrum.com/page2/index.html

**Wi‑Fi Alliance**
- Introducción de Wi‑Fi 6 y la numeración generacional (3‑oct‑2018): https://www.wi-fi.org/news-events/newsroom/wi-fi-alliance-introduces-wi-fi-6
- Wi‑Fi CERTIFIED 7 (8‑ene‑2024): https://www.wi-fi.org/news-events/newsroom/wi-fi-alliance-introduces-wi-fi-certified-7

**Académicas**
- *Wi‑Fi: Twenty‑Five Years and Counting* (arXiv 2507.09613, jul. 2025) — la mejor referencia única: https://arxiv.org/abs/2507.09613
- *IEEE 802.11be Wi‑Fi 7: Feature Summary and Performance Evaluation*: https://arxiv.org/abs/2309.15951

**Judiciales**
- *CSIRO v. Cisco*, Fed. Cir. 2015‑1066, 3‑dic‑2015: https://www.cafc.uscourts.gov/opinions-orders/15-1066.opinion.12-1-2015.1.pdf
- Carta suplementaria del DOJ al IEEE, 10‑sep‑2020: https://www.justice.gov/atr/page/file/1315291/download

**Biográficas / históricas**
- Vic Hayes: https://ethw.org/Vic_Hayes
