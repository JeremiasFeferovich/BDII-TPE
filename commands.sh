docker cp albumlist.csv Mymongo:/albumlist.csv;
docker exec -it Mymongo bash;
mongoimport -d local --collection albums --type csv --headerline < albumlist.csv;

