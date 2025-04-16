import pandas as pd
import datetime
import random
import calendar
import csv

archivo_vehiculos = 'PL2/ej7/vehiculos.csv'

def cargar_vehiculos():
    df = pd.read_csv(archivo_vehiculos, dtype={'vehiculo_id': int, 'cliente_id': str})
    return dict(zip(df['vehiculo_id'], df['cliente_id']))

def generar_fecha_random():
    year = 2024
    month = random.randint(1, 12)
    day = random.randint(1, calendar.monthrange(year, month)[1])
    hour = random.randint(0, 23)
    return datetime.datetime(year, month, day, hour)

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

def main():
    vehiculos = cargar_vehiculos()
    total_registros = 40_000_000
    bloque_size = 1_000_000
    bloques = total_registros // bloque_size
    archivo_salida = "PL2/ej7/reservas_final.csv"

    for i in range(bloques):
        print(f"🧱 Generando bloque {i+1}/{bloques}...")
        df_bloque = generar_bloque_reservas(vehiculos, i * bloque_size + 1, bloque_size)
        
        # Solo el primer bloque escribe el header
        df_bloque.to_csv(
            archivo_salida,
            mode='w' if i == 0 else 'a',
            index=False,
            header=(i == 0),
            quoting=csv.QUOTE_NONNUMERIC
        )

    print("✅ Archivo CSV generado: reservas_final.csv")

if __name__ == "__main__":
    main()
