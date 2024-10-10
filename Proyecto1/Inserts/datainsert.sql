-- Insert into aeropuerto
INSERT INTO aeropuerto (id_iata, nombre, pais, ciudad, pistasextendidas, serviciosaduaneros)
VALUES ('LAX', 'Los Angeles International', 'USA', 'Los Angeles', 4, 1);

INSERT INTO aeropuerto (id_iata, nombre, pais, ciudad, pistasextendidas, serviciosaduaneros)
VALUES ('JFK', 'John F. Kennedy International', 'USA', 'New York', 4, 1);

INSERT INTO aeropuerto (id_iata, nombre, pais, ciudad, pistasextendidas, serviciosaduaneros)
VALUES ('CDG', 'Charles de Gaulle', 'France', 'Paris', 4, 1);

-- Insert into aerolineas
INSERT INTO aerolineas (id_oaci, nombre, pais, ciudad)
VALUES ('AA', 'American Airlines', 'USA', 'Dallas');

INSERT INTO aerolineas (id_oaci, nombre, pais, ciudad)
VALUES ('AF', 'Air France', 'France', 'Paris');

INSERT INTO aerolineas (id_oaci, nombre, pais, ciudad)
VALUES ('BA', 'British Airways', 'UK', 'London');




INSERT INTO adestino (destino, aeropuerto_id_iata)
VALUES (1, 'LAX');

INSERT INTO adestino (destino, aeropuerto_id_iata)
VALUES (2, 'JFK');
INSERT INTO adestino (destino, aeropuerto_id_iata)
VALUES (3, 'CDG');

-- Insert into aorigen
INSERT INTO aorigen (origen, aeropuerto_id_iata)
VALUES (1, 'LAX');

INSERT INTO aorigen (origen, aeropuerto_id_iata)
VALUES (2, 'JFK');

INSERT INTO aorigen (origen, aeropuerto_id_iata)
VALUES (3, 'CDG');

-- Insert into aviones
INSERT INTO aviones (aerolineas_id_oaci, id_matricula, modelo, capacidad, alcancemax)
VALUES ('AA', 'N123AA', 'Boeing 737', 3, 30.00);

INSERT INTO aviones (aerolineas_id_oaci, id_matricula, modelo, capacidad, alcancemax)
VALUES ('AF', 'F456AF', 'Airbus A320', 5, 25.00);

INSERT INTO aviones (aerolineas_id_oaci, id_matricula, modelo, capacidad, alcancemax)
VALUES ('BA', 'B789BA', 'Boeing 787', 4, 8000.00);

-- Insert into empleado
INSERT INTO empleado (id_empleado, nombre, apellidos, correo, telefono, salario, aerolineas_id_oaci)
VALUES (1, 'John', 'Doe', 'john.doe@example.com', '5551234', 50000.00, 'AA');

INSERT INTO empleado (id_empleado, nombre, apellidos, correo, telefono, salario, aerolineas_id_oaci)
VALUES (2, 'Marie', 'Dupont', 'marie.dupont@example.com', '5555678', 55000.00, 'AF');

INSERT INTO empleado (id_empleado, nombre, apellidos, correo, telefono, salario, aerolineas_id_oaci)
VALUES (3, 'James', 'Smith', 'james.smith@example.com', '5559876', 60000.00, 'BA');



INSERT INTO pasajeros (id_pasajero, nombre, apellidos, correo, telefono, numeropasaporte, visa)
VALUES (1, 'Jane', 'Smith', 'jane.smith@example.com', '5554321', 'P12345678', 'Visa123');

INSERT INTO pasajeros (id_pasajero, nombre, apellidos, correo, telefono, numeropasaporte, visa)
VALUES (2, 'Louis', 'Martin', 'louis.martin@example.com', '5558765', 'P87654321', 'Visa456');

INSERT INTO pasajeros (id_pasajero, nombre, apellidos, correo, telefono, numeropasaporte, visa)
VALUES (3, 'Alice', 'Brown', 'alice.brown@example.com', '5551239', 'P11223344', 'Visa789');


-- Insert into equipaje
INSERT INTO equipaje (id_equipaje, peso, largo, alto, ancho, estado, observacion, pasajeros_id_pasajero)
VALUES (1, 23.50, 50.00, 20, 40.00, 'En Revisión', 'Tomar con cuidado', 1);

INSERT INTO equipaje (id_equipaje, peso, largo, alto, ancho, estado, observacion, pasajeros_id_pasajero)
VALUES (2, 18.00, 45.00, 18, 35.00, 'Entregado', 'Fragil', 2);

INSERT INTO equipaje (id_equipaje, peso, largo, alto, ancho, estado, observacion, pasajeros_id_pasajero)
VALUES (3, 25.00, 55.00, 22, 42.00, 'Entregado', 'Sobrepasa límite de peso', 3);

-- Insert into pasajeros

-- Insert into tarifa
INSERT INTO tarifa (id_tarifa, precio, clase)
VALUES (1, 200.00, 'E');

INSERT INTO tarifa (id_tarifa, precio, clase)
VALUES (2, 500.00, 'B');

INSERT INTO tarifa (id_tarifa, precio, clase)
VALUES (3, 1000.00, 'F');



INSERT INTO terminales (id_terminal, aeropuerto_id_iata, terminales_id)
VALUES (1, 'LAX', 1);

INSERT INTO terminales (id_terminal, aeropuerto_id_iata, terminales_id)
VALUES (2, 'JFK', 2);

INSERT INTO terminales (id_terminal, aeropuerto_id_iata, terminales_id)
VALUES (3, 'CDG', 3);


INSERT INTO puerta (id_puerta, terminales_terminales_id, id_terminal)
VALUES (1, 1, 1);

INSERT INTO puerta (id_puerta, terminales_terminales_id, id_terminal)
VALUES (2, 2, 2);

INSERT INTO puerta (id_puerta, terminales_terminales_id, id_terminal)
VALUES (3, 3, 3);

INSERT INTO tripulacion (id_tripulacion)
VALUES (1);

INSERT INTO tripulacion (id_tripulacion)
VALUES (2);

INSERT INTO tripulacion (id_tripulacion)
VALUES (3);



-- Insert into mantenimiento
INSERT INTO mantenimiento (id_mantenimiento, descripcion, aviones_id_matricula)
VALUES (1, 'Engine Check', 'N123AA');

INSERT INTO mantenimiento (id_mantenimiento, descripcion, aviones_id_matricula)
VALUES (2, 'Landing Gear Check', 'F456AF');

INSERT INTO mantenimiento (id_mantenimiento, descripcion, aviones_id_matricula)
VALUES (3, 'Interior Cleaning', 'B789BA');





-- Insert into puesto
INSERT INTO puesto (id_puesto, rol, empleado_id_empleado, tripulacion_id_tripulacion)
VALUES (1, 'P', 1, 1);


INSERT INTO puesto (id_puesto, rol, empleado_id_empleado, tripulacion_id_tripulacion)
VALUES (2, 'P', 2, 2);

INSERT INTO puesto (id_puesto, rol, empleado_id_empleado, tripulacion_id_tripulacion)
VALUES (3, 'P', 3, 3);



INSERT INTO ruta (id_ruta, distancia, duracion, aorigen_origen, adestino_destino)
VALUES (1, 2500.00, 5.50, 1, 1);

INSERT INTO ruta (id_ruta, distancia, duracion, aorigen_origen, adestino_destino)
VALUES (2, 3000.00, 6.00, 2, 2);

INSERT INTO ruta (id_ruta, distancia, duracion, aorigen_origen, adestino_destino)
VALUES (3, 3500.00, 7.00, 3, 3);

-- Insert into terminales
INSERT INTO vuelo (id_vuelo, fecha_llegada, fecha_salida, ruta_id_ruta, tripulacion_id_tripulacion, aerolineas_id_oaci, aviones_id_matricula, puerta_id_puerta, estado)
VALUES (1, TO_DATE('2024-12-01 12:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-12-01 09:30', 'YYYY-MM-DD HH24:MI'), 1, 1, 'AA', 'N123AA', 1, 'T');

INSERT INTO vuelo (id_vuelo, fecha_llegada, fecha_salida, ruta_id_ruta, tripulacion_id_tripulacion, aerolineas_id_oaci, aviones_id_matricula, puerta_id_puerta, estado)
VALUES (2, TO_DATE('2024-12-02 14:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-12-02 10:00', 'YYYY-MM-DD HH24:MI'), 2, 2, 'AF', 'F456AF', 2, 'F');

INSERT INTO vuelo (id_vuelo, fecha_llegada, fecha_salida, ruta_id_ruta, tripulacion_id_tripulacion, aerolineas_id_oaci, aviones_id_matricula, puerta_id_puerta, estado)
VALUES (3, TO_DATE('2024-12-03 15:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-12-03 11:00', 'YYYY-MM-DD HH24:MI'), 3, 3, 'BA', 'B789BA', 3, 'F');


-- Insert Reservas

INSERT INTO reserva (id_reserva, fecha, metodopago, estado, vuelo_id_vuelo, pasajeros_id_pasajero)
VALUES (1, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'C', 'A', 1, 1);

INSERT INTO reserva (id_reserva, fecha, metodopago, estado, vuelo_id_vuelo, pasajeros_id_pasajero)
VALUES (2, TO_DATE('2024-12-02', 'YYYY-MM-DD'), 'D', 'O', 2, 2);

INSERT INTO reserva (id_reserva, fecha, metodopago, estado, vuelo_id_vuelo, pasajeros_id_pasajero)
VALUES (3, TO_DATE('2024-12-03', 'YYYY-MM-DD'), 'E', 'C', 3, 3);

INSERT INTO reserva (id_reserva, fecha, metodopago, estado, vuelo_id_vuelo, pasajeros_id_pasajero)
VALUES (3, TO_DATE('2024-12-03', 'YYYY-MM-DD'), 'E', 'C', 3, 1);

INSERT INTO reserva (id_reserva, fecha, metodopago, estado, vuelo_id_vuelo, pasajeros_id_pasajero)
VALUES (3, TO_DATE('2024-12-03', 'YYYY-MM-DD'), 'E', 'C', 3, 2);


INSERT INTO reserva (id_reserva, fecha, metodopago, estado, vuelo_id_vuelo, pasajeros_id_pasajero)
VALUES (3, TO_DATE('2024-12-03', 'YYYY-MM-DD'), 'E', 'C', 3, 1);


-- Insert into ruta

INSERT INTO historia_vp (id_historial, vuelo_id_vuelo, pasajeros_id_pasajero)
VALUES (1, 1, 1);

INSERT INTO historia_vp (id_historial, vuelo_id_vuelo, pasajeros_id_pasajero)
VALUES (2, 2, 2);

INSERT INTO historia_vp (id_historial, vuelo_id_vuelo, pasajeros_id_pasajero)
VALUES (3, 3, 3);

INSERT INTO asiento (id_numero, tarifa_id_tarifa, estado, aviones_id_matricula, reserva_id_reserva)
VALUES (1, 1, 'A', 'N123AA', 1);

INSERT INTO asiento (id_numero, tarifa_id_tarifa, estado, aviones_id_matricula, reserva_id_reserva)
VALUES (2, 2, 'O', 'F456AF', 2);

INSERT INTO asiento (id_numero, tarifa_id_tarifa, estado, aviones_id_matricula, reserva_id_reserva)
VALUES (3, 3, 'A', 'B789BA', 3);




INSERT INTO aviones (aerolineas_id_oaci, id_matricula, modelo, capacidad, alcancemax)
VALUES ('BA', 'NATALIA', 'PRUEBA', 240, 800.00);


INSERT INTO reserva (id_reserva, fecha, metodopago, estado, vuelo_id_vuelo, pasajeros_id_pasajero)
VALUES (4, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'C', 'A', 1, 2);

INSERT INTO asiento (id_numero, tarifa_id_tarifa, estado, aviones_id_matricula, reserva_id_reserva)
VALUES (5, 2, 'A', 'N123AA', 4);
INSERT INTO historia_vp (id_historial, vuelo_id_vuelo, pasajeros_id_pasajero)
VALUES (4, 1, 2);




-- Insert into empleado
INSERT INTO empleado (id_empleado, nombre, apellidos, correo, telefono, salario, aerolineas_id_oaci)
VALUES (5, 'Prueba', 'Doe', 'joh@example.com', '5551004', 5000.00, 'BA');

INSERT INTO puesto (id_puesto, rol, empleado_id_empleado, tripulacion_id_tripulacion)
VALUES (1, 'C', 5, 2);

-- Drop unique index on tripulacion_id_tripulacion
-- DROP INDEX vuelo__idx;

-- Drop unique index on puerta_id_puerta
-- DROP INDEX vuelo__idxv1;

-- Drop unique index on ruta_id_ruta
-- DROP INDEX vuelo__idxv2;

INSERT INTO vuelo (id_vuelo, fecha_llegada, fecha_salida, ruta_id_ruta, tripulacion_id_tripulacion, aerolineas_id_oaci, aviones_id_matricula, puerta_id_puerta, estado)
VALUES (4, TO_DATE('2024-11-02 15:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-11-02 11:00', 'YYYY-MM-DD HH24:MI'), 3, 2, 'BA', 'B789BA', 2, 'T');

