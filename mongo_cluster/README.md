
```
> docker-compose up -d
```
Настройка репликации сервера конфигурации:
```
> docker exec -it mongo_1_config_server sh -c "mongo --eval \"rs.initiate(); rs.add('mongo_2_config_server'); rs.add('mongo_3_config_server')\""
```

Настройка шардов:
```
> docker exec -it shard_1_replica_0 sh -c "mongo --eval \"rs.initiate(); rs.add('shard_1_replica_1'); rs.add('shard_1_replica_2')\""
> docker exec -it shard_2_replica_0 sh -c "mongo --eval \"rs.initiate(); rs.add('shard_2_replica_1'); rs.add('shard_2_replica_2')\""
> docker exec -it shard_3_replica_0 sh -c "mongo --eval \"rs.initiate(); rs.add('shard_3_replica_1'); rs.add('shard_3_replica_2')\""
```

Подключение шардов к кластеру (выполнять только после того как сервер полностью запустился):
```
> docker exec -it sharded_cluster sh -c "mongo --eval \"sh.addShard('shard1/shard_1_replica_0:27017,shard_1_replica_1:27017,shard_1_replica_2:27017')\""
> docker exec -it sharded_cluster sh -c "mongo --eval \"sh.addShard('shard2/shard_2_replica_0:27017,shard_2_replica_1:27017,shard_2_replica_2:27017')\""
> docker exec -it sharded_cluster sh -c "mongo --eval \"sh.addShard('shard3/shard_3_replica_0:27017,shard_3_replica_1:27017,shard_3_replica_2:27017')\""
```

Наполнение данными
```
wget https://raw.githubusercontent.com/prust/wikipedia-movie-data/master/movies.json -O collection.json
docker cp collection.json sharded_cluster:/collection.json
docker exec -it sharded_cluster sh -c "mongoimport --db=example-db --collection=movies --file=collection.json --jsonArray"
```

Включение шардирования
```
docker exec -it sharded_cluster sh -c "mongo --eval \"sh.enableSharding('example-db')\""

sh.shardCollection(
    'example-db.movies'
)
```