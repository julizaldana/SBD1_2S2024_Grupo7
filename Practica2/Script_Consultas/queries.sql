-- CONSULTA 1

SELECT DISTINCT clnt.id_cliente, clnt.nombre || ' ' || clnt.apellido AS nombre_completo, p.nombre AS pais, clnt.edad, gen.nombre AS genero, clnt.telefono
FROM cliente clnt
JOIN pais p ON clnt.pais_id_pais = p.id_pais
JOIN genero gen ON clnt.genero_id_genero = gen.id_genero
LEFT JOIN orden ord ON clnt.id_cliente = ord.cliente_id_cliente
WHERE ord.id_orden IS NULL
   AND ord.fecha_orden < ADD_MONTHS(SYSDATE, -12);


-- CONSULTA 2

SELECT p.id_producto,p.nombre AS nombre_producto,cat.nombre AS categoria,
    COUNT( det.orden_id_orden) AS veces_vendido,  -- ordenes que tiene el prod
    SUM(det.cantidad) AS uni_vendidas,  -- unidades
    SUM(det.cantidad * p.precio) AS monto_vendido  -- monto total
FROM detalle_orden det
JOIN producto p ON det.producto_id_producto = p.id_producto
JOIN categoria cat ON p.categoria_id_categoria = cat.id_categoria
GROUP BY 
    p.id_producto, p.nombre, cat.nombre
ORDER BY 
    uni_vendidas DESC  -- ordenar por cantidad
FETCH FIRST 10 ROWS ONLY;




-- CONSULTA 3

CREATE OR REPLACE VIEW ventasVendedor AS
SELECT 
    v.id_vendedor,
    v.nombre || ' ' || v.apellido AS nombre_vendedor,
    SUM(do.cantidad * p.precio) AS monto_vendido,
    pa.nombre AS pais
FROM 
    detalle_orden do
JOIN 
    vendedor v ON do.vendedor_id_vendedor = v.id_vendedor
JOIN 
    producto p ON do.producto_id_producto = p.id_producto
JOIN 
    pais pa ON v.pais_id_pais = pa.id_pais
GROUP BY 
    v.id_vendedor, v.nombre, v.apellido, pa.nombre;


-- mas
SELECT id_vendedor,nombre_vendedor,monto_vendido
FROM ventasVendedor
WHERE 
    monto_vendido = (SELECT MAX(monto_vendido) FROM ventasVendedor);

-- menos
SELECT id_vendedor,nombre_vendedor,monto_vendido
FROM ventasVendedor
WHERE 
    monto_vendido = (SELECT MIN(monto_vendido) FROM ventasVendedor);



-- CONSULTA 4

SELECT DISTINCT clnt.id_cliente, clnt.nombre || '' || clnt.apellido AS
nombre_completo, clnt.edad, p.nombre AS pais, SUM(det.cantidad * prod.precio) AS
monto_total
FROM CLIENTE clnt
JOIN PAIS p ON clnt.pais_id_pais = p.id_pais
JOIN ORDEN ord ON clnt.id_cliente = ord.cliente_id_cliente
JOIN DETALLE_ORDEN det ON ord.id_orden = det.orden_id_orden
JOIN PRODUCTO prod ON det.producto_id_producto = prod.id_producto
GROUP BY clnt.id_cliente, clnt.nombre, clnt.apellido, clnt.edad, p.nombre
ORDER BY monto_total DESC
FETCH FIRST 1 ROWS ONLY;



-- CONSULTA 5

CREATE OR REPLACE VIEW compras_paiscliente AS
SELECT p.id_pais,
    p.nombre AS pais,
    clnt.id_cliente,
    clnt.nombre || '' || clnt.apellido AS nombre_completo,
    SUM(det.cantidad * prod.precio) AS monto_total
FROM CLIENTE clnt
JOIN PAIS p ON clnt.pais_id_pais = p.id_pais
JOIN orden ord ON clnt.id_cliente = ord.cliente_id_cliente
JOIN DETALLE_ORDEN det ON ord.id_orden = det.orden_id_orden
JOIN PRODUCTO prod ON det.producto_id_producto = prod.id_producto
GROUP BY p.id_pais, p.nombre, clnt.id_cliente, clnt.nombre, clnt.apellido


SELECT cp.id_pais, cp.pais, SUM(cp.monto_total) AS monto_total
FROM COMPRAS_PAISCLIENTE cp
GROUP BY cp.id_pais, cp.pais
ORDER BY monto_total DESC
FETCH FIRST 5 ROWS ONLY


-- CONSULTA 6

(SELECT DISTINCT cat.id_categoria, cat.nombre, SUM(det.cantidad) AS Cantidad_de_unidades
FROM CATEGORIA cat
JOIN PRODUCTO p ON cat.id_categoria = p.categoria_id_categoria
JOIN DETALLE_ORDEN det ON p.id_producto = det.producto_id_producto
GROUP BY cat.id_categoria, cat.nombre
ORDER BY Cantidad_de_unidades DESC
FETCH FIRST 3 ROWS ONLY)
UNION ALL
(SELECT DISTINCT cat.id_categoria, cat.nombre, SUM(det.cantidad) AS Cantidad_de_unidades
FROM CATEGORIA cat
JOIN PRODUCTO p ON cat.id_categoria = p.categoria_id_categoria
JOIN DETALLE_ORDEN det ON p.id_producto = det.producto_id_producto
GROUP BY cat.id_categoria, cat.nombre
ORDER BY Cantidad_de_unidades ASC
FETCH FIRST 3 ROWS ONLY)


-- CONSULTA 7

SELECT 
    EXTRACT(MONTH  FROM o.fecha_orden) AS NO_MES,
    SUM(d.cantidad * p.precio) AS MONTO_TOTAL
FROM 
    DETALLE_ORDEN d
JOIN 
    PRODUCTO p ON d.producto_id_producto = p.id_producto
JOIN 
    ORDEN o ON d.orden_id_orden = o.id_orden
JOIN 
    VENDEDOR v ON d.vendedor_id_vendedor = v.id_vendedor
JOIN 
    PAIS pa ON v.pais_id_pais = pa.id_pais
WHERE 
    pa.id_pais = 6 -- Estados Unidos (país con id = 6)
GROUP BY 
    EXTRACT (MONTH FROM o.fecha_orden)
ORDER BY 
    NO_MES;

-- Inglaterra (pais con id = 8)


-- CONSULTA 8

CREATE OR REPLACE VIEW vista_compras AS
SELECT pa.nombre AS NOMBRE_PAIS, ca.nombre AS NOMBRE_CATEGORIA, SUM(d.cantidad) AS CANT_UNIDADES
FROM DETALLE_ORDEN d
JOIN PRODUCTO p ON d.producto_id_producto = p.id_producto
JOIN ORDEN o ON d.orden_id_orden = o.id_orden
JOIN CATEGORIA ca ON p.categoria_id_categoria = ca.id_categoria
JOIN CLIENTE cl ON o.cliente_id_cliente = cl.id_cliente
JOIN PAIS pa ON cl.pais_id_pais = pa.id_pais
GROUP BY pa.nombre, ca.nombre;


SELECT NOMBRE_PAIS, NOMBRE_CATEGORIA, CANT_UNIDADES
FROM VISTA_COMPRAS vc1
WHERE CANT_UNIDADES = (
    SELECT MAX(vc2.CANT_UNIDADES)
    FROM VISTA_COMPRAS vc2
    WHERE vc2.NOMBRE_PAIS = vc1.NOMBRE_PAIS
);


-- CONSULTA 9

SELECT p.id_producto, p.nombre, SUM(d.cantidad) AS SUMA_CANTIDAD, SUM(d.cantidad) * p.precio AS MONTO_VENDIDO
FROM PRODUCTO p
JOIN CATEGORIA c ON p.categoria_id_categoria = c.id_categoria
JOIN DETALLE_ORDEN d ON p.id_producto = d.producto_id_producto
WHERE c.nombre = 'Familiar'
GROUP BY p.id_producto, p.nombre, p.precio;



-- CONSULTA 10



SELECT EXTRACT(MONTH FROM o.fecha_orden) AS NO_MES, SUM(d.cantidad * p.precio) AS MONTO_VENDIDO
FROM DETALLE_ORDEN d
JOIN PRODUCTO p ON d.producto_id_producto = p.id_producto
JOIN ORDEN o ON d.orden_id_orden = o.id_orden
GROUP BY 
    EXTRACT (MONTH FROM o.fecha_orden)
ORDER BY 
    MONTO_VENDIDO DESC
FETCH FIRST 3 ROWS ONLY;
