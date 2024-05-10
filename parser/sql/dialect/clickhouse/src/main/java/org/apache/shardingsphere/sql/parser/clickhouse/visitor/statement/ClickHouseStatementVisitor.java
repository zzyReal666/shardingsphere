package org.apache.shardingsphere.sql.parser.clickhouse.visitor.statement;

import lombok.AccessLevel;
import lombok.Getter;
import org.apache.shardingsphere.sql.parser.api.ASTNode;
import org.apache.shardingsphere.sql.parser.autogen.ClickHouseStatementBaseVisitor;

import org.apache.shardingsphere.sql.parser.sql.common.segment.generic.ParameterMarkerSegment;

import java.util.Collection;
import java.util.LinkedList;

/**
 * @author zzypersonally@gmail.com
 * @description
 * @since 2024/5/7 16:03
 */
@Getter(AccessLevel.PROTECTED)
public abstract class ClickHouseStatementVisitor extends ClickHouseStatementBaseVisitor<ASTNode> {

    private final Collection<ParameterMarkerSegment> parameterMarkerSegments = new LinkedList<>();



}
