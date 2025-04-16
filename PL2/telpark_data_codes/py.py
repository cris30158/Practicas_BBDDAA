def main():
    # Lista de letras permitidas (sin vocales ni Q)
    letras_matricula = "BCDFGHJKLMNPRSTVWXYZ"

    # Generar 21 matrículas distintas
    for i in range (1000000):
            # Parte numérica: últimos 4 dígitos
        matricula_numerica = str(i % 10000).zfill(4)  # Resto de dividir entre 10000, con ceros a la izquierda

            # Parte de las letras
        indice_letras = i // 10000  # Dividir entre 10000 para obtener el índice de las letras

            # Calcular las tres letras
        l1 = letras_matricula[(indice_letras // len(letras_matricula) // len(letras_matricula)) % len(letras_matricula)]
        l2 = letras_matricula[(indice_letras // len(letras_matricula)) % len(letras_matricula)]
        l3 = letras_matricula[indice_letras % len(letras_matricula)]

            # Combinar la parte numérica y las letras
        matricula = f"{matricula_numerica}{l1}{l2}{l3}"

            # Imprimir la matrícula generada
        print(matricula)


# Ejecutar la función principal
main()