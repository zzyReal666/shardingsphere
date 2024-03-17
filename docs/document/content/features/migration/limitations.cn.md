+++
title = "使用限制"
weight = 2
+++

## 支持项

* 将外围数据迁移至 Apache ShardingSphere 所管理的数据库；
* 目标端 proxy 不配置规则或配置任意规则；
* 迁移单字段主键或唯一键的表，首字段类型：整型、字符型、部分二进制类型（比如 MySQL VARBINARY）；
* 迁移复合主键或复合唯一键的表。

## 不支持项

* 不支持在当前存储节点之上做迁移，需要准备一个全新的数据库集群作为迁移目标库；
* 不支持目标端 proxy 使用 HINT 分片策略；
* 不支持目标端表结构和源端不一致；
* 不支持迁移过程中源端表结构变更。