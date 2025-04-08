with open('ej7/pagos.csv', 'w', newline='') as file_pagos:
        campos_pago = ['pago_id', 'cantidad', 'fecha_pago', 'metodo_pago', 'reserva_id']
        writer_pagos = csv.DictWriter(file_pagos, fieldnames=campos_pago)
        writer_pagos.writeheader()

        
        pago_id = reserva_id
        cantidad_pago = duracion_estancia * 24 * 3
        fecha_pago = fecha_final + datetime.timedelta(days=random.randint(0, 8))
        metodo_pago = random.choice(metodos_pago)

        writer_pagos.writerow({
            'pago_id': pago_id,
            'cantidad': cantidad_pago,
            'fecha_pago': fecha_pago.strftime('%Y-%m-%d'),
            'metodo_pago': metodo_pago,
            'reserva_id': reserva_id
        })