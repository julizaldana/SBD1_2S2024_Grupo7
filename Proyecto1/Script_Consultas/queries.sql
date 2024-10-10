-- 1. Listar los vuelos programados en una fecha específica incluyendo la aerolínea, el número de vuelo, el origen, el destino y la hora de salida:
SELECT
    v.id_vuelo AS NumeroVuelo,
    a.nombre AS Aerolinea,
    ao.aeropuerto_id_iata AS Origen,
    ad.aeropuerto_id_iata AS Destino,
    v.fecha_salida
FROM vuelo v
JOIN aerolineas a ON v.aerolineas_id_oaci = a.id_oaci
JOIN ruta r ON v.ruta_id_ruta = r.id_ruta
JOIN aorigen ao ON r.aorigen_origen = ao.origen
JOIN adestino ad ON r.adestino_destino = ad.destino
WHERE TRUNC(v.fecha_salida) = TO_DATE('2024-11-02', 'YYYY-MM-DD')
AND v.estado = 'P'; -- VUELO EN ESTADO PROGRAMADO


-- 2. Listar todos los vuelos de un pasajero en un año determinado:
SELECT v.id_vuelo AS NumeroVuelo, v.fecha_salida, a.nombre AS Aerolinea, ao.aeropuerto_id_iata AS Origen, ad.aeropuerto_id_iata AS Destino
FROM vuelo v
JOIN historia_vp hvp ON v.id_vuelo = hvp.vuelo_id_vuelo
JOIN pasajeros p ON hvp.pasajeros_id_pasajero = p.id_pasajero
JOIN ruta r ON v.ruta_id_ruta = r.id_ruta
JOIN aorigen ao ON r.aorigen_origen = ao.origen
JOIN adestino ad ON r.adestino_destino = ad.destino
JOIN aerolineas a ON v.aerolineas_id_oaci = a.id_oaci
WHERE p.id_pasajero = 2 -- ID DEL PASAJERO
AND EXTRACT(YEAR FROM v.fecha_salida) = 2024;


-- 3. Listar a los empleados asignados a un vuelo en específico, mostrando su cargo durante el vuelo: 
SELECT e.nombre, e.apellidos, p.rol
FROM vuelo v
JOIN tripulacion t ON v.tripulacion_id_tripulacion = t.id_tripulacion
JOIN puesto p ON t.id_tripulacion = p.tripulacion_id_tripulacion
JOIN empleado e ON p.empleado_id_empleado = e.id_empleado
WHERE v.id_vuelo = 2; -- ID DEL VUELO, LA TRIPULACION SE AGREGA COMO CONJUNTO SI SE USA EL MISMO ID


-- 4. Mostrar las reservas canceladas en los últimos tres meses:

SELECT r.id_reserva, r.fecha, r.metodopago, r.estado, p.nombre, p.apellidos
FROM reserva r
JOIN pasajeros p ON r.pasajeros_id_pasajero = p.id_pasajero
WHERE r.estado = 'C'
AND r.fecha >= ADD_MONTHS(SYSDATE, -3);

-- 5. Listar todos los vuelos en los que ha participado un piloto en específico:
SELECT v.id_vuelo, v.fecha_salida, v.fecha_llegada, a.nombre AS Aerolinea
FROM vuelo v
JOIN tripulacion t ON v.tripulacion_id_tripulacion = t.id_tripulacion
JOIN puesto p ON t.id_tripulacion = p.tripulacion_id_tripulacion
JOIN empleado e ON p.empleado_id_empleado = e.id_empleado
JOIN aerolineas a ON v.aerolineas_id_oaci = a.id_oaci
WHERE e.id_empleado = 2 -- EL ID DEL EMPLEADO
AND v.estado = 'F' -- VUELO FINALIZADO
AND p.rol = 'P'; -- P=PILOTO

-- misma query mas info:
-- 5. Listar todos los vuelos en los que ha participado un piloto en específico:

SELECT 
    v.id_vuelo AS NumeroVuelo,
    v.fecha_salida,
    v.fecha_llegada,
    a.nombre AS Aerolinea,
    ao.aeropuerto_id_iata AS Origen,
    ad.aeropuerto_id_iata AS Destino,
    av.modelo AS ModeloAvion,
    av.capacidad AS CapacidadAvion,
    pua.id_puerta AS PuertaSalida
FROM 
    vuelo v
JOIN tripulacion t ON v.tripulacion_id_tripulacion = t.id_tripulacion
JOIN puesto p ON t.id_tripulacion = p.tripulacion_id_tripulacion
JOIN empleado e ON p.empleado_id_empleado = e.id_empleado
JOIN aerolineas a ON v.aerolineas_id_oaci = a.id_oaci
JOIN  ruta r ON v.ruta_id_ruta = r.id_ruta
JOIN  aorigen ao ON r.aorigen_origen = ao.origen
JOIN adestino ad ON r.adestino_destino = ad.destino
JOIN  aviones av ON v.aviones_id_matricula = av.id_matricula
JOIN puerta pua ON v.puerta_id_puerta = pua.id_puerta
WHERE  e.id_empleado = 2 -- EL ID DEL EMPLEADO
AND v.estado = 'F' -- VUELO FINALIZADO
AND  p.rol = 'P'; -- P = PILOTO


-- 6. VUELOS CON EL 90% DE SU CAPACIDAD

SELECT 
    v.id_vuelo,
    v.fecha_salida,
    v.fecha_llegada,
    a.modelo AS ModeloAvion,
    a.capacidad AS CapacidadAvion,
    COUNT(r.id_reserva) AS TotalReservas,
    (COUNT(r.id_reserva) / a.capacidad) * 100 AS PorcentajeOcupacion
FROM vuelo v
JOIN aviones a ON v.aviones_id_matricula = a.id_matricula
JOIN reserva r ON v.id_vuelo = r.vuelo_id_vuelo
WHERE r.estado = 'A'  -- Estado de la reservación debe ser 'A' APROBADA
GROUP BY v.id_vuelo, v.fecha_salida,  v.fecha_llegada,  a.modelo,  a.capacidad
HAVING COUNT(r.id_reserva) >= a.capacidad * 0.9;

-- EL NUMERO DE RESERVAS PARA ESE VUELO SEA AL MENOS EL 90% DE LA CAPACIDAD DEL AVION LINKEADO AL VUELO


-- 7. Listar los 3 aviones que más vuelos han realizado en un mes determinado:

SELECT
    a.id_matricula,
    a.modelo,
    a.capacidad,
    a.alcancemax,
    COUNT(v.id_vuelo) AS TotalVuelos
FROM vuelo v
JOIN aviones a ON v.aviones_id_matricula = a.id_matricula
WHERE
    EXTRACT(MONTH FROM v.fecha_salida) = 11
    AND EXTRACT(YEAR FROM v.fecha_salida) = 2024
GROUP BY a.id_matricula, a.modelo, a.capacidad, a.alcancemax
ORDER BY TotalVuelos DESC FETCH FIRST 3 ROWS ONLY;

-- descendente = arriba - Abajo, top 3(3 filas)


-- 8. Mostrar la cantidad de pasajeros en un vuelo en específico, incluyendo detalles de cada asiento:

SELECT p.nombre, p.apellidos, a.id_numero AS NumeroAsiento, a.estado, t.precio, t.clase
FROM vuelo v
JOIN reserva r ON v.id_vuelo = r.vuelo_id_vuelo
JOIN pasajeros p ON r.pasajeros_id_pasajero = p.id_pasajero
JOIN asiento a ON r.id_reserva = a.reserva_id_reserva
JOIN tarifa t ON a.tarifa_id_tarifa = t.id_tarifa
WHERE v.id_vuelo = 3; -- EL ID DEL VUELO

-- 9. Obtener el total de ingresos generados por un vuelo en específico:

SELECT v.id_vuelo, SUM(t.precio) AS TotalIngresos
FROM vuelo v
JOIN reserva r ON v.id_vuelo = r.vuelo_id_vuelo
JOIN asiento a ON r.id_reserva = a.reserva_id_reserva
JOIN tarifa t ON a.tarifa_id_tarifa = t.id_tarifa
WHERE v.id_vuelo = 3 -- EL ID DEL VUELO
GROUP BY v.id_vuelo;

-- 10.     Listar todos los aviones que no estén asignados a un vuelo:

SELECT a.id_matricula, a.modelo, a.capacidad, a.alcancemax
FROM aviones a
LEFT JOIN vuelo v ON a.id_matricula = v.aviones_id_matricula
WHERE v.aviones_id_matricula IS NULL;