# Redis Sentinel Cluster
## Master-Slave Sentinel Mode
```shell
docker-compose -f docker-compose.sentinel.yml up -d
```

## AA Cluster Sentinel Mode
```shell
docker-compose -f docker-compose.cluster.yml up -d
./setup-cluster.sh
```