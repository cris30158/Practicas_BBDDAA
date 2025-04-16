import csv
import random

colores = ["Negro", "Azul", "Verde", "Amarillo", "Rojo", "Blanco", "Gris", "Naranja", 
    "Rosa", "Morado", "Marrón", "Turquesa", "Beige", "Dorado", "Plateado"]
letras_matricula = list("BCDFGHJKLMNPQRSTVWXYZ")
def main():
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

            cliente_id = random.randint(1,3000000)

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
            
if __name__ == "__main__":  
    main()