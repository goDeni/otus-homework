docker exec -it mongo_1_config_server sh -c "mongo --eval \"rs.initiate(); rs.add('mongo_2_config_server'); rs.add('mongo_3_config_server')\""


docker exec -it shard_1_replica_0 sh -c "mongo --eval \"rs.initiate(); rs.add('shard_1_replica_1'); rs.add('shard_1_replica_2')\""
docker exec -it shard_2_replica_0 sh -c "mongo --eval \"rs.initiate(); rs.add('shard_2_replica_1'); rs.add('shard_2_replica_2')\""
docker exec -it shard_3_replica_0 sh -c "mongo --eval \"rs.initiate(); rs.add('shard_3_replica_1'); rs.add('shard_3_replica_2')\""

sleep 10

docker exec -it sharded_cluster sh -c "mongo --eval \"sh.addShard('shard1/shard_1_replica_0:27017,shard_1_replica_1:27017,shard_1_replica_2:27017')\""
docker exec -it sharded_cluster sh -c "mongo --eval \"sh.addShard('shard2/shard_2_replica_0:27017,shard_2_replica_1:27017,shard_2_replica_2:27017')\""
docker exec -it sharded_cluster sh -c "mongo --eval \"sh.addShard('shard3/shard_3_replica_0:27017,shard_3_replica_1:27017,shard_3_replica_2:27017')\""