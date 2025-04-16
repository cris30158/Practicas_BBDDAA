import pandas as pd
import datetime
import random
import csv
import time

# Archivos de entrada y salida
archivo_reservas = 'PL2/ej7/reservas_final.csv'
archivo_pagos = 'PL2/ej7/pagos.csv'

# Métodos de pago disponibles
metodos_pago = ['efectivo', 'tarjeta de crédito', 'tarjeta de débito', 'PayPal', 'Bizzum', 'transferencia']

# Tamaño de cada bloque y el número total de registros
bloque_size = 1_000_000
total_registros = 40_000_000

# Función para generar el pago a partir de los datos de la reserva
def generar_pago(row, pago_id):
    fecha_inicio = datetime.datetime.strptime(row.fecha_inicio, '%Y-%m-%d %H:%M')
    fecha_final = datetime.datetime.strptime(row.fecha_final, '%Y-%m-%d %H:%M')
    dias = (fecha_final - fecha_inicio).days
    cantidad = dias * 3
    fecha_pago = fecha_final + datetime.timedelta(days=1.5)
    metodo = random.choice(metodos_pago)

    return [pago_id, cantidad, fecha_pago.strftime('%Y-%m-%d %H:%M'), metodo, row.reserva_id]

# Función principal para procesar el archivo de pagos
def main():
    print("🚀 Iniciando generación de pagos...")
    pago_id = 1

    with pd.read_csv(archivo_reservas, chunksize=bloque_size) as reader, \
         open(archivo_pagos, 'w', newline='') as f_out:

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
    print(f"Pagos generados y guardados en: {archivo_pagos}")


# Ejecutar la función principal si es el archivo principal
if __name__ == "__main__":
    main()
