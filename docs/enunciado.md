## Asignación de Proyecto Extraclase

Simulación de Interfaces de Comunicaciones en MATLAB / Simulink

## 1. Objetivo del proyecto

Diseñar, simular y validar el enlace de comunicaciones (transmisor–canal–receptor) de una interfaz real de la industria, utilizando los toolboxes especializados de MATLAB/Simulink, y compartir el trabajo mediante un video explicativo de 15-20 minutos.

El video es el único entregable y debe demostrar tanto el dominio técnico (resultados de simulación) como la comprensión conceptual del estándar (historia, arquitectura, tendencias).

## 2. Alcance y herramientas

El proyecto cubre seis interfaces, de las categorías alambrada, inalámbrica de área local/personal, y celular:

- Interconexión de alta velocidad: PCIe, USB, Ethernet — mediante SerDes Toolbox, con gen- eración de modelos IBIS-AMI compatibles con la industria.

- Redes inalámbricas de área local/personal: Wi-Fi y Bluetooth — mediante WLAN Toolbox y Bluetooth Toolbox, con formas de onda conformes a IEEE 802.11 y a la especificación Bluetooth SIG.

- Red celular: 5G NR — mediante 5G Toolbox, con modelos de canal 3GPP (CDL/TDL).

Se requiere licencia completa de MATLAB con acceso a los toolboxes mencionados. Todo equipo debe partir de un ejemplo oficial de MathWorks correspondiente a su tecnología antes de modificar parámetros propios.

## 3. Estructura de equipos y roles

Los 27 estudiantes del curso se organizarán en 6 equipos de 4 ó 5 personas. El tamaño del equipo depende de la carga conceptual de la tecnología asignada (ver sección 4).

## 3.1 Equipos de 4 personas (PCIe, USB, Bluetooth)

| Rol | Responsabilidad | Resultado |
| --- | --- | --- |
| A — Transmisor | Configurar la señal según el están- | Script/modelo que genera |
|   | dar: modulación, parámetros de | la señal conforme al están- |
|   | capa física, formato de trama. | dar. |
| B — Canal | Modelar un único escenario de canal | Modelo de canal |
|   | representativo (alcance acotado: sin | parametrizado y justi- |
|   | barrido de sensibilidad). | ficado con literatura o |
|   |   | especificación del estándar. |


| Rol | Responsabilidad | Resultado |   |
| --- | --- | --- | --- |
| C — Receptor / Vali- | Medir métricas de desempeño y com- | Métricas de conformi- |   |
| dación | parar contra los límites que exige el | dad (eye | diagram, |
|   | estándar. | BER/PER/BLER, EVM, |   |
|   |   | según la tecnología). |   |

## 3.2 Equipos de 5 personas (Ethernet, Wi-Fi, 5G NR)

| Rol | Responsabilidad | Resultado |
| --- | --- | --- |
| A — Transmisor | Configurar la señal según el están- | Script/modelo que genera |
|   | dar: modulación, parámetros de | la señal conforme al están- |
|   | capa física, formato de trama. | dar. |
| B — Canal | Modelar un único escenario de canal | Modelo de canal |
|   | representativo (alcance acotado: sin | parametrizado y justi- |
|   | barrido de sensibilidad). | ficado con literatura o |
|   |   | especificación del estándar. |
| C — Receptor / Vali- | Medir métricas de desempeño y com- | Métricas de conformi- |
| dación | parar contra los límites que exige el | dad (eye diagram, |
|   | estándar. | BER/PER/BLER, EVM, |
|   |   | según la tecnología). |
| D — Integración téc- | Apoyo directo a A/B/C: ensambla | Modelo integrado funcio- |
| nica | el flujo Tx-Canal-Rx a medida que | nando de principio a fin. |
|   | cada pieza está lista, sin esperar al fi- |   |
|   | nal. Necesario porque estas tres tec- |   |
|   | nologías tienen mayor carga concep- |   |
|   | tual (MIMO, numerología, cálculo de |   |
|   | COM). |   |

## 4. Asignación de temas por equipo

| Equipo Tecnología Tamaño Toolbox |   |   | Métrica clave |
| --- | --- | --- | --- |
| 1 | PCIe | 4 | SerDes Toolbox Eye diagram, COM, mod- |
|   |   |   | elo IBIS-AMI |
| 2 | USB | 4 | SerDes Toolbox Eye diagram, BER |
| 3 | Ethernet | 5 | SerDes Toolbox Máscara IEEE 802.3, |
|   |   |   | COM |
| 4 | Wi-Fi | 5 | WLAN Tool- PER / BER / throughput |
|   |   |   | box vs. SNR |
| 5 | Bluetooth | 4 | Bluetooth BER, interferencia de |
|   |   |   | Toolbox WLAN |
| 6 | 5G NR | 5 | 5G Toolbox BLER, throughput vs. nu- |
|   |   |   | merología |

## 5. Descripción detallada por equipo


## 5.1 Equipo 1 — PCIe (4 personas, SerDes Toolbox)

- Rol A (Transmisor): Configurar el transmisor en la app SerDes Designer para PCIe 6.0/7.0: modulación PAM4, tasa de símbolo, pre-énfasis.

- Rol B (Canal): Modelar un único canal de interconexión representativo (parámetros-S de una traza de PCB, pérdida de inserción y crosstalk) con ecualización (CTLE/DFE/FFE).

- comparar el margen contra los requisitos de conformidad de PCI-SIG. Rol C (Receptor/Validación): Generar diagrama de ojo y curva de bathtub para ese escenario;

Punto de partida oficial (MathWorks): https://www.mathworks.com/help/serdes/getting-start ed-with-serdes-toolbox.html — incluye diseños de referencia (white-box examples) explícitos para PCIe. [URL 🔗](https://www.mathworks.com/help/serdes/getting-started-with-serdes-toolbox.html)

## 5.2 Equipo 2 — USB (4 personas, SerDes Toolbox)

- Rol A (Transmisor): Configurar el transmisor para USB4 Versión 2.0: modulación PAM3, arqui- tectura de túnel de datos.

- Rol B (Canal): Modelar un único escenario de cable USB-C representativo (longitud, atenuación, reflexión por conector).

- Rol C (Receptor/Validación): Medir BER y eye diagram para ese escenario.

Punto de partida oficial (MathWorks): https://www.mathworks.com/help/serdes/getting-started [URL 🔗](https://www.mathworks.com/help/serdes/getting-started-with-serdes-toolbox.html)

-with-serdes-toolbox.html PAM3). [URL 🔗](https://www.mathworks.com/help/serdes/getting-started-with-serdes-toolbox.html)

— el mismo grupo de diseños de referencia incluye USB4 (modulación [URL 🔗](https://www.mathworks.com/help/serdes/getting-started-with-serdes-toolbox.html)

## 5.3 Equipo 3 — Ethernet (5 personas, SerDes Toolbox)

- Rol A (Transmisor): Configurar el transmisor para una velocidad Ethernet específica (p. ej. 100GBASE o 400GBASE, PAM4).

- Rol B (Canal): Modelar un único canal de backplane o cable de cobre representativo (Cat6a / twinax).

- Rol C (Receptor/Validación): Validar contra la máscara de conformidad IEEE 802.3 correspon- diente y reportar el Channel Operating Margin (COM).

- Rol D (Integración técnica): Apoyo directo a A/B/C para ensamblar el flujo completo dentro del tiempo disponible.

Punto de partida oficial (MathWorks): https://www.mathworks.com/help/serdes/ug/architect ural-112g-pam4-adc-based-serdes-model.html — modelo arquitectural 112G PAM4 conforme a IEEE 802.3ck. [URL 🔗](https://www.mathworks.com/help/serdes/ug/architectural-112g-pam4-adc-based-serdes-model.html)

## 5.4 Equipo 4 — Wi-Fi (5 personas, WLAN Toolbox)

- Rol A (Transmisor): Generar una forma de onda 802.11 conforme (p. ej. 802.11be / Wi-Fi 7): ancho de banda de canal, MCS, flujos espaciales (MIMO).

- Rol B (Canal): Aplicar un único modelo de canal WLAN representativo (multipath, desvanec-


imiento).

- Rol C (Receptor/Validación): Medir PER/BER/throughput para ese escenario y compararlo contra el enlace ideal.

- Rol D (Integración técnica): Apoyo directo a A/B/C, en particular en la configuración MIMO, que añade complejidad adicional.

Punto de partida oficial (MathWorks): https://www.mathworks.com/help/wlan/802.11be-end-to-e nd-simulation.html — ejemplos de simulación de enlace completo para 802.11be (Wi-Fi 7), soportado desde MATLAB R2023a. [URL 🔗](https://www.mathworks.com/help/wlan/802.11be-end-to-end-simulation.html)

## 5.5 Equipo 5 — Bluetooth (4 personas, Bluetooth Toolbox)

- Rol A (Transmisor): Generar formas de onda BR/EDR y LE, configurando modulación y codifi- cación.

- Rol B (Canal): Modelar un único escenario de canal, incluyendo interferencia de WLAN en la banda de 2.4 GHz.

- Rol C (Receptor/Validación): Medir tasa de error y evaluar el impacto de la interferencia, con y sin mitigación (frequency hopping).

Punto de partida oficial (MathWorks): https://www.mathworks.com/help/bluetooth/ug/bluetoot h-br-data-and-voice-communication-with-wlan-signal-interference.html — ejemplo oficial de coexistencia Bluetooth BR/EDR con interferencia de WLAN y frequency hopping adaptativo (AFH). [URL 🔗](https://www.mathworks.com/help/bluetooth/ug/bluetooth-br-data-and-voice-communication-with-wlan-signal-interference.html)

## 5.6 Equipo 6 — 5G NR (5 personas, 5G Toolbox)

- Rol A (Transmisor): 15/30/60 kHz), canal físico PDSCH. Generar una forma de onda 5G NR: numerología (subcarrier spacing

- Rol B (Canal): Aplicar un único modelo de canal CDL o TDL (3GPP) representativo.

- Rol C (Receptor/Validación): Medir BLER y throughput para ese escenario.

- Rol D (Integración técnica): Apoyo directo a A/B/C; la estructura de recursos 3GPP (grid tiempo-frecuencia) tiene la curva de aprendizaje más pronunciada de las seis tecnologías.

Punto de partida oficial (MathWorks): https://www.mathworks.com/help/5g/ug/nr-pdsch-through put.html — ejemplo de referencia estándar de MathWorks para medir throughput/BLER de PDSCH con canales CDL o TDL, conforme a 3GPP. [URL 🔗](https://www.mathworks.com/help/5g/ug/nr-pdsch-throughput.html)

## 6. Cronograma sugerido (4 semanas)

| Semana Actividad |   |
| --- | --- |
| 1 | A/B/C aprenden el toolbox haciendo (sin semana dedicada solo a |
|   | familiarización), partiendo directamente del ejemplo oficial de Math- |
|   | Works. La integración y el video (guión sobre historia, arquitectura y |
|   | tendencias del estándar que no dependen de resultados de simulación) |
|   | arrancan en paralelo. |


| Semana Actividad |   |
| --- | --- |
| 2 | A/B/C terminan sus bloques individuales (transmisor, canal, recep- |
|   | tor). En los equipos de 5, el rol de Integración técnica ensambla el |
|   | flujo en cuanto cada pieza está lista, sin esperar al final. |
| 3 | Validación con el escenario de canal seleccionado y generación de las |
|   | figuras de conformidad (eye diagram, BLER, etc.). |
| 4 | Cierre de resultados, grabación de la evidencia de simulación, edición |
|   | final y entrega del video. |

## 7. Video explicativo (único entregable)

Al no haber reporte escrito, el video de 15-20 minutos es el único medio donde el equipo demuestra tanto el dominio técnico (resultados de simulación) como la comprensión conceptual del estándar asignado.

## 7.1 Contenido obligatorio y distribución de tiempo sugerida

| Sección | Tiempo Contenido |
| --- | --- |
| Historia y estandarización | 2-3 min Origen del estándar, organismo responsable, |
|   | evolución de versiones. |
| Arquitectura y stack de ca- | 3-4 min Dónde vive el estándar en el modelo de capas; |
| pas | bloques funcionales clave. |
| Formato de trama / estruc- | 3-4 min Frame, PPDU o estructura de slot según cor- |
| tura de datos | responda; qué campos lleva y por qué. |
| Aplicaciones reales | 2 min Casos de uso actuales de la industria para esta |
|   | tecnología. |
| Tendencias | 2 min Hacia dónde va el estándar: próxima gen- |
|   | eración, retos abiertos. |
| Evidencia de la simulación | 4-5 min Resultados de MATLAB/Simulink (eye dia- |
| propia | gram, BLER, etc.) del escenario de canal tra- |
|   | bajado. |

## 7.2 Logística de entrega

- El video se entrega al profesor a través de una carpeta brindada por él.

- Formato libre de producción (grabación de pantalla con narración es suficiente); no se requiere edición profesional.

- Todos los grupos tendrán acceso al video de los demás para efectos de la coevaluación.

## 8. Métricas normalizadas (mencionar en el video)

Independientemente de la tecnología, cada equipo debe mencionar en su video estas cuatro métricas normalizadas, para que un espectador pueda comparar los seis videos entre sí:

- 1. Margen de desempeño / EVM — Eye height/width para las interfaces alambradas; SNR requerido para alcanzar un BER objetivo en las inalámbricas y celular.


- 2. Tasa de error bajo el escenario simulado — BER, PER o BLER según corresponda a la tecnología.

- 3. Sensibilidad esperada a la degradación del canal — Aunque el alcance acotado no permite un barrido completo, el equipo debe explicar cualitativamente qué esperaría que pasara con el margen si el canal empeorara.

- 4. Eficiencia espectral — Bits/s/Hz. Aplica a 5G NR, Wi-Fi y Bluetooth; no aplica de forma directa a las interfaces alambradas.

## 9. Evaluación

El profesor evaluará el trabajo de cada equipo utilizando la siguiente rúbrica:

| Criterio | Peso Descripción |
| --- | --- |
| Implementación técnica | 30% El modelo (Tx/canal/Rx) funciona, usa las |
| correcta | APIs del toolbox correctamente y produce |
|   | resultados físicamente coherentes con el es- |
|   | tándar simulado. |
| Uso de métricas y con- | 20% Se reportan las métricas correctas para la |
| formidad con el estándar | tecnología (eye diagram/COM, PER/BER, |
|   | EVM, BLER, etc.) y se comparan contra |
|   | límites reales del estándar cuando existen. |
| Justificación del modelo de | 15% El escenario de canal elegido está fundamen- |
| canal | tado en literatura o especificaciones del es- |
|   | tándar, no elegido arbitrariamente. |
| Video (contenido concep- | 35% Cubre con claridad historia, arquitec- |
| tual + evidencia de simu- | tura/stack, formato de trama, aplicaciones, |
| lación) | tendencias y evidencia de simulación, dentro |
|   | del rango de 15-20 minutos, con participación |
|   | de todos los integrantes y el segmento de pre- |
|   | guntas anticipadas. |

La nota obtenida constituirá el 50% de la nota final del proyecto.

Cada equipo hará una evaluación del trabajo de los otros equipos en una escala de 1 a 5 (1: inaceptable; 2: básico; 3: suficiente; 4: muy bueno; 5: sobresaliente ) y la hará llegar al profesor vía correo electrónico a más tardear el 20/08/2026, 11:45pm. La nota promedio obtenida por cada grupo constituirá el 30% de su nota final del proyecto.

Cada equipo hará una evaluación del desempeño de sus integrantes en una escala de 1 a 5 (1: nulo; 2: deficiente; 3: aceptable; 4: bueno; 5: excelente ) y la hará llegar al profesor vía correo electrónico a más tardear el 20/08/2026, 11:45pm. La nota promedio obtenida por cada integrante del grupo constituirá el 20% de su nota final del proyecto.

## 10. Consideraciones finales

- Toda forma de onda debe generarse mediante las funciones/apps del toolbox correspondiente, no reconstruida manualmente desde cero, salvo en los casos donde el toolbox no ofrezca soporte nativo.


- El escenario de canal debe tener una fuente citable (paper, especificación 3GPP/IEEE, o valores típicos documentados por MathWorks) — no debe elegirse de forma arbitraria.

## 11. Referencias — ejemplos oficiales de MathWorks

Todos los enlaces siguientes fueron verificados directamente en la documentación oficial de MathWorks como punto de partida obligatorio para cada equipo:

- 1. Equipos 1-2 (PCIe/USB): https://www.mathworks.com/help/serdes/getting-started-wit h-serdes-toolbox.html [URL 🔗](https://www.mathworks.com/help/serdes/getting-started-with-serdes-toolbox.html)

- 2. Equipo 3 (Ethernet, IEEE 802.3ck): https://www.mathworks.com/help/serdes/ug/architect ural-112g-pam4-adc-based-serdes-model.html [URL 🔗](https://www.mathworks.com/help/serdes/ug/architectural-112g-pam4-adc-based-serdes-model.html)

- 3. Equipo 4 (Wi-Fi / 802.11be): https://www.mathworks.com/help/wlan/802.11be-end-to-end -simulation.html [URL 🔗](https://www.mathworks.com/help/wlan/802.11be-end-to-end-simulation.html)

- 4. Equipo 5 (Bluetooth, coexistencia con WLAN): https://www.mathworks.com/help/bluetooth /ug/bluetooth-br-data-and-voice-communication-with-wlan-signal-interference.html [URL 🔗](https://www.mathworks.com/help/bluetooth/ug/bluetooth-br-data-and-voice-communication-with-wlan-signal-interference.html)

- 5. Equipo 6 (5G NR, PDSCH throughput): https://www.mathworks.com/help/5g/ug/nr-pdsch -throughput.html [URL 🔗](https://www.mathworks.com/help/5g/ug/nr-pdsch-throughput.html)
