/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

grammar BaseRule;

import Comments, Symbol, Keyword, Keyword, Literals;


// Basics

floatingLiteral
    : FLOATING_LITERAL
    | DOT (DECIMAL_LITERAL | OCTAL_LITERAL)
    | DECIMAL_LITERAL DOT (DECIMAL_LITERAL | OCTAL_LITERAL)?  // can't move this to the lexer or it will break nested tuple access: t.1.2
    ;
numberLiteral: (PLUS | DASH)? (floatingLiteral | OCTAL_LITERAL | DECIMAL_LITERAL | HEXADECIMAL_LITERAL | INF | NAN_SQL);
literal
    : numberLiteral
    | STRING_LITERAL
    | NULL_SQL
    ;
interval: SECOND | MINUTE | HOUR | DAY | WEEK | MONTH | QUARTER | YEAR;
keyword
    // except NULL_SQL, INF, NAN_SQL
    : AFTER | ALIAS | ALL | ALTER | AND | ANTI | ANY | ARRAY | AS | ASCENDING | ASOF | AST | ASYNC | ATTACH | BETWEEN | BOTH | BY | CASE
    | CAST | CHECK | CLEAR | CLUSTER | CODEC | COLLATE | COLUMN | COMMENT | CONSTRAINT | CREATE | CROSS | CUBE | CURRENT | DATABASE
    | DATABASES | DATE | DEDUPLICATE | DEFAULT | DELAY | DELETE | DESCRIBE | DESC | DESCENDING | DETACH | DICTIONARIES | DICTIONARY | DISK
    | DISTINCT | DISTRIBUTED | DROP | ELSE | END | ENGINE | EVENTS | EXISTS | EXPLAIN | EXPRESSION | EXTRACT | FETCHES | FINAL | FIRST
    | FLUSH | FOR | FOLLOWING | FOR | FORMAT | FREEZE | FROM | FULL | FUNCTION | GLOBAL | GRANULARITY | GROUP | HAVING | HIERARCHICAL | ID
    | IF | ILIKE | IN | INDEX | INJECTIVE | INNER | INSERT | INTERVAL | INTO | IS | IS_OBJECT_ID | JOIN | JSON_FALSE | JSON_TRUE | KEY
    | KILL | LAST | LAYOUT | LEADING | LEFT | LIFETIME | LIKE | LIMIT | LIVE | LOCAL | LOGS | MATERIALIZE | MATERIALIZED | MAX | MERGES
    | MIN | MODIFY | MOVE | MUTATION | NO | NOT | NULLS | OFFSET | ON | OPTIMIZE | OR | ORDER | OUTER | OUTFILE | OVER | PARTITION
    | POPULATE | PRECEDING | PREWHERE | PRIMARY | RANGE | RELOAD | REMOVE | RENAME | REPLACE | REPLICA | REPLICATED | RIGHT | ROLLUP | ROW
    | ROWS | SAMPLE | SELECT | SEMI | SENDS | SET | SETTINGS | SHOW | SOURCE | START | STOP | SUBSTRING | SYNC | SYNTAX | SYSTEM | TABLE
    | TABLES | TEMPORARY | TEST | THEN | TIES | TIMEOUT | TIMESTAMP | TOTALS | TRAILING | TRIM | TRUNCATE | TO | TOP | TTL | TYPE
    | UNBOUNDED | UNION | UPDATE | USE | USING | UUID | VALUES | VIEW | VOLUME | WATCH | WHEN | WHERE | WINDOW | WITH
    ;
keywordForAlias
    : DATE | FIRST | ID | KEY
    ;
alias: IDENTIFIER | keywordForAlias;  // |interval| can't be an alias, otherwise 'INTERVAL 1 SOMETHING' becomes ambiguous.
identifier: IDENTIFIER | interval | keyword;
identifierOrNull: identifier | NULL_SQL;  // NULL_SQL can be only 'Null' here.
enumValue: STRING_LITERAL EQ_SINGLE numberLiteral;


// Databases
databaseIdentifier: identifier;