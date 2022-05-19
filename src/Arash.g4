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
statement: assignment | ifStatement | forStatement | whileStatement | switchCase |
 exception | print | return | instantiation | functionCall | conditionalExpression;

assignment:	leftHandSide assignmentOperator expression SEMI;
leftHandSide:	expressionName | arrayAccess;
arrayAccess: ID LBRACK expression RBRACK;
assignmentOperator:	'=' |	'*=' |	'/=' | '%=' | '+=' |	'-=' |	'<<=' |	'>>=' | '>>>=' | '&=' | '^=' | '|=';


expression: LPAREN expression RPAREN | expression '**' expression | expression (ADD | SUB) expression |
expression (MUL | DIV | MOD) expression | expressionName | literal;

unaryExpression:	preIncrementExpression |	preDecrementExpression
	|	'+' unaryExpression |	'-' unaryExpression |	unaryExpressionNotPlusMinus;
preIncrementExpression:	'++' unaryExpression;
preDecrementExpression:	'--' unaryExpression;
unaryExpressionNotPlusMinus:	'~' unaryExpression | '!' unaryExpression;

conditionalExpression: expression '?' expression ':' expression;

forStatement: for1 | for2;
for1: FOR LPAREN DataTypeList initilization SEMI expression (SEMI expressionName (INC | DEC))? RPAREN statementBlock;
initilization: expressionName ASSIGN IntegerLiteral;
for2: FOR  expressionName IN expressionName statementBlock;

whileStatement: while | doWhile;
while: WHILE LPAREN expression RPAREN statementBlock;
doWhile: DO statementBlock WHILE LPAREN expression RPAREN;

ifStatement: IF LPAREN expression RPAREN statementBlock elseIf* else?;
elseIf: ELSE IF LPAREN expression RPAREN statementBlock;
else: ELSE statementBlock;

return: RETURN expression SEMI;

switchCase: SWITCH expression BEGIN case+ default? END;
case: CASE literal COLON statementBlock BREAK?;
default: DEFAULT COLON statementBlock BREAK?;

exception: TRY statementBlock CATCH LPAREN expressionName (COMMA expressionName)* RPAREN statementBlock;

print: PRINT LPAREN expression RPAREN SEMI;

functionCall: expressionName LPAREN expression (COMMA expression)* RPAREN;

instantiation: expressionName;

expressionName: ID | ambiguousName '.' ID;
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