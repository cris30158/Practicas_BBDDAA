import csv
import random

seccion = ["A", "B", "C","D","E","F"]

def main():
    with open('PL2/ej7/plazas.csv', 'w', newline='') as file:
        campos = ['plaza_id', 'numero', 'seccion','nivel']      
        writer = csv.DictWriter(file,fieldnames=campos)
        writer.writeheader()

        #rellenar los datos
        for i in range (200000):
            plaza_id = i+1     
            numero = i % (200000//11)
            section = seccion[numero % (len(seccion)-1)] 
            nivel = i//(200000//11)*-1

            #lo insertamos
            writer.writerow({
                'plaza_id': plaza_id,
                'numero': numero,
                'seccion': section,
                'nivel': nivel
            })

            if i % 100000 == 0:
                print(f"Generados {i} registros...")
            
if __name__ == "__main__":  
    main()