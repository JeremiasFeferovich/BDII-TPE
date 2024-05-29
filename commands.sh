docker pull mongo
docker run --name Mymongo -p 27017:27017 -d mongo

docker cp albumlist.csv Mymongo:/albumlist.csv;
docker exec -it Mymongo bash;

# From inside the docker
mongoimport -d local --collection albums --type csv --headerline < albumlist.csv;
mongosh

# From inside mongosh
use local;