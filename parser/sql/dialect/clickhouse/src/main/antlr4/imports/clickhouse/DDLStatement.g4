grammar DDLStatement;

import DMLStatement;



createStmt
    : (ATTACH | CREATE) DATABASE (IF NOT EXISTS)? databaseIdentifier clusterClause? engineExpr?                                                                                       # CreateDatabaseStmt
    | (ATTACH | CREATE (OR REPLACE)? | REPLACE) DICTIONARY (IF NOT EXISTS)? tableIdentifier uuidClause? clusterClause?                                          # CreateDictionaryStmt
    | (ATTACH | CREATE) LIVE VIEW (IF NOT EXISTS)? tableIdentifier uuidClause? clusterClause? (WITH TIMEOUT DECIMAL_LITERAL?)? destinationClause? tableSchemaClause? subqueryClause   # CreateLiveViewStmt
    | (ATTACH | CREATE) MATERIALIZED VIEW (IF NOT EXISTS)? tableIdentifier uuidClause? clusterClause? tableSchemaClause? (destinationClause ) subqueryClause  # CreateMaterializedViewStmt
    | (ATTACH | CREATE (OR REPLACE)? | REPLACE) TEMPORARY? TABLE (IF NOT EXISTS)? tableIdentifier uuidClause? clusterClause? tableSchemaClause?  subqueryClause?                                 # CreateTableStmt
    | (ATTACH | CREATE) (OR REPLACE)? VIEW (IF NOT EXISTS)? tableIdentifier uuidClause? clusterClause? tableSchemaClause? subqueryClause                                              # CreateViewStmt
    ;
dictionaryPrimaryKeyClause: PRIMARY KEY columnExprList;
dictionaryArgExpr: identifier (identifier (LPAREN RPAREN)? | literal);
sourceClause: SOURCE LPAREN identifier LPAREN dictionaryArgExpr* RPAREN RPAREN;
lifetimeClause: LIFETIME LPAREN ( DECIMAL_LITERAL
                                | MIN DECIMAL_LITERAL MAX DECIMAL_LITERAL
                                | MAX DECIMAL_LITERAL MIN DECIMAL_LITERAL
                                ) RPAREN;
layoutClause: LAYOUT LPAREN identifier LPAREN dictionaryArgExpr* RPAREN RPAREN;
rangeClause: RANGE LPAREN (MIN identifier MAX identifier | MAX identifier MIN identifier) RPAREN;
dictionarySettingsClause: SETTINGS LPAREN settingExprList RPAREN;

clusterClause: ON CLUSTER (identifier | STRING_LITERAL);
uuidClause: UUID STRING_LITERAL;
destinationClause: TO tableIdentifier;
subqueryClause: AS selectUnionStmt;
tableSchemaClause
    : LPAREN tableElementExpr (COMMA tableElementExpr)* RPAREN  # SchemaDescriptionClause
    | AS tableIdentifier                                        # SchemaAsTableClause
    | AS tableFunctionExpr                                      # SchemaAsFunctionClause
    ;

partitionByClause: PARTITION BY columnExpr;
primaryKeyClause: PRIMARY KEY columnExpr;
sampleByClause: SAMPLE BY columnExpr;
ttlClause: TTL ttlExpr (COMMA ttlExpr)*;

engineExpr: ENGINE EQ_SINGLE? identifierOrNull (LPAREN columnExprList? RPAREN)?;
tableElementExpr
    : tableColumnDfnt                                                              # TableElementExprColumn
    | CONSTRAINT identifier CHECK columnExpr                                       # TableElementExprConstraint
    | INDEX tableIndexDfnt                                                         # TableElementExprIndex
    | PROJECTION tableProjectionDfnt                                               # TableElementExprProjection
    ;
tableColumnDfnt
    : nestedIdentifier columnTypeExpr tableColumnPropertyExpr? (COMMENT STRING_LITERAL)? codecExpr? (TTL columnExpr)?
    | nestedIdentifier columnTypeExpr? tableColumnPropertyExpr (COMMENT STRING_LITERAL)? codecExpr? (TTL columnExpr)?
    ;
tableColumnPropertyExpr: (DEFAULT | MATERIALIZED | ALIAS) columnExpr;
tableIndexDfnt: nestedIdentifier columnExpr TYPE columnTypeExpr GRANULARITY DECIMAL_LITERAL;
tableProjectionDfnt: nestedIdentifier projectionSelectStmt;
codecExpr: CODEC LPAREN codecArgExpr (COMMA codecArgExpr)* RPAREN;
codecArgExpr: identifier (LPAREN columnExprList? RPAREN)?;
ttlExpr: columnExpr (DELETE | TO DISK STRING_LITERAL | TO VOLUME STRING_LITERAL)?;

// PROJECTION SELECT statement

projectionSelectStmt:
    LPAREN
    withClause?
    SELECT columnExprList
    groupByClause?
    projectionOrderByClause?
    RPAREN
    ;
