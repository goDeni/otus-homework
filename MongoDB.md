# MongoDB

**Цель**: В результате выполнения ДЗ вы научитесь разворачивать MongoDB, заполнять данными и делать запросы.

**Рекомендации  перед выполнением**: Рекомендуется выполнять работу на linux системе.



## Запуск MongoDB с помощью docker

Для запуска необходимо выполнить следующую команду:

```bash
$ docker run --name some-mongo -d mongo:4.4.1
```

Команда для перехода в командный интерфейс mongo:

```bash
$ docker exec -it some-mongo mongo
```



## Выполнение запросов в MongoDB 

### Наполнение данными

Перед тем как выполнять запросы необходимо наполнить БД данными, для этого необходимо скачать необходимую коллекцию, скопировать в контейнер и импортировать:

```bash
$ wget https://raw.githubusercontent.com/prust/wikipedia-movie-data/master/movies.json -O collection.json
$ docker cp collection.json some-mongo:/collection.json
$ docker exec -it some-mongo sh -c "mongoimport --db=example-db --collection=movies --file=collection.json --jsonArray"
```

### Выполнение запросов

Заходим в контейнер с mongodb:

```bash
$ docker exec -it some-mongo mongo
```

Вывод списка БД:

```
> db.adminCommand( { listDatabases: 1 } )
{
        "databases" : [
                {
                        "name" : "admin",
                        "sizeOnDisk" : 40960,
                        "empty" : false
                },
                {
                        "name" : "config",
                        "sizeOnDisk" : 73728,
                        "empty" : false
                },
                {
                        "name" : "example-db",
                        "sizeOnDisk" : 2437120,
                        "empty" : false
                },
                {
                        "name" : "local",
                        "sizeOnDisk" : 40960,
                        "empty" : false
                },
                {
                        "name" : "test",
                        "sizeOnDisk" : 40960,
                        "empty" : false
                }
        ],
        "totalSize" : 253952,
        "ok" : 1
}
```

В списке можно увидеть ранее импортированную БД "example-db", выберем её:

```
> use example-db
```

Сделаем простой запрос на получение 10 фильмов

```
> db.movies.find().limit(10)
{ "_id" : ObjectId("5f8a7d4e2235e0b2ea34013d"), "title" : "Feeding Sea Lions", "year" : 1900, "cast" : [ "Paul Boyton" ], "genres" : [ ] }
{ "_id" : ObjectId("5f8a7d4e2235e0b2ea34013e"), "title" : "How to Make a Fat Wife Out of Two Lean Ones", "year" : 1900, "cast" : [ ], "genres" : [ "Comedy" ] }
{ "_id" : ObjectId("5f8a7d4e2235e0b2ea34013f"), "title" : "New Life Rescue", "year" : 1900, "cast" : [ ], "genres" : [ ] }
{ "_id" : ObjectId("5f8a7d4e2235e0b2ea340140"), "title" : "New Morning Bath", "year" : 1900, "cast" : [ ], "genres" : [ ] }
{ "_id" : ObjectId("5f8a7d4e2235e0b2ea340141"), "title" : "Caught", "year" : 1900, "cast" : [ ], "genres" : [ ] }
{ "_id" : ObjectId("5f8a7d4e2235e0b2ea340142"), "title" : "Searching Ruins on Broadway, Galveston, for Dead Bodies", "year" : 1900, "cast" : [ ], "genres" : [ ] }
{ "_id" : ObjectId("5f8a7d4e2235e0b2ea340143"), "title" : "The Tribulations of an Amateur Photographer", "year" : 1900, "cast" : [ ], "genres" : [ ] }
{ "_id" : ObjectId("5f8a7d4e2235e0b2ea340144"), "title" : "Trouble in Hogan's Alley", "year" : 1900, "cast" : [ ], "genres" : [ "Comedy" ] }
{ "_id" : ObjectId("5f8a7d4e2235e0b2ea340145"), "title" : "Two Old Sparks", "year" : 1900, "cast" : [ ], "genres" : [ "Short" ] }
{ "_id" : ObjectId("5f8a7d4e2235e0b2ea340146"), "title" : "The Wonder, Ching Ling Foo", "year" : 1900, "cast" : [ "Ching Ling Foo" ], "genres" : [ "Short" ] }
```

Запрос на 10 фильмов в которых снимался "Leonardo DiCaprio":

```
> db.movies.find({"cast": { $in: ["Leonardo DiCaprio"]}}).limit(10)
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea3458c7"), "title" : "This Boy's Life", "year" : 1993, "cast" : [ "Robert De Niro", "Ellen Barkin", "Leonardo DiCaprio" ], "genres" : [ "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea3458d9"), "title" : "What's Eating Gilbert Grape", "year" : 1993, "cast" : [ "Johnny Depp", "Juliette Lewis", "Leonardo DiCaprio" ], "genres" : [ "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea345941"), "title" : "The Foot Shooting Party", "year" : 1994, "cast" : [ "Leonardo DiCaprio" ], "genres" : [ "Short" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea345a3e"), "title" : "The Basketball Diaries", "year" : 1995, "cast" : [ "Leonardo DiCaprio", "Lorraine Bracco" ], "genres" : [ "Biography" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea345aee"), "title" : "The Quick and the Dead", "year" : 1995, "cast" : [ "Sharon Stone", "Russell Crowe", "Gene Hackman", "Leonardo DiCaprio" ], "genres" : [ "Western" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea345c1d"), "title" : "Marvin's Room", "year" : 1996, "cast" : [ "Meryl Streep", "Diane Keaton", "Leonardo DiCaprio", "Robert De Niro" ], "genres" : [ "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea345c57"), "title" : "Romeo + Juliet", "year" : 1996, "cast" : [ "Leonardo DiCaprio", "Claire Danes", "Brian Dennehy", "John Leguizamo", "Pete Postlethwaite", "Paul Sorvino", "Diane Venora" ], "genres" : [ "Romance", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea345deb"), "title" : "Titanic", "year" : 1997, "cast" : [ "Leonardo DiCaprio", "Kate Winslet", "Billy Zane", "Frances Fisher", "Victor Garber", "Kathy Bates", "Bill Paxton", "Gloria Stuart", "David Warner", "Suzy Amis" ], "genres" : [ "Historical", "Disaster" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea345e36"), "title" : "Celebrity", "year" : 1998, "cast" : [ "Kenneth Branagh", "Judy Davis", "Bebe Neuwirth", "Charlize Theron", "Leonardo DiCaprio" ], "genres" : [ "Comedy" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea345e8f"), "title" : "The Man in the Iron Mask", "year" : 1998, "cast" : [ "Leonardo DiCaprio", "John Malkovich", "Gabriel Byrne", "Gérard Depardieu", "Jeremy Irons" ], "genres" : [ "Drama" ] }
```



Запрос на 100 фильмов с 2000 года включительно по 2002 год включительно, с жанрами "Comedy" и "Drama":

```
> db.movies.find({"year": { $gte: 2000, $lte: 2002}, "genres": { $all: ["Comedy", "Drama"] }}).limit(100)
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea345fe7"), "title" : "Almost Famous", "year" : 2000, "cast" : [ "Billy Crudup", "Frances McDormand", "Kate Hudson", "Jason Lee", "Patrick Fugit", "Anna Paquin", "Fairuza Balk" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea345ff4"), "title" : "Beautiful Joe", "year" : 2000, "cast" : [ "Sharon Stone", "Billy Connolly" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea3460ad"), "title" : "Where the Heart Is", "year" : 2000, "cast" : [ "Natalie Portman", "Ashley Judd", "Stockard Channing", "Joan Cusack", "Keith David", "Sally Field" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea3460b3"), "title" : "Wonder Boys", "year" : 2000, "cast" : [ "Michael Douglas", "Tobey Maguire", "Frances McDormand", "Katie Holmes", "Robert Downey, Jr." ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea3460c6"), "title" : "The Anniversary Party", "year" : 2001, "cast" : [ "Alan Cumming", "Jennifer Jason Leigh", "Kevin Kline" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea3460d2"), "title" : "Bartleby", "year" : 2001, "cast" : [ "David Paymer", "Crispin Glover", "Glenne Headly" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea3460e7"), "title" : "Cruel Intentions 2", "year" : 2001, "cast" : [ "Robin Dunne", "Sarah Thompson", "Keri Lynn Pratt", "Amy Adams" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea34619b"), "title" : "Adaptation.", "year" : 2002, "cast" : [ "Nicolas Cage", "Meryl Streep", "Chris Cooper" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea34619e"), "title" : "About Schmidt", "year" : 2002, "cast" : [ "Jack Nicholson", "Kathy Bates", "Hope Davis", "Len Cariou", "Dermot Mulroney", "June Squibb" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea3461a9"), "title" : "13 Moons", "year" : 2002, "cast" : [ "Jennifer Beals", "Elizabeth Bracco", "Steve Buscemi" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea3461aa"), "title" : "About a Boy", "year" : 2002, "cast" : [ "Hugh Grant", "Nicholas Hoult", "Toni Collette" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea3461c1"), "title" : "Catch Me If You Can", "year" : 2002, "cast" : [ "Leonardo DiCaprio", "Tom Hanks", "Christopher Walken", "Amy Adams", "Martin Sheen", "Nathalie Baye", "James Brolin" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea3461d4"), "title" : "The Dangerous Lives of Altar Boys", "year" : 2002, "cast" : [ "Emile Hirsch", "Kieran Culkin", "Jena Malone" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea3461d8"), "title" : "Crossroads", "year" : 2002, "cast" : [ "Britney Spears", "Anson Mount", "Zoe Saldana", "Taryn Manning", "Kim Cattrall", "Dan Aykroyd" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea3461ff"), "title" : "Igby Goes Down", "year" : 2002, "cast" : [ "Kieran Culkin", "Claire Danes", "Jeff Goldblum", "Susan Sarandon" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea346205"), "title" : "Interstate 60", "year" : 2002, "cast" : [ "James Marsden", "Gary Oldman", "Amy Smart" ], "genres" : [ "Comedy", "Drama" ] }
{ "_id" : ObjectId("5f8a7d4f2235e0b2ea346237"), "title" : "Punch-Drunk Love", "year" : 2002, "cast" : [ "Adam Sandler", "Emily Watson", "Philip Seymour Hoffman", "Luis Guzmán" ], "genres" : [ "Comedy", "Drama" ] }
```

Запрос на количество фильмов снятых в 1990 году:

```
> db.movies.count({"year": 1990})
269
```

Запрос на количество фильмов с жаром "Comedy "и с жанром только "Comedy "

```
> db.movies.count({"genres": { $in: ["Comedy"] }})
7363
> db.movies.count({"genres": ["Comedy"] })
5120
```

Запрос на удаление фильмов где жанр только "Comedy"

```
> db.movies.deleteMany({"genres": ["Comedy"] })
{ "acknowledged" : true, "deletedCount" : 5120 }
> db.movies.count({"genres": ["Comedy"] })
0
> db.movies.count({"genres": { $in: ["Comedy"] }})
2243
```

Запрос на добавление к фильму  жанра "Comedy":

```
> db.movies.find({"title": "Beef Extract Room"})
{ "_id" : ObjectId("5f8a7d4e2235e0b2ea34014e"), "title" : "Beef Extract Room", "year" : 1901, "cast" : [ ], "genres" : [ ] }
> db.movies.updateOne({"title": "Beef Extract Room"}, {$push: {"genres": "Comedy"}})
{ "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1 }
> db.movies.find({"title": "Beef Extract Room"})
{ "_id" : ObjectId("5f8a7d4e2235e0b2ea34014e"), "title" : "Beef Extract Room", "year" : 1901, "cast" : [ ], "genres" : [ "Comedy" ] }
```

Запрос на добавление фильма:

```
> db.movies.insert({"title": "Example Movie", "year": 2020, "cast": [], "genres": []})
WriteResult({ "nInserted" : 1 })
> db.movies.find({"title": "Example Movie"})
{ "_id" : ObjectId("5f8a85f4673baf527c48412b"), "title" : "Example Movie", "year" : 2020, "cast" : [ ], "genres" : [ ] }
```



