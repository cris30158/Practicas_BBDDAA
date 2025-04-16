import csv
import random
import datetime
import pandas as pd
import time

archivo_incidencias = 'PL2/ej7/incidencias.csv'
archivo_reservas = 'PL2/ej7/reservas_final.csv'

estados = ['nueva', 'abierta', 'en proceso', 'resuelta', 'cerrada']
descripciones = [
    'roce con columna',
    'golpe por otro vehiculo',
    'intento de robo',
    'ventanas rotas',
    'ruedas pinchadas'
]

total_incidencias = 4_000_000
bloque_size = 500_000

def cargar_reservas_dict():
    print("Cargando reservas como diccionario...")
    df = pd.read_csv(archivo_reservas, usecols=['reserva_id', 'fecha_final'])
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

def main():
    inicio = time.time()
    reservas_dict = cargar_reservas_dict()

    print("Seleccionando 4 millones de reservas únicas...")
    reserva_ids = random.sample(list(reservas_dict.keys()), total_incidencias)

    print("Generando incidencias y escribiendo archivo...")
    with open(archivo_incidencias, mode='w', newline='') as f_out:
        writer = csv.writer(f_out, quoting=csv.QUOTE_NONNUMERIC)
        writer.writerow(['incidencia_id', 'reserva_id', 'estado', 'fecha_incidencia', 'descripcion'])

        for i in range(0, total_incidencias, bloque_size):
            print(f"Escribiendo bloque {(i // bloque_size) + 1}...")
            bloque = generar_bloque_incidencias(reservas_dict, reserva_ids, i, min(bloque_size, total_incidencias - i))
            writer.writerows(bloque)

    fin = time.time()
    print(f"Incidencias generadas y guardadas en: {archivo_incidencias}")
    print(f"Tiempo total: {fin - inicio:.2f} segundos")

if __name__ == "__main__":
    main()

