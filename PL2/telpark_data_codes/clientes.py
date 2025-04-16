import csv
import random

# Lista de provincias españolas
provincias = [
    "Álava", "Albacete", "Alicante", "Almería", "Asturias", "Ávila", "Badajoz", "Barcelona", 
    "Burgos", "Cáceres", "Cádiz", "Cantabria", "Castellón", "Ciudad Real", "Córdoba", 
    "La Coruña", "Cuenca", "Gerona", "Granada", "Guadalajara", "Guipúzcoa", "Huelva", 
    "Huesca", "Islas Baleares", "Jaén", "León", "Lérida", "Lugo", "Madrid", "Málaga", 
    "Murcia", "Navarra", "Orense", "Palencia", "Las Palmas", "Pontevedra", "La Rioja", 
    "Salamanca", "Segovia", "Sevilla", "Soria", "Tarragona", "Santa Cruz de Tenerife", 
    "Teruel", "Toledo", "Valencia", "Valladolid", "Vizcaya", "Zamora", "Zaragoza"
]
nombres = [
    "Alejandro", "María", "Carlos", "Lucía", "David", "Sofía", "Javier", "Paula", 
    "Daniel", "Laura", "Pablo", "Marta", "Sergio", "Claudia", "Adrián", "Sara", 
    "Jorge", "Andrea", "Iván", "Ana", "Manuel", "Carmen", "Álvaro", "Elena", 
    "Raúl", "Isabel", "Rubén", "Patricia", "Miguel", "Rocío", "Ángel", "Irene", 
    "Juan", "Alicia", "Hugo", "Cristina", "Mario", "Eva", "Diego", "Julia", 
    "Fernando", "Natalia", "Luis", "Silvia", "Francisco", "Noelia", "Óscar", 
    "Clara", "Ramón", "Victoria", "Alberto", "Teresa", "Enrique", "Pilar", 
    "Emilio", "Gloria", "Andrés", "Beatriz", "Antonio"
]
apellidos = [
    "Paniagua", "Martínez", "López", "Sánchez", "Pérez", "Gómez", "Fernández", "Rodríguez",
    "González", "Hernández", "Ruiz", "Díaz", "Moreno", "Álvarez", "Jiménez", "Romero",
    "Torres", "Vázquez", "Domínguez", "Ramos", "Castro", "Suárez", "Ortiz", "Rubio"
]
dominios = ["gmail.com", "yahoo.com", "outlook.com"]
def main():
    with open('PL2/ej7/clientes.csv', 'w', newline='') as file:
        campos = ['cliente_id', 'nombre', 'apellido','email', 'telefono', 'provincia']
        writer = csv.DictWriter(file,fieldnames=campos)
        writer.writeheader()
               
        #rellenar los datos
        for i in range (3000000):
            #creamos los valores
            cliente_id = i
            nombre = nombres[random.randint(0,len(nombres)-1)]
            apellido = apellidos[random.randint(0,len(apellidos)-1)]
            email = f"{nombre}_{apellido}{cliente_id}@{random.choice(dominios)}"
            telefono = 655000000 + cliente_id

            provincia = random.choice(provincias);           
            #lo insertamos
            writer.writerow({'cliente_id': cliente_id, 'nombre': nombre, 
                             'apellido': apellido, 'email': email, 
                             'telefono': telefono, 'provincia': provincia})
            
            if i % 100000 == 0:
                print(f"Generados {i} registros...")
            
if __name__ == "__main__":  
    main()

