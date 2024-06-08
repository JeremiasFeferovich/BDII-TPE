#!/bin/bash

csvfile="bataxi.csv"
redis_cli="redis-cli"

while IFS=, read -r id_viaje_r id_taxista_r fecha_inicio fecha_fin duracion origen_viaje_x origen_viaje_y destino_viaje_x destino_viaje_y cantidad_pasajeros
do
    # Skip the header row
    if [ "$id_viaje_r" != "id_viaje_r" ]; then
        $redis_cli GEOADD bataxi $origen_viaje_x $origen_viaje_y $id_viaje_r > /dev/null
    fi
done < "$csvfile"