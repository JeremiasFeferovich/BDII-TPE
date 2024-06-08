# BDII-TPE
## Ejercicio 1
### Setup
Crear la imagen de docker:
```
docker pull mongo
docker run --name Mymongo -p 27017:27017 -d mongo
docker cp albumlist.csv Mymongo:/albumlist.csv;
```
Ingresar al contenedor de Docker:
```
docker exec -it Mymongo bash;
```
Importar el archivo csv:
```
mongoimport -d local --collection albums --type csv --headerline < albumlist.csv;
```
Ejecutar la consola de mongo:
```
mongosh
```
Seleccionar la base de datos a utilizar:
```
use local;
```

#### Item B
Cantidad de albumes por año ordenadas descendientemente:
```
db.albums.aggregate([
  {
    $group: {
      _id: "$Year",
      count: { $sum: 1 }
    }
  },
  {
    $sort: { count: -1 }
  }
]);
```
Resultado:
```
[
  { _id: 1970, count: 26 }, 
  { _id: 1972, count: 24 },  
  { _id: 1973, count: 23 },
  { _id: 1969, count: 22 },
  { _id: 1971, count: 21 },
  { _id: 1968, count: 21 },
  { _id: 1967, count: 20 },
  { _id: 1975, count: 18 },
  { _id: 1977, count: 18 },
  { _id: 1994, count: 16 },
  { _id: 1978, count: 16 },
  { _id: 1979, count: 14 },
  { _id: 1974, count: 14 },
  { _id: 1965, count: 14 },
  { _id: 1966, count: 13 },
  { _id: 1991, count: 13 },
  { _id: 1976, count: 12 },
  { _id: 1987, count: 12 },
  { _id: 1985, count: 11 },
  { _id: 1989, count: 10 },
  { _id: 1984, count: 10 }, 
  { _id: 2001, count: 9 },
  { _id: 1980, count: 9 },
  { _id: 1986, count: 9 },
  { _id: 2000, count: 7 },
  { _id: 2002, count: 7 },
  { _id: 1999, count: 6 },
  { _id: 1993, count: 6 },
  { _id: 1997, count: 6 },
  { _id: 1992, count: 6 },
  { _id: 1981, count: 6 },
  { _id: 1983, count: 6 },
  { _id: 1988, count: 6 },
  { _id: 1982, count: 6 },
  { _id: 2007, count: 5 },
  { _id: 1995, count: 5 },
  { _id: 1963, count: 5 },
  { _id: 1990, count: 5 },
  { _id: 1998, count: 5 },
  { _id: 1996, count: 4 },
  { _id: 1964, count: 4 },
  { _id: 1959, count: 4 },
  { _id: 2003, count: 4 },
  { _id: 1960, count: 3 },
  { _id: 2006, count: 3 },
  { _id: 2004, count: 2 },
  { _id: 1956, count: 2 },
  { _id: 2005, count: 2 },
  { _id: 1957, count: 2 },
  { _id: 1962, count: 2 },
  { _id: 1958, count: 1 },
  { _id: 2011, count: 1 },
  { _id: 2010, count: 1 },
  { _id: 2008, count: 1 },
  { _id: 1955, count: 1 },
  { _id: 1961, count: 1 }

]

```
#### Item C
Agregar atributo scor
```
db.albums.updateMany({}, [
  {
    $set: {
      score: {
        $subtract: [501, "$Number"]
      }
    }
  }
]);
```
Resultado:
```
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 500,
  modifiedCount: 500,
  upsertedCount: 0
}
```
#### Item D
Score de cada artista
```
db.albums.aggregate([
  {
    $group: {
      _id: "$Artist",
      score: { $sum: "$score" }
    }
  },
  {
    $sort: { score: -1 }
  }
]);
```
Resultado:
```
[
  { _id: 'The Beatles', score: 3855 },
  { _id: 'The Rolling Stones', score: 3604 },
  { _id: 'Bob Dylan', score: 3377 },
  { _id: 'Bruce Springsteen', score: 2251 },
  { _id: 'The Who', score: 2210 },
  { _id: 'Led Zeppelin', score: 2107 },
  { _id: 'Stevie Wonder', score: 1548 },
  { _id: 'Sly & The Family Stone', score: 1537 },
  { _id: 'Radiohead', score: 1509 },
  { _id: 'David Bowie', score: 1508 },
  { _id: 'U2', score: 1495 },
  { _id: 'The Byrds', score: 1353 },
  { _id: 'The Jimi Hendrix Experience', score: 1350 },
  { _id: 'Pink Floyd', score: 1316 },
  { _id: 'Elton John', score: 1303 },
  { _id: 'The Velvet Underground', score: 1272 },
  { _id: 'Various Artists', score: 1246 },
  { _id: 'Elvis Presley', score: 1246 },
  { _id: 'Michael Jackson', score: 1212 },
  { _id: 'Bob Marley & The Wailers', score: 1107 },
  { _id: 'Cream', score: 1082 },
  { _id: 'Ray Charles', score: 1079 },
  { _id: 'James Brown', score: 1074 },
  { _id: 'Prince', score: 1041 },
  { _id: 'Miles Davis', score: 1038 },
  { _id: 'Neil Young', score: 1017 },
  { _id: 'Simon & Garfunkel', score: 1016 },
  { _id: 'Otis Redding', score: 1010 },
  { _id: 'The Clash', score: 1007 },
  { _id: 'The Band', score: 923 },
  { _id: 'Van Morrison', score: 917 },
  { _id: 'Marvin Gaye', score: 876 },
  { _id: 'Al Green', score: 875 },
  { _id: 'Ramones', score: 863 },
  { _id: 'Joni Mitchell', score: 859 },
  { _id: 'Talking Heads', score: 856 },
  { _id: 'John Coltrane', score: 852 },
  { _id: 'The Beach Boys', score: 849 },
  { _id: 'Muddy Waters', score: 835 },
  { _id: 'Aretha Franklin', score: 833 },
  { _id: 'Black Sabbath', score: 829 },
  { _id: 'Phil Spector', score: 795 },
  { _id: 'Fleetwood Mac', score: 794 },
  { _id: 'Nirvana', score: 738 },
  { _id: 'Elvis Costello', score: 736 },
  { _id: 'Kanye West', score: 734 },
  { _id: 'Steely Dan', score: 732 },
  { _id: 'AC/DC', score: 725 },
  { _id: 'The Kinks', score: 724 },
  { _id: 'Madonna', score: 713 },
  { _id: 'Grateful Dead', score: 690 },
  { _id: 'The Doors', score: 688 },
  { _id: 'Paul Simon', score: 663 },
  { _id: 'Pavement', score: 655 },
  { _id: 'Public Enemy', score: 652 },
  { _id: 'Jay Z', score: 652 },
  { _id: 'The Smiths', score: 648 },
  { _id: 'Santana', score: 646 },
  { _id: 'The Meters', score: 643 },
  { _id: 'Run D.M.C.', score: 637 },
  { _id: 'Creedence Clearwater Revival', score: 634 },
  { _id: 'Beastie Boys', score: 627 },
  { _id: 'The Stooges', score: 626 },
  { _id: 'The Replacements', score: 624 },
  { _id: "Howlin' Wolf", score: 610 },
  { _id: 'Aerosmith', score: 597 },
  { _id: 'Eagles', score: 597 },
  { _id: 'R.E.M.', score: 595 },
  { _id: 'Frank Sinatra', score: 593 },
  { _id: 'Green Day', score: 584 },
  { _id: 'Metallica', score: 580 },
  { _id: 'Billy Joel', score: 578 },
  { _id: 'Willie Nelson', score: 559 },
  { _id: 'The Wailers', score: 557 },
  { _id: 'Johnny Cash', score: 548 },
  { _id: 'Jefferson Airplane', score: 483 },
  { _id: 'Eminem', score: 483 },
  { _id: 'Chuck Berry', score: 480 },
  { _id: 'Robert Johnson', score: 479 },
  { _id: 'John Lennon / Plastic Ono Band', score: 478 },
  { _id: 'Carole King', score: 465 },
  { _id: 'Lou Reed', score: 464 },
  { _id: 'Love', score: 461 },
  { _id: 'Sex Pistols', score: 460 },
  { _id: 'The Mothers of Invention', score: 459 },
  { _id: 'Pixies', score: 458 },
  { _id: 'Patti Smith', score: 457 },
  { _id: 'Sam Cooke', score: 456 },
  { _id: 'The Allman Brothers Band', score: 452 },
  { _id: 'Little Richard', score: 451 },
  { _id: 'Neil Young & Crazy Horse', score: 441 },
  { _id: 'Captain Beefheart & His Magic Band', score: 441 },
  { _id: "Guns N' Roses", score: 439 },
  { _id: 'The Police', score: 433 },
  { _id: 'Randy Newman', score: 431 },
  { _id: 'Curtis Mayfield', score: 429 },
  { _id: 'Prince and the Revolution', score: 425 },
  { _id: 'John Lennon', score: 421 },
  { _id: 'Various', score: 413 },
  { _id: 'Dusty Springfield', score: 412 },
  { _id: 'Buddy Holly', score: 409 },
  { _id: 'Hank Williams', score: 407 },
  { _id: 'The Zombies', score: 401 },
  { _id: 'James Taylor', score: 397 },
  { _id: 'The Notorious B.I.G.', score: 392 },
  { _id: 'The Mamas and the Papas', score: 389 },
  { _id: 'Derek and the Dominos', score: 384 },
  { _id: 'Etta James', score: 382 },
  { _id: 'X', score: 382 },
  { _id: 'Moby Grape', score: 377 },
  { _id: 'Janis Joplin', score: 376 },
  { _id: 'Iggy and The Stooges', score: 373 },
  { _id: 'Television', score: 371 },
  { _id: 'Dr. Dre', score: 363 },
  { _id: 'B.B. King', score: 362 },
  { _id: 'Blondie', score: 361 },
  { _id: 'Elvis Costello & The Attractions', score: 361 },
  { _id: 'Dr. John, the Night Tripper', score: 358 },
  { _id: 'N.W.A', score: 357 },
  { _id: 'Crosby, Stills, Nash & Young', score: 354 },
  { _id: 'KISS', score: 354 },
  { _id: 'Arcade Fire', score: 350 },
  { _id: 'Tom Waits', score: 349 },
  { _id: "The B 52's", score: 349 },
  { _id: 'A Tribe Called Quest', score: 348 },
  { _id: 'Funkadelic', score: 346 },
  { _id: 'Pretenders', score: 346 },
  { _id: 'Joy Division', score: 344 },
  { _id: 'T. Rex', score: 341 },
  { _id: 'Linda Ronstadt', score: 337 },
  { _id: 'Rod Stewart', score: 329 },
  { _id: 'Todd Rundgren', score: 328 },
  { _id: 'Carpenters', score: 326 },
  { _id: 'Curtis Mayfield and The Impressions', score: 323 },
  { _id: 'ABBA', score: 322 },
  { _id: 'Peter Gabriel', score: 314 },
  { _id: 'Buffalo Springfield', score: 313 },
  { _id: 'Quicksilver Messenger Service', score: 312 },
  { _id: 'The Flying Burrito Brothers', score: 309 },
  { _id: 'Pearl Jam', score: 308 },
  { _id: 'John Mayall & The Bluesbreakers', score: 306 },
  { _id: 'Little Walter', score: 303 },
  { _id: 'The Strokes', score: 302 },
  { _id: 'Nine Inch Nails', score: 300 },
  { _id: 'The Yardbirds', score: 297 },
  { _id: 'Cat Stevens', score: 293 },
  { _id: 'Red Hot Chili Peppers', score: 291 },
  { _id: 'Jackson Browne', score: 287 },
  { _id: 'Ike & Tina Turner', score: 287 },
  { _id: 'New York Dolls', score: 286 },
  { _id: 'Bo Diddley', score: 285 },
  { _id: 'Bobby "Blue" Bland', score: 284 },
  { _id: 'My Bloody Valentine', score: 280 },
  { _id: 'Professor Longhair', score: 279 },
  { _id: 'Bonnie Raitt', score: 277 },
  { _id: 'Neil Diamond', score: 277 },
  { _id: 'Eric B. & Rakim', score: 273 },
  { _id: 'Queen', score: 270 },
  { _id: 'Eric Clapton', score: 266 },
  { _id: 'Patsy Cline', score: 266 },
  { _id: 'Jackie Wilson', score: 265 },
  { _id: 'MC5', score: 262 },
  { _id: 'Beck', score: 260 },
  { _id: 'Jerry Lee Lewis', score: 256 },
  { _id: 'The Grateful Dead', score: 254 },
  { _id: 'Ornette Coleman', score: 253 },
  { _id: 'Kraftwerk', score: 245 },
  { _id: 'Whitney Houston', score: 244 },
  { _id: 'Janet', score: 242 },
  { _id: 'Crosby, Stills & Nash', score: 239 },
  { _id: 'Tracy Chapman', score: 238 },
  { _id: 'The Cure', score: 238 },
  { _id: 'Blood, Sweat & Tears', score: 235 },
  { _id: 'Roxy Music', score: 232 },
  { _id: 'The Jesus and Mary Chain', score: 232 },
  { _id: 'Sleater Kinney', score: 229 },
  { _id: 'Smokey Robinson & The Miracles', score: 228 },
  { _id: 'LaBelle', score: 227 },
  { _id: 'Parliament', score: 225 },
  { _id: 'Janet Jackson', score: 224 },
  { _id: 'Mary J. Blige', score: 220 },
  { _id: 'Barry White', score: 218 },
  { _id: 'The Cars', score: 217 },
  { _id: 'Big Star', score: 215 },
  { _id: 'Bob Dylan and the Band', score: 209 },
  { _id: 'Leonard Cohen', score: 206 },
  { _id: 'Weezer', score: 202 },
  { _id: 'Dolly Parton', score: 200 },
  { _id: 'Richard & Linda Thompson', score: 199 },
  { _id: 'Jeff Buckley', score: 197 },
  { _id: 'Lucinda Williams', score: 196 },
  { _id: "Jane's Addiction", score: 189 },
  { _id: 'Lauryn Hill', score: 187 },
  { _id: 'Tom Petty and the Heartbreakers', score: 186 },
  { _id: "The O'Jays", score: 183 },
  { _id: 'Nick Drake', score: 180 },
  { _id: 'Liz Phair', score: 174 },
  { _id: 'Sonic Youth', score: 173 },
  { _id: 'Graham Parker & The Rumour', score: 167 },
  { _id: 'Soundgarden', score: 166 },
  { _id: 'PJ Harvey', score: 165 },
  { _id: 'Jethro Tull', score: 164 },
  { _id: 'Big Brother & the Holding Company', score: 163 },
  { _id: 'Black Flag', score: 161 },
  { _id: 'Moby', score: 160 },
  { _id: 'Depeche Mode', score: 159 },
  { _id: 'Meat Loaf', score: 158 },
  { _id: 'De La Soul', score: 155 },
  { _id: 'Dire Straits', score: 149 },
  { _id: 'Mott the Hoople', score: 148 },
  { _id: 'Buzzcocks', score: 141 },
  { _id: 'Brian Eno', score: 141 },
  { _id: 'OutKast', score: 141 },
  { _id: 'The Smashing Pumpkins', score: 139 },
  { _id: 'New Order', score: 138 },
  { _id: 'Rage Against the Machine', score: 136 },
  { _id: 'Cheap Trick', score: 133 },
  { _id: 'Arctic Monkeys', score: 130 },
  { _id: 'Bjork', score: 125 },
  { _id: 'John Lee Hooker', score: 124 },
  { _id: 'Oasis', score: 123 },
  { _id: 'TLC', score: 122 },
  { _id: 'Toots & The Maytals', score: 121 },
  { _id: 'The Modern Lovers', score: 119 },
  { _id: 'The White Stripes', score: 115 },
  { _id: 'Wu Tang Clan', score: 114 },
  { _id: 'ZZ Top', score: 114 },
  { _id: 'Don Henley', score: 112 },
  { _id: 'M.I.A.', score: 108 },
  { _id: 'LCD Soundsystem', score: 106 },
  { _id: 'Massive Attack', score: 104 },
  { _id: 'The Temptations', score: 101 },
  { _id: 'Nas', score: 99 },
  { _id: 'Lynyrd Skynyrd', score: 98 },
  { _id: 'Dr. John', score: 97 },
  { _id: "Sinead O'Connor", score: 93 },
  { _id: 'Wire', score: 89 },
  { _id: 'Minutemen', score: 88 },
  { _id: "The Go Go's", score: 87 },
  { _id: 'Van Halen', score: 86 },
  { _id: 'Paul McCartney & Wings', score: 83 },
  { _id: 'Portishead', score: 82 },
  { _id: 'The Crickets', score: 81 },
  { _id: 'The Ronettes', score: 79 },
  { _id: 'Diana Ross & The Supremes', score: 78 },
  { _id: 'Gram Parsons', score: 76 },
  { _id: 'Peter Wolf', score: 74 },
  { _id: 'Vampire Weekend', score: 71 },
  { _id: 'George Harrison', score: 68 },
  { _id: 'Lil Wayne', score: 64 },
  { _id: 'The Pogues', score: 61 },
  { _id: 'Suicide', score: 60 },
  { _id: 'DEVO', score: 59 },
  { _id: 'War', score: 57 },
  { _id: 'Steve Miller Band', score: 56 },
  { _id: 'Stan GetzÊ/ÊJoao GilbertoÊfeaturingÊAntonio Carlos Jobim', score: 54 },
  { _id: 'Amy Winehouse', score: 50 },
  { _id: 'John Prine', score: 49 },
  { _id: 'EPMD', score: 48 },
  { _id: 'Alice Cooper', score: 47 },
  { _id: 'Los Lobos', score: 46 },
  { _id: 'My Morning Jacket', score: 44 },
  { _id: 'The Drifters', score: 42 },
  { _id: 'Hole', score: 41 },
  { _id: 'Public Image Ltd.', score: 40 },
  { _id: 'Echo and The Bunnymen', score: 38 },
  { _id: 'Def Leppard', score: 37 },
  { _id: 'The Magnetic Fields', score: 36 },
  { _id: 'Coldplay', score: 35 },
  { _id: 'The Paul Butterfield Blues Band', score: 33 },
  { _id: 'Fugees', score: 32 },
  { _id: 'L.L. Cool J', score: 31 },
  { _id: 'George Michael', score: 29 },
  { _id: 'Manu Chao', score: 27 },
  { _id: 'Merle Haggard', score: 24 },
  { _id: 'Loretta Lynn', score: 23 },
  { _id: 'Raekwon', score: 21 },
  { _id: "D'Angelo", score: 20 },
  { _id: 'Steve Earle', score: 19 },
  { _id: 'Gang of Four', score: 18 },
  { _id: 'Earth, Wind & Fire', score: 15 },
  { _id: 'Cyndi Lauper', score: 14 },
  { _id: 'Husker Du', score: 13 },
  { _id: 'Albert King', score: 10 },
  { _id: 'Eurythmics', score: 9 },
  { _id: 'Wilco', score: 8 },
  { _id: 'MGMT', score: 7 },
  { _id: 'Boz Scaggs', score: 5 },
  { _id: 'The Stone Roses', score: 3 }
]
```

## Ejercicio 2
### Setup
Para establecer conexión con la base de datos corremos el comando:
```
:server connect
```
Ejecutar el próximo comando desde la interfaz web de Neo4J para generar la base de datos utilizando un sandbox en blanco
``` 
:play northwind-graph
```
Estos tres comandos cargan nuestra base de datos a traves de un LOAD CSV:
```
LOAD CSV WITH HEADERS FROM "https://data.neo4j.com/northwind/products.csv" AS row
CREATE (n:Product)
SET n = row,
n.unitPrice = toFloat(row.unitPrice),
n.unitsInStock = toInteger(row.unitsInStock), n.unitsOnOrder = toInteger(row.unitsOnOrder),
n.reorderLevel = toInteger(row.reorderLevel), n.discontinued = (row.discontinued <> "0");

LOAD CSV WITH HEADERS FROM "https://data.neo4j.com/northwind/categories.csv" AS row
CREATE (n:Category)
SET n = row;

LOAD CSV WITH HEADERS FROM "https://data.neo4j.com/northwind/suppliers.csv" AS row
CREATE (n:Supplier)
SET n = row;
```
Luego, corremos los siguientes dos comandos para cargar las relaciones de los datos subididos anteriormente:
```
MATCH (p:Product),(c:Category)
WHERE p.categoryID = c.categoryID
CREATE (p)-[:PART_OF]->(c)

MATCH (p:Product),(s:Supplier)
WHERE p.supplierID = s.supplierID
CREATE (s)-[:SUPPLIES]->(p)
```
#### Item A
Para saber la cantidad de productos hay en la base:
```
MATCH (n: Product) RETURN count(n)
```
Nos retorna que hay 77 productos en la base.
#### Item B
Para saber cuánto cuesta el "Queso Cabrales" corrimos el siguiente 
```
MATCH (n: Product {productName: "Queso Cabrales"}) RETURN n.unitPrice
```
El “Queso Cabrales” cuesta 21.0.
#### Item C
Para saber cuántos productos pertenecen a la categoría “Condiments” utilizamos el comando:
```
MATCH (p: Product)-[r:PART_OF]->(c:Category {categoryName: "Condiments"}) RETURN count(p)
```
Hay 12 productos de la categoría “Condiments”
#### Item D
Para saber del conjunto de productos que ofrecen los proveedores de “UK”, cuál es el
nombre y el precio unitario de los tres productos más caros corrimos el siguiente comando:
```
MATCH (s: Supplier)-[r:SUPPLIES]->(p: Product) WHERE s.country='UK' RETURN p.productName, p.unitPrice ORDER BY p.unitPrice DESC LIMIT 3
```
| Nombre | Precio Unitario |
| --- | --- |
| Chang | 19.0 |
| Chai | 18.0 |
| Aniseed Syrup | 10.0 |

## Ejercicio 3
### Setup
Crear la imagen de docker:
```
docker pull redis;
docker run --name Myredis -p 6379:6379 -d redis;
docker cp bataxi.csv Myredis:/data/bataxi.csv;
docker cp import_geoadd.sh Myredis:/data/import_geoadd.sh;
```
Ingresar al contenedor de Docker:
```
docker exec -it Myredis bash
```

Importar los datos del archivo csv utilizando el script:
```
chmod +x import_geoadd.sh
./import_geoadd.sh
```

#### Item B
Cuantos viajes se generaron a menos de 1 km de estos lugares:
- Para Parque Chas:
```
redis-cli GEORADIUS bataxi -58.479258 -34.582497 1 km | wc -l
```
Resultado: 339

- Para UTN:
```
redis-cli GEORADIUS bataxi -58.468606 -34.658304 1 km | wc -l
```
Resultado: 9

- Para ITBA Madero:
```
redis-cli GEORADIUS bataxi -58.367862 -34.602938 1 km | wc -l
```
Resultado: 242

#### Item C
Cantidad de keys en la base de datos:
```
redis-cli DBSIZE
```
Resultado: 1

#### Item D
Cantidad de miembros de 'bataxi'
```
redis-cli ZCARD bataxi
```
Resultado: 19148

#### Item E
El comando GEOADD de Redis trabaja sobre la estructura de datos Sorted Set (conjunto ordenado)