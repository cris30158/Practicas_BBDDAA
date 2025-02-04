import random
import csv

def main():
    #crear el archivo .csv
    with open('PL1.csv', 'w', newline='') as file:
        campos = ['id_producto', 'nombre', 'stock','precio']
        writer = csv.DictWriter(file,fieldnames=campos)
        writer.writeheader()

        #rellenar los datos
        for i in range (25000000):
            #creamos los valores

            id_producto = i+1
            nombre = "producto_" + str(i+1)
            stock = random.randint(0,20000)
            precio = random.randint(0,5000)
            writer.writerow({'id_producto': id_producto, 'nombre': nombre, 'stock':stock, 'precio': precio})
            #los insertamos


    



    

if __name__ == "__main__":  
    main()