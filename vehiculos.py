import csv
import random

colores = ["Negro", "Azul", "Verde", "Amarillo", "Rojo", "Blanco", "Gris", "Naranja", 
    "Rosa", "Morado", "Marrón", "Turquesa", "Beige", "Dorado", "Plateado"]
letras = list("BCDFGHJKLMNPQRSTVWXYZ")
def main():
    with open('ej7/vehiculos.csv', 'w', newline='') as file:
        campos = ['vehiculo_id', 'matricula', 'marca','modelo', 'color', 'cliente_id']  
        writer = csv.DictWriter(file,fieldnames=campos)
        writer.writeheader()

        #rellenar los datos
        for i in range (5000000):
            #creamos los valores
            vehiculo_id= i+1

            l1 = i%len(letras) 
            l2 = l1%len(letras)
            l3 = l2%len(letras)
            matricula = str(i % 10000).zfill(4) + letras[l1] + letras[l2] + letras[l3]
            
            marca = "marca_"+str(random.randint(0,500))

            modelo = "modelo_"+str(random.randint(0,20))

            color = colores[random.randint(0,len(colores)-1)] 

            cliente_id = random.randint(0,3000000)

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