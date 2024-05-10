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

lexer grammar Literals;

import Alphabet, Symbol;


IDENTIFIER
    : (LETTER | UNDERSCORE) (LETTER | UNDERSCORE | DEC_DIGIT)*
    | BACKQUOTE ( ~([\\`]) | (BACKSLASH .) | (BACKQUOTE BACKQUOTE) )* BACKQUOTE
    | QUOTE_DOUBLE ( ~([\\"]) | (BACKSLASH .) | (QUOTE_DOUBLE QUOTE_DOUBLE) )* QUOTE_DOUBLE
    ;
FLOATING_LITERAL
    : HEXADECIMAL_LITERAL DOT HEX_DIGIT* (P | E) (PLUS | DASH)? DEC_DIGIT+
    | HEXADECIMAL_LITERAL (P | E) (PLUS | DASH)? DEC_DIGIT+
    | DECIMAL_LITERAL DOT DEC_DIGIT* E (PLUS | DASH)? DEC_DIGIT+
    | DOT DECIMAL_LITERAL E (PLUS | DASH)? DEC_DIGIT+
    | DECIMAL_LITERAL E (PLUS | DASH)? DEC_DIGIT+
    ;
OCTAL_LITERAL: '0' OCT_DIGIT+;
DECIMAL_LITERAL: DEC_DIGIT+;
HEXADECIMAL_LITERAL: '0' X HEX_DIGIT+;

// It's important that quote-symbol is a single character.
STRING_LITERAL: QUOTE_SINGLE ( ~([\\']) | (BACKSLASH .) | (QUOTE_SINGLE QUOTE_SINGLE) )* QUOTE_SINGLE;

