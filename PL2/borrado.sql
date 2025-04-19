DO $$
DECLARE
    cliente_a_borrar RECORD;
    total_borrar INTEGER;
    contador INTEGER := 0;

    clientes_cursor CURSOR FOR
        SELECT clienteid
        FROM clientes
        ORDER BY RANDOM()
        LIMIT (SELECT ROUND(COUNT(*) * 0.3) FROM clientes);
BEGIN
    -- Calcular total de clientes a borrar
    SELECT ROUND(COUNT(*) * 0.3) INTO total_borrar FROM clientes;

    -- Abrir el cursor
    OPEN clientes_cursor;

    LOOP
        FETCH clientes_cursor INTO cliente_a_borrar;
        EXIT WHEN NOT FOUND;

        -- Incrementar contador
        contador := contador + 1;

        -- Mostrar progreso
        RAISE NOTICE 'Borrando cliente % de % (ID: %)', contador, total_borrar, cliente_a_borrar.clienteid;

        -- Borrar incidencias
        DELETE FROM incidencias
        WHERE reservaid_reservas IN (
            SELECT reservaid FROM reservas WHERE clienteid_clientes = cliente_a_borrar.clienteid
        );
        

        -- Borrar pagos
        DELETE FROM pagos
        WHERE reservaid_reservas IN (
            SELECT reservaid FROM reservas WHERE clienteid_clientes = cliente_a_borrar.clienteid
        );
       

        -- Borrar reservas
        DELETE FROM reservas
        WHERE clienteid_clientes = cliente_a_borrar.clienteid;
        

        -- Borrar vehículos
        DELETE FROM vehiculos
        WHERE clienteid_clientes = cliente_a_borrar.clienteid;
        

        -- Borrar cliente
        DELETE FROM clientes
        WHERE clienteid = cliente_a_borrar.clienteid;
        

    END LOOP;

    CLOSE clientes_cursor;

    RAISE NOTICE 'Eliminación finalizada. Se eliminaron % clientes.', contador;
END $$;
