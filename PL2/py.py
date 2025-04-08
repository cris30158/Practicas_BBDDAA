

estados_incidencia = ["nueva", "abierta", "en proceso", "resuelta", "cerrada"]

colores = ["Negro", "Azul", "Verde", "Amarillo", "Rojo", "Blanco", "Gris", "Naranja", 
    "Rosa", "Morado", "Marrón", "Turquesa", "Beige", "Dorado", "Plateado"
]


SELECT c.nombre, c.entidad FROM contratos c JOIN investigadores_contratos ic ON c.codigo_contrato = ic.codigo_contratoJOIN investigadores i ON ic.codigo_investigador = i.codigo_investigador WHERE c.coste > 10000 AND c.coste < 15000 AND i.salatio > 16000 AND ic.horas = 5;