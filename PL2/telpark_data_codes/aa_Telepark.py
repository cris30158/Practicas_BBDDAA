"""
Imports usados para la creacion de los datos
"""
import csv
import random
import datetime
import time
import pandas as pd
import calendar

"""
Todas las variables con datos usadas para cada generacion de datos
"""
provincias = [
    "Álava", "Albacete", "Alicante", "Almería", "Asturias", "Ávila", "Badajoz", "Barcelona", 
    "Burgos", "Cáceres", "Cádiz", "Cantabria", "Castellón", "Ciudad Real", "Córdoba", 
    "La Coruña", "Cuenca", "Gerona", "Granada", "Guadalajara", "Guipúzcoa", "Huelva", 
    "Huesca", "Islas Baleares", "Jaén", "León", "Lérida", "Lugo", "Madrid", "Málaga", 
    "Murcia", "Navarra", "Orense", "Palencia", "Las Palmas", "Pontevedra", "La Rioja", 
    "Salamanca", "Segovia", "Sevilla", "Soria", "Tarragona", "Santa Cruz de Tenerife", 
    "Teruel", "Toledo", "Valencia", "Valladolid", "Vizcaya", "Zamora", "Zaragoza"
]
nombres = [
    "Alejandro", "María", "Carlos", "Lucía", "David", "Sofía", "Javier", "Paula", 
    "Daniel", "Laura", "Pablo", "Marta", "Sergio", "Claudia", "Adrián", "Sara", 
    "Jorge", "Andrea", "Iván", "Ana", "Manuel", "Carmen", "Álvaro", "Elena", 
    "Raúl", "Isabel", "Rubén", "Patricia", "Miguel", "Rocío", "Ángel", "Irene", 
    "Juan", "Alicia", "Hugo", "Cristina", "Mario", "Eva", "Diego", "Julia", 
    "Fernando", "Natalia", "Luis", "Silvia", "Francisco", "Noelia", "Óscar", 
    "Clara", "Ramón", "Victoria", "Alberto", "Teresa", "Enrique", "Pilar", 
    "Emilio", "Gloria", "Andrés", "Beatriz", "Antonio"
]
apellidos = [
    "Paniagua", "Martínez", "López", "Sánchez", "Pérez", "Gómez", "Fernández", "Rodríguez",
    "González", "Hernández", "Ruiz", "Díaz", "Moreno", "Álvarez", "Jiménez", "Romero",
    "Torres", "Vázquez", "Domínguez", "Ramos", "Castro", "Suárez", "Ortiz", "Rubio"
]
dominios = ["gmail.com", "yahoo.com", "outlook.com"]
colores = ["Negro", "Azul", "Verde", "Amarillo", "Rojo", "Blanco", "Gris", "Naranja", 
    "Rosa", "Morado", "Marrón", "Turquesa", "Beige", "Dorado", "Plateado"]
letras_matricula = list("BCDFGHJKLMNPQRSTVWXYZ")
seccion = ["A", "B", "C","D","E","F"]
metodos_pago = ['efectivo', 'tarjeta de crédito', 'tarjeta de débito', 'PayPal', 'Bizzum', 'transferencia']
estados = ['nueva', 'abierta', 'en proceso', 'resuelta', 'cerrada']
descripciones = ['roce con columna','golpe por otro vehiculo','intento de robo','ventanas rotas','ruedas pinchadas']

#Funcion Main
def main():
    crear_clientes()
    crear_vehiculos()
    crear_plazas()
    crear_reservas()
    crear_pagos()
    crear_incidencias()
    
#Crear los 3.000.000 de clientes
def crear_clientes():
    with open('PL2/ej7/clientes.csv', 'w', newline='') as file:
        campos = ['cliente_id', 'nombre', 'apellido','email', 'telefono', 'provincia']
        writer = csv.DictWriter(file,fieldnames=campos)
        writer.writeheader()
               
        #rellenar los datos
        for i in range (3000000):
            #creamos los valores
            cliente_id = i
            nombre = nombres[random.randint(0,len(nombres)-1)]
            apellido = apellidos[random.randint(0,len(apellidos)-1)]
            email = f"{nombre}_{apellido}{cliente_id}@{random.choice(dominios)}"
            telefono = 655000000 + cliente_id

            provincia = random.choice(provincias);           
            #lo insertamos
            writer.writerow({'cliente_id': cliente_id, 'nombre': nombre, 
                             'apellido': apellido, 'email': email, 
                             'telefono': telefono, 'provincia': provincia})
            
            if i % 100000 == 0:
                print(f"Generados {i} registros...")

#Crear los 5.000.000 de vehiculos
def crear_vehiculos():
    with open('PL2/ej7/vehiculos.csv', 'w', newline='') as file:
        campos = ['vehiculo_id', 'matricula', 'marca','modelo', 'color', 'cliente_id']  
        writer = csv.DictWriter(file,fieldnames=campos)
        writer.writeheader()

        #rellenar los datos
        for i in range (5000000):
            #creamos los valores
            vehiculo_id= i+1
            
            matricula_numerica = str(i % 10000).zfill(4)  # Resto de dividir entre 10000, con ceros a la izquierda

            # Parte de las letras
            indice_letras = i // 10000  # Dividir entre 10000 para obtener el índice de las letras

            # Calcular las tres letras
            l1 = letras_matricula[(indice_letras // len(letras_matricula) // len(letras_matricula)) % len(letras_matricula)]
            l2 = letras_matricula[(indice_letras // len(letras_matricula)) % len(letras_matricula)]
            l3 = letras_matricula[indice_letras % len(letras_matricula)]

            # Combinar la parte numérica y las letras
            matricula = f"{matricula_numerica}{l1}{l2}{l3}"
            
            marca = "marca_"+str(random.randint(0,500))

            modelo = "modelo_"+str(random.randint(0,20))

            color = colores[random.randint(0,len(colores)-1)] 

            cliente_id = random.randint(3000000)

            #lo insertamos
            writer.writerow({
                'vehiculo_id': vehiculo_id,
                'matricula': matricula,
                'marca': marca,
                'modelo': modelo,
                'color': color,
                'cliente_id': cliente_id
            })

            if i % 100000 == 0:
                print(f"Generados {i} registros...")

#Crear las 200.000 las plazas
def crear_plazas():
    with open('PL2/ej7/plazas.csv', 'w', newline='') as file:
        campos = ['plaza_id', 'numero', 'seccion','nivel']      
        writer = csv.DictWriter(file,fieldnames=campos)
        writer.writeheader()

        #rellenar los datos
        for i in range (200000):
            plaza_id = i+1     
            numero = i % (200000//11)
            section = seccion[numero % (len(seccion)-1)] 
            nivel = i//(200000//11)*-1

            #lo insertamos
            writer.writerow({
                'plaza_id': plaza_id,
                'numero': numero,
                'seccion': section,
                'nivel': nivel
            })

            if i % 100000 == 0:
                print(f"Generados {i} registros...")
            
#Crear las 40.000.000 de reservas
def crear_reservas():

    vehiculos = cargar_vehiculos()
    total_registros = 40_000_000
    bloque_size = 1_000_000
    bloques = total_registros // bloque_size
    archivo_salida = "PL2/ej7/reservas_final.csv"

    for i in range(bloques):
        print(f"Generando bloque {i+1}/{bloques}...")
        df_bloque = generar_bloque_reservas(vehiculos, i * bloque_size + 1, bloque_size)
        
        # Solo el primer bloque escribe el header
        df_bloque.to_csv(
            archivo_salida,
            mode='w' if i == 0 else 'a',
            index=False,
            header=(i == 0),
            quoting=csv.QUOTE_NONNUMERIC
        )

    print("Archivo CSV generado: reservas_final.csv")

#Crear los 40.000.00 de pagos asociados a las reservas
def crear_pagos():
    pago_id = 1

    with pd.read_csv('PL2/ej7/reservas_final.csv', chunksize=1_000_000) as reader, \
         open('PL2/ej7/pagos.csv', 'w', newline='') as f_out:

        writer = csv.writer(f_out, quoting=csv.QUOTE_NONNUMERIC)
        # Escribir la cabecera solo una vez
        writer.writerow(['pago_id', 'cantidad', 'fecha_pago', 'metodo', 'reserva_id'])

        for i, chunk in enumerate(reader):
        
            # Generar pagos y escribir directamente al archivo
            for j, row in enumerate(chunk.itertuples(index=False)):
                pago = generar_pago(row, pago_id + j)
                writer.writerow(pago)
            # Actualizar el ID de pago
            pago_id += len(chunk)
            print(f"Bloque {i + 1} procesado ({len(chunk)} pagos)")
    print(f"Pagos generados y guardados en: {'PL2/ej7/pagos.csv'}")

#Crear las 4.000.000 incidencias sobre las reservas
def crear_incidencias():
    reservas_dict = cargar_reservas_dict()

    print("Seleccionando 4 millones de reservas únicas...")
    reserva_ids = random.sample(list(reservas_dict.keys()), 4_000_000)

    print("Generando incidencias y escribiendo archivo...")
    with open('PL2/ej7/incidencias.csv', mode='w', newline='') as f_out:
        writer = csv.writer(f_out, quoting=csv.QUOTE_NONNUMERIC)
        writer.writerow(['incidencia_id', 'reserva_id', 'estado', 'fecha_incidencia', 'descripcion'])

        for i in range(0, 4_000_000, 500_000):
            print(f"Escribiendo bloque {(i // 500_000) + 1}...")
            bloque = generar_bloque_incidencias(reservas_dict, reserva_ids, i, min(500_000, 4_000_000 - i))
            writer.writerows(bloque)
    print(f"Incidencias generadas y guardadas en: {'PL2/ej7/incidencias.csv'}")


#Funciones Extras para el funcionamiento eficiente
def cargar_vehiculos():
    df = pd.read_csv('PL2/ej7/vehiculos.csv', dtype={'vehiculo_id': int, 'cliente_id': str})
    return dict(zip(df['vehiculo_id'], df['cliente_id']))

def cargar_reservas_dict():
    print("Cargando reservas como diccionario...")
    df = pd.read_csv('PL2/ej7/reservas_final.csv', usecols=['reserva_id', 'fecha_final'])
    # Convertir fecha a datetime directamente al cargar
    df['fecha_final'] = pd.to_datetime(df['fecha_final'], format='%Y-%m-%d %H:%M')
    # Convertir a dict: {reserva_id: fecha_final}
    reservas_dict = dict(zip(df['reserva_id'], df['fecha_final']))
    print(f" {len(reservas_dict)} reservas disponibles")
    return reservas_dict

def generar_bloque_incidencias(reservas_dict, reserva_ids, inicio_idx, cantidad):
    bloque = []
    for i in range(cantidad):
        incidencia_id = inicio_idx + i + 1
        reserva_id = reserva_ids[inicio_idx + i]
        estado = random.choice(estados)
        descripcion = random.choice(descripciones)

        fecha_final = reservas_dict[reserva_id]
        fecha_incidencia = fecha_final + datetime.timedelta(days=3)
        fecha_incidencia_str = fecha_incidencia.strftime('%Y-%m-%d %H:%M')

        bloque.append([
            incidencia_id,
            reserva_id,
            estado,
            fecha_incidencia_str,
            descripcion
        ])
    return bloque

def generar_bloque_reservas(vehiculos, inicio_id, bloque_size):
    vehiculo_ids = list(vehiculos.keys())
    data = []

    for i in range(bloque_size):
        reserva_id = inicio_id + i
        vehiculo_id = random.choice(vehiculo_ids)
        cliente_id = vehiculos[vehiculo_id]
        plaza_id = random.randint(1, 200000)

        fecha_inicio = generar_fecha_random()
        duracion = random.randint(1, 10)
        fecha_final = fecha_inicio + datetime.timedelta(days=duracion)

        data.append({
            'reserva_id': reserva_id,
            'vehiculo_id': vehiculo_id,
            'plaza_id': plaza_id,
            'cliente_id': cliente_id,
            'fecha_inicio': fecha_inicio.strftime('%Y-%m-%d %H:%M'),
            'fecha_final': fecha_final.strftime('%Y-%m-%d %H:%M')
        })

    return pd.DataFrame(data)

def generar_pago(row, pago_id):
    fecha_inicio = datetime.datetime.strptime(row.fecha_inicio, '%Y-%m-%d %H:%M')
    fecha_final = datetime.datetime.strptime(row.fecha_final, '%Y-%m-%d %H:%M')
    dias = (fecha_final - fecha_inicio).days
    cantidad = dias * 3
    fecha_pago = fecha_final + datetime.timedelta(days=1.5)
    metodo = random.choice(metodos_pago)

    return [pago_id, cantidad, fecha_pago.strftime('%Y-%m-%d %H:%M'), metodo, row.reserva_id]

def generar_fecha_random():
    year = 2024
    month = random.randint(1, 12)
    day = random.randint(1, calendar.monthrange(year, month)[1])
    hour = random.randint(0, 23)
    return datetime.datetime(year, month, day, hour)


if __name__ == "__main__":
    main()