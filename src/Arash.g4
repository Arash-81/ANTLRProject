grammar Arash;
//Arash Gholamdokht 9922762286

start: importDecl* classDecl+;

importDecl: ID ASSIGN REQUIRE LANGLE ID RANGLE SEMI |
ID (COMMA ID)* ASSIGN FROM LANGLE ID RANGLE REQUIRE LANGLE ID RANGLE
(FROM LANGLE ID RANGLE REQUIRE LANGLE ID RANGLE)* SEMI |
ID ASSIGN FROM LANGLE ID RANGLE '=>' LANGLE ID RANGLE SEMI;

classDecl: CLASS ID (LPAREN ID RPAREN)? (IMPLEMENTS ID (COMMA ID)*)? classBody;
classBody: BEGIN classBodyDeclaration+ END;

classBodyDeclaration: constructorDecl | classMemberDecl | functionDecl;
constructorDecl: ID LPAREN (DataTypeList ID (COMMA DataTypeList ID)*)? RPAREN constructorBody;
constructorBody: BEGIN (THIS DOT ID ASSIGN ID SEMI)+ END;

classMemberDecl: AccessLevel? CONST? DataTypeList (variableDeclaratorList | arrayDecl) SEMI;
variableDeclaratorList:	variableDeclarator (',' variableDeclarator)*;
variableDeclarator: ID (ASSIGN literal)?;
arrayDecl: ID LBRACK RBRACK (ASSIGN NEW DataTypeList LBRACK IntegerLiteral RBRACK)?;

functionDecl: AccessLevel? (DataTypeList | VOID) ID LPAREN parameters RPAREN statementBlock;
parameters: parameter optionalParameter;
parameter: DataTypeList ID (COMMA DataTypeList ID)*;
optionalParameter: DataTypeList ID ASSIGN literal (COMMA DataTypeList ID ASSIGN literal)*;


statementBlock: BEGIN statement+ END;
statement: assignment | ifStatement | forStatement | whileStatement | switchCase | exception | print | return;

assignment:	leftHandSide assignmentOperator expression;
leftHandSide:	expressionName | arrayAccess;
assignmentOperator:	'=' |	'*=' |	'/=' | '%=' | '+=' |	'-=' |	'<<=' |	'>>=' | '>>>=' | '&=' | '^=' | '|=';

conditionalExpression: conditionalOrExpression | conditionalOrExpression '?' expression ':' conditionalExpression;

expressionName:	ID |	ambiguousName '.' ID;
ambiguousName:	ID |	ambiguousName '.' ID;


literal:	IntegerLiteral |	DoubleLiteral |	BooleanLiteral |	CharacterLiteral |	StringLiteral | NullLiteral;

//fragments
fragment NonZeroDigit: [1-9];
fragment Digit: [0-9];
fragment Letter: [a-zA-Z];
fragment Sign: [+-];

//Literals
DoubleLiteral: Sign? NonZeroDigit Digit;
IntegerLiteral: Sign? ('0' | NonZeroDigit Digit*);
ScientificNotation: (Sign)? Digit? DOT Digit* [eE] Sign Digit* ;
BooleanLiteral: 'true' | 'false';
CharacterLiteral: '\'' ~['\\\r\n] '\'';
StringLiteral: '"' ~["\\\r\n]* '"';
NullLiteral: 'Null';

// Keywords
DataTypeList: 'int' | 'double' | 'bool' | 'string' | 'char';
AccessLevel: 'private' | 'public';
REQUIRE: 'require';
BEGIN: 'begin';
END: 'end';
FROM: 'from';
CONST : 'const';
NEW: 'new';
CLASS : 'class';
IMPLEMENTS : 'implements';
THIS : 'this';
VOID: 'void';
RETURN: 'return';
FOR: 'for';
AND: 'and';
OR: 'or';
IN: 'in';
WHILE: 'while';
DO: 'do';
ELSE : 'else';
IF : 'if';
SWITCH : 'switch';
CASE : 'case';
BREAK : 'break';
DEFAULT : 'default';
TRY : 'try';
CATCH : 'catch';

// Separators
LPAREN : '(';
RPAREN : ')';
LBRACE : '{';
RBRACE : '}';
LBRACK : '[';
RBRACK : ']';
LANGLE: '<';
RANGLE: '>';
SEMI : ';';
COMMA : ',';
DOT : '.';

// Operators
ASSIGN : '=';
BANG : '!';
TILDE : '~';
QUESTION : '?';
COLON : ':';
EQUAL : '==';
LE : '<=';
GE : '>=';
NOTEQUAL : '!=';
ANDSign : '&&';
ORSign : '||';
INC : '++';
DEC : '--';
ADD : '+';
SUB : '-';
MUL : '*';
DIV : '/';
BITAND : '&';
BITOR : '|';
CARET : '^';
MOD : '%';
ARROW : '->';


ID: (Letter | '$') (Letter | Digit | '$' | '_')+;
WS :  [ \t\r\n]+ -> skip;
COMMENT:   '/*' .*? '*/' -> skip;
LINE_COMMENT: '//' ~[\r\n]* -> skip;