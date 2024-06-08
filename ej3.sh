docker pull redis
docker run --name Myredis -p 6379:6379 -d redis

docker cp bataxi.csv Myredis:/data/bataxi.csv;
docker cp import_geoadd.sh Myredis:/data/import_geoadd.sh;

docker exec -it Myredis bash

chmod +x import_geoadd.sh

# b)
# Para Parque Chas
redis-cli GEORADIUS bataxi -58.479258 -34.582497 1 km | wc -l
# 339
# Para UTN
redis-cli GEORADIUS bataxi -58.468606 -34.658304 1 km | wc -l
# 9
# Para ITBA Madero
redis-cli GEORADIUS bataxi -58.367862 -34.602938 1 km | wc -l
# 242

# c)
redis-cli DBSIZE
# 1

# d)
redis-cli ZCARD bataxi
# 19148

# e)
# El comando GEOADD de Redis trabaja sobre la estructura de datos Sorted Set (conjunto ordenado)