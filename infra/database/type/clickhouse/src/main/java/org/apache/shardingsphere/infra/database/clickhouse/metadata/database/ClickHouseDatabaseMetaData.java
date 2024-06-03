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

package org.apache.shardingsphere.infra.database.clickhouse.metadata.database;

import org.apache.shardingsphere.infra.database.core.metadata.database.DialectDatabaseMetaData;
import org.apache.shardingsphere.infra.database.core.metadata.database.enums.NullsOrderType;
import org.apache.shardingsphere.infra.database.core.metadata.database.enums.QuoteCharacter;

import java.sql.Types;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

/**
 * Database meta data of ClickHouse.
 */
public final class ClickHouseDatabaseMetaData implements DialectDatabaseMetaData {

    private static final Set<String> RESERVED_WORDS = new HashSet<>(Collections.emptyList());

    @Override
    public QuoteCharacter getQuoteCharacter() {
        return QuoteCharacter.SINGLE_QUOTE;
    }
    
    @Override
    public NullsOrderType getDefaultNullsOrderType() {
        return NullsOrderType.FIRST;
    }
    
    @Override
    public boolean isReservedWord(final String identifier) {
        return RESERVED_WORDS.contains(identifier.toUpperCase());
    }
    
    @Override
    public boolean isInstanceConnectionAvailable() {
        return true;
    }
    
    @Override
    public boolean isSupportThreeTierStorageStructure() {
        return true;
    }
    
    @Override
    public String getDatabaseType() {
        return "ClickHouse";
    }
}
