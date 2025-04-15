import pandas as pd
import datetime
import random
import csv

archivo_reservas = 'PL2/ej7/reservas_final.csv'
archivo_pagos = 'PL2/ej7/pagos.csv'
metodos_pago = ['efectivo', 'tarjeta de crédito', 'tarjeta de débito', 'PayPal', 'Bizzum', 'transferencia']

bloque_size = 1_000_000
total_registros = 40_000_000

def generar_pago(row, pago_id):
    fecha_inicio = datetime.datetime.strptime(row['fecha_inicio'], '%Y-%m-%d %H:%M')
    fecha_final = datetime.datetime.strptime(row['fecha_final'], '%Y-%m-%d %H:%M')
    dias = (fecha_final - fecha_inicio).days
    cantidad = dias * 3
    fecha_pago = fecha_final + datetime.timedelta(days=1.5)
    metodo = random.choice(metodos_pago)

    return {
        'pago_id': pago_id,
        'cantidad': cantidad,
        'fecha_pago': fecha_pago.strftime('%Y-%m-%d %H:%M'),
        'metodo': metodo,
        'reserva_id': row['reserva_id']
    }

def main():
    print("🚀 Iniciando generación de pagos...")
    reader = pd.read_csv(archivo_reservas, chunksize=bloque_size)

    with open(archivo_pagos, mode='w', newline='') as f_out:
        writer = csv.DictWriter(f_out, fieldnames=['pago_id', 'cantidad', 'fecha_pago', 'metodo', 'reserva_id'], quoting=csv.QUOTE_NONNUMERIC)
        writer.writeheader()

        pago_id = 1
        for i, chunk in enumerate(reader):
            print(f"🧱 Procesando bloque {i+1}...")

            pagos = [generar_pago(row, pago_id + idx) for idx, row in chunk.iterrows()]
            writer.writerows(pagos)
            pago_id += len(pagos)

    print(f"✅ Pagos generados y guardados en: {archivo_pagos}")

if __name__ == "__main__":
    main()
