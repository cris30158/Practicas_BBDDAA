import csv
import random

archivo_incidencias = 'PL2/ej7/incidencias.csv'
estados = ['nueva', 'abierta', 'en proceso', 'resuelta', 'cerrada']

total_incidencias = 4_000_000
bloque_size = 500_000  # Para escribir en partes

def generar_reservas_unicas():
    print("Seleccionando 4 millones de reserva_id únicos...")
    return random.sample(range(1, 40_000_001), total_incidencias)

def generar_bloque_incidencias(reserva_ids, inicio_idx, cantidad):
    bloque = []
    for i in range(cantidad):
        incidencia_id = inicio_idx + i + 1
        reserva_id = reserva_ids[inicio_idx + i]
        estado = random.choice(estados)
        bloque.append([incidencia_id, reserva_id, estado])
    return bloque

def main():
    reserva_ids = generar_reservas_unicas()

    print("Generando incidencias y escribiendo archivo...")

    with open(archivo_incidencias, mode='w', newline='') as f_out:
        writer = csv.writer(f_out, quoting=csv.QUOTE_NONNUMERIC)
        writer.writerow(['incidencia_id', 'reserva_id', 'estado'])

        for i in range(0, total_incidencias, bloque_size):
            print(f"🧱 Escribiendo bloque {(i // bloque_size) + 1}...")
            bloque = generar_bloque_incidencias(reserva_ids, i, min(bloque_size, total_incidencias - i))
            writer.writerows(bloque)

    print(f"Listo: incidencias generadas y guardadas ")

if __name__ == "__main__":
    main()
