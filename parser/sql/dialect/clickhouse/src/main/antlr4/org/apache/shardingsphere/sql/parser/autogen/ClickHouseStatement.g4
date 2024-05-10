grammar ClickHouseStatement;

import DMLStatement,Comments;

execute
    : (select
    | insert
    ) (SEMI_ EOF? | EOF)
    | EOF
    ;