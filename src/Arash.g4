grammar Arash;
//Arash Gholamdokht 9922762286

start: importDecl* classDecl+;

importDecl: ID ASSIGN REQUIRE LANGLE ID RANGLE SEMI |
ID (COMMA ID)* ASSIGN FROM LANGLE ID RANGLE REQUIRE LANGLE ID RANGLE
(COMMA FROM LANGLE ID RANGLE REQUIRE LANGLE ID RANGLE)* SEMI |
ID ASSIGN FROM LANGLE ID RANGLE '=>' LANGLE ID RANGLE SEMI;

classDecl: CLASS ID (LPAREN ID RPAREN)? (IMPLEMENTS ID (COMMA ID)*)? classBody;
classBody: BEGIN classBodyDeclaration+ END;

classBodyDeclaration: constructorDecl | classMemberDecl | functionDecl;
constructorDecl: ID LPAREN (DataTypeList ID (COMMA DataTypeList ID)*)? RPAREN constructorBody;
constructorBody: BEGIN (THIS DOT ID ASSIGN ID SEMI)* statement* END;

classMemberDecl: formalVariable | instantiation;
formalVariable: AccessLevel? CONST? (variableDeclaratorList | arrayDecl) SEMI;
variableDeclaratorList:	variableDeclarator (',' variableDeclarator)*;
variableDeclarator: DataTypeList? ID (ASSIGN (ADD | SUB)? (expression | ScientificNotation))?;
arrayDecl: DataTypeList ID LBRACK RBRACK ASSIGN?
((NEW DataTypeList LBRACK IntegerLiteral RBRACK) | LBRACK literal (COMMA literal)* RBRACK);

functionDecl: AccessLevel? (DataTypeList | VOID) ID LPAREN parameters? RPAREN statementBlock;
parameters: parameter optionalParameter?;
parameter: DataTypeList ID (COMMA DataTypeList ID)*;
optionalParameter: COMMA DataTypeList ID ASSIGN literal (COMMA DataTypeList ID ASSIGN literal)*;

statementBlock: BEGIN statement+ END;
statement: assignment | ifStatement | forStatement | whileStatement | switchCase |
 exception | print | return | instantiation | functionCall | variableDeclarator SEMI | incrementDecrement SEMI | arrayDecl SEMI;

assignment:	leftHandSide assignmentOperator expression SEMI;
leftHandSide:	expressionName | arrayAccess;
arrayAccess: ID LBRACK expression RBRACK;
assignmentOperator:	'=' |	'*=' |	'/=' | '%=' | '+=' |	'-=' |	'<<=' |	'>>=' | '>>>=' | '&=' | '^=' | '|=';

expression: expression '?' expression ':' expression |LPAREN DataTypeList RPAREN expression | LPAREN expression RPAREN |
 expression '**' expression | (TILDE| BANG | NOT) expression |(ADD | SUB) expression | incrementDecrement|
 expression (MUL | DIV | MOD) expression | expression (ADD | SUB) expression |
 expression ('<<' || '>>') expression | expression (BITAND | BITOR | CARET) expression |
 expression (EQUAL | NOTEQUAL | '<>') expression | expression ('<' | '>'  | LE | GE) expression |
 expression ( AND | OR | ANDSign | ORSign) expression |
 expressionName (LPAREN RPAREN)?| literal | arrayAccess | array;

incrementDecrement: (INC | DEC) expressionName | expressionName (INC | DEC);

forStatement: for1 | for2;
for1: FOR LPAREN DataTypeList? initilization SEMI expression (SEMI expressionName (INC | DEC))? RPAREN statementBlock;
initilization: expressionName ASSIGN (IntegerLiteral | expressionName);
for2: FOR  DataTypeList? expressionName IN expressionName statementBlock;

whileStatement: while | doWhile;
while: WHILE LPAREN expression RPAREN statementBlock;
doWhile: DO statementBlock WHILE LPAREN expression RPAREN;

ifStatement: IF LPAREN? expression RPAREN? statementBlock elseIf* else?;
elseIf: ELSE IF LPAREN? expression RPAREN? statementBlock;
else: ELSE statementBlock;

return: RETURN (functionCall | expression SEMI);

switchCase: SWITCH expression BEGIN case+ default? END;
case: CASE literal COLON BEGIN? statement* (BREAK SEMI)? END?;
default: DEFAULT COLON BEGIN? statement* (BREAK SEMI)? END?;

exception: TRY statementBlock CATCH LPAREN expressionName (COMMA expressionName)* RPAREN statementBlock;

print: PRINT LPAREN (expression) (ADD expression)* (COMMA expression)? RPAREN SEMI;

functionCall: expressionName LPAREN (expression (COMMA expression)*)? RPAREN SEMI;

instantiation: AccessLevel? CONST? expressionName expressionName
 (ASSIGN (NullLiteral | NEW? expressionName LPAREN (expression (COMMA expression)*)?RPAREN))? SEMI;

expressionName: ID | ambiguousName DOT ID;
ambiguousName:	ID |	ambiguousName DOT ID | THIS;

literal:	IntegerLiteral |	FloatingPointLiteral |	BooleanLiteral |	CharacterLiteral |	StringLiteral | NullLiteral;
array: LBRACK (literal (COMMA literal)*)? RBRACK;

//fragments
fragment NonZeroDigit: [1-9];
fragment Digit: [0-9];
fragment Letter: [a-zA-Z];

//Literals
FloatingPointLiteral: Digit* DOT Digit+;
IntegerLiteral: (Digit | NonZeroDigit Digit*);
ScientificNotation: Digit? DOT Digit* [eE] (ADD | SUB) Digit* ;
BooleanLiteral: 'true' | 'false';
CharacterLiteral: '\'' ~['\\\r\n] '\'';
StringLiteral: '"' ~["\\\r\n]* '"';
NullLiteral: 'Null';

// Keywords
DataTypeList: ('int' | 'double' | 'bool' | 'string' | 'String' | 'char' | 'float') (LBRACK RBRACK)*;
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
NOT: 'not';
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
PRINT: 'print';

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