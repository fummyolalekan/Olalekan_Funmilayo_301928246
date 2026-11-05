# Portfolio 5 Distributed and Cloud Database Exercise

## Current setup

The work completed in Portfolio 4 uses a local MongoDB deployment accessed through `mongosh`. The database is `fashion_accessories_portfolio` and the collection is `activity_events`. Four fictional event documents were inserted, representing the event types `ORDER_CREATED` and `PAYMENT_RECORDED`.

The actual MongoDB topology is not verified by the supplied files. The files show a local MongoDB instance, but they do not confirm replication, sharding, multiple servers, or cloud deployment. Therefore, no existing distributed deployment is assumed.

## Proposed replication

A possible production deployment for the `activity_events` collection is a MongoDB replica set with three voting data-bearing members located in separate failure zones. MongoDB replica sets provide redundancy and automatic failover. ([MongoDB Replication](https://www.mongodb.com/docs/manual/replication/))

| Member | Starting role | Location |
|----------|-------------|----------|
| Member 1 | Primary | Availability Zone A |
| Member 2 | Secondary | Availability Zone B |
| Member 3 | Secondary | Availability Zone C |

For example, an `ORDER_CREATED` event could be written to the primary member and then replicated to both secondary members. The data is copied to multiple servers so that service can continue if one server becomes unavailable.

## Failure and consistency

If the primary server fails, the remaining voting members can elect a new primary when a majority is available. During the election process, writes may be briefly interrupted until a new primary is selected. ([Replica Set Elections](https://www.mongodb.com/docs/v8.0/core/replica-set-elections/))

If a majority of voting members is unavailable, a new primary cannot be elected, and write operations cannot continue. Reads may still be available from existing secondary members depending on configuration.

For stronger consistency, the application could use majority write acknowledgement. In this approach, MongoDB confirms a write only after the majority of replica set members have recorded it. ([Write Concern](https://www.mongodb.com/docs/v8.0/reference/write-concern/))

Secondary members may temporarily lag behind the primary, so recently committed events might not appear immediately on every secondary server.

## Sharding and cloud deployment

Replication copies data between servers for availability, while sharding splits data across multiple servers to distribute storage and workload. These solve different problems. ([MongoDB Sharding](https://www.mongodb.com/docs/manual/sharding/))

The Portfolio 4 example contains only four event records and does not require sharding. However, a large ecommerce platform storing millions of activity events could shard documents using an event or customer identifier.

In a cloud deployment such as MongoDB Atlas, authentication, encryption, and restricted network access should be enabled to protect customer and order information. Regular backup and restore procedures should also be configured. ([MongoDB Atlas Backup and Restore](https://www.mongodb.com/docs/atlas/backup-restore-cluster/))

A cloud deployment introduces operational costs for storage, backups, data transfer, and computing resources. A further limitation is that MongoDB replication only replicates MongoDB data. It does not replicate the PostgreSQL database from the earlier portfolios and does not automatically synchronise the two systems.

## References

- MongoDB Replication: https://www.mongodb.com/docs/manual/replication/
- MongoDB Replica Set Elections: https://www.mongodb.com/docs/v8.0/core/replica-set-elections/
- MongoDB Write Concern: https://www.mongodb.com/docs/v8.0/reference/write-concern/
- MongoDB Sharding: https://www.mongodb.com/docs/manual/sharding/
- MongoDB Atlas Backup and Restore: https://www.mongodb.com/docs/atlas/backup-restore-cluster/