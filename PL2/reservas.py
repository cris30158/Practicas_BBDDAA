import calendar
import csv
import datetime
import random


def main():
    # Cargar los vehículos y sus clientes en memoria para sacar el id correspondiente
    vehiculos = {}
    with open('PL2/ej7/vehiculos.csv', mode='r', encoding='utf-8') as archivo:
        lector_csv = csv.DictReader(archivo)
        for fila in lector_csv:
            vehiculos[int(fila['vehiculo_id'])] = fila['cliente_id']

    with open('PL2/ej7/reservas.csv', 'w', newline='') as file_reservas:
        campos_reserva = ['reserva_id', 'vehiculo_id', 'plaza_id', 'cliente_id', 'fecha_inicio', 'fecha_final']
        writer_reservas = csv.DictWriter(file_reservas, fieldnames=campos_reserva)
        writer_reservas.writeheader()

        bloques = []
        for i in range(40000000):
            reserva_id = i + 1
            vehiculo_id = random.choice(list(vehiculos.keys()))  # para saber que se encuentra en el CSV ese ID
            cliente_id = vehiculos[vehiculo_id]
            plaza_id = random.randint(1, 200000)

            fecha_inicio = generar_fecha_valida()
            duracion_estancia = random.randint(1, 10)
            fecha_final = fecha_inicio + datetime.timedelta(days=duracion_estancia)

            bloques.append({
                'reserva_id': reserva_id,
                'vehiculo_id': vehiculo_id,
                'plaza_id': plaza_id,
                'cliente_id': cliente_id,
                'fecha_inicio': fecha_inicio.strftime('%Y-%m-%d %H:%M'),
                'fecha_final': fecha_final.strftime('%Y-%m-%d %H:%M'),
            })

            if len(bloques) >= 10000:  # Cada 10,000 registros, escribimos en el archivo
                escribir_reservas_en_bloques(writer_reservas, bloques)
                bloques.clear()  # Limpiar los bloques

            if i % 1000 == 0:
                print(f"Generados {i} registros...")

        # Escribir los posibles registros restantes
        if bloques:
            escribir_reservas_en_bloques(writer_reservas, bloques)

def escribir_reservas_en_bloques(writer, bloques):
    for bloque in bloques:
        for reserva in bloque:
            writer.writerow(reserva)

def generar_fecha_valida():
    year = 2024
    month = random.randint(1, 12)
    day = random.randint(1, calendar.monthrange(year, month)[1])  # Para asegurar que el día es válido
    return datetime.datetime(year=year, month=month, day=day, hour=random.randint(0, 23))

if __name__ == "__main__":
    main()
