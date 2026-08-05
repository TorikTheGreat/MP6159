# Justificación del Modelo de Transmisor (Rol A)

## 1. Configuración General (IEEE 802.11be / Wi-Fi 7)

Para el rol A, se generó una forma de onda base 802.11be (EHT - Extremely High Throughput) utilizando las funciones nativas de la `WLAN Toolbox` de MATLAB, como lo solicita el alcance del proyecto (sección 5.4 del documento del proyecto). 

Se utilizó la función `wlanEHTMUConfig('CBW80')`, lo que define:
- **Estándar:** Wi-Fi 7 (802.11be) con trama en formato de Alta Eficiencia Extrema (EHT).
- **Ancho de banda (Channel Bandwidth):** 80 MHz (CBW80). Esto proporciona un ancho de banda considerable, coherente con las expectativas de Wi-Fi 7, manteniendo al mismo tiempo un canal no excesivamente ancho para simplificar la simulación con el canal del Rol B y optimizar el cómputo, siendo suficiente para evaluar el throughput.

## 2. Configuración Espacial y MIMO (4x2)

El enlace de comunicación se configuró en un entorno MIMO de 4x2 (4 antenas transmisoras, 2 flujos espaciales).
- **Antenas de Transmisión (`NumTransmitAntennas` = 4):** Se aprovecha la diversidad de transmisión y capacidad de formación de haces (beamforming).
- **Flujos Espaciales Espacio-Temporales (`NumSpaceTimeStreams` = 2):** Permite multiplexación espacial doble, lo cual es realista y compatible con dispositivos comunes (2x2), obteniendo así una tasa de transmisión multiplicada por la cantidad de flujos espaciales en un ancho de banda de 80 MHz.

Dado que el número de antenas (4) es distinto al número de flujos espaciales (2), se configuró el mapeo espacial como **'Fourier'** (`SpatialMapping = 'Fourier'`). Esta es una técnica exigida y soportada por el estándar para direccionar los flujos espaciales a través de todas las antenas de transmisión de manera balanceada usando una matriz predefinida. Esto permite emitir la señal con todas las antenas cuando no se cuenta con información de estado de canal (CSI).

## 3. Esquema de Modulación y Codificación (MCS)

Se configuró el `MCS` a **10**.
- En 802.11be, un MCS de 10 equivale a una modulación **1024-QAM** con una tasa de codificación FEC de **3/4**.
- Esto resulta en una muy alta eficiencia espectral requerida en las demostraciones de Wi-Fi 7. Con una SNR objetivo más alta, pone a prueba el canal elegido (Rol B) verificando en la validación (Rol C) la tasa de error por símbolo bajo un esquema denso, ideal para evidenciar la degradación del canal en ambientes hostiles (Multipath fading).

## 4. Estructura de Trama y PPDU

La longitud de datos útiles (APEPLength) se definió en **2000 bytes**.
- Este tamaño de carga útil (Payload) es un tamaño estándar muy aproximado para paquetes grandes, como tramas de video.
- Permite obtener una longitud de PPDU en microsegundos suficiente para que el bloque receptor simule y mida correctamente el Packet Error Rate (PER) de un paquete normal de red.

## 5. Acondicionamiento (Padding)

Al final del script, se añadió un relleno de ceros (padding) a la forma de onda de transmisión (`txPad = [txWaveform; zeros(50, cfgEHT.NumTransmitAntennas)];`). 
Esto resulta fundamental para la integración con los otros roles, pues añade un tiempo de guarda al final de la simulación. En los sistemas reales, el decaimiento de los ecos de la señal transmitida en el canal (Multipath delay) hace que la señal en el receptor se explaye en el tiempo. Si se corta la simulación justo en el fin del paquete transmitido, el receptor (Rol C) no captaría la energía de desvanecimiento residual, causando pérdida de información valiosa.
