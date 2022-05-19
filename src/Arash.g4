grammar Arash;
//Arash Gholamdokht 9922762286

start: importDeclaration* classDecl+;

importDeclaration: REQUIRE;
classDecl: CLASS;
classBody: BEGIN classBodyDeclaration+ END;

classBodyDeclaration: classMemberDecl | functionDecl |	constructorDecl;

variableDeclaratorList:	variableDeclarator (',' variableDeclarator)*;

variableDeclarator: variableDeclaratorId ('=' variableInitializer)?;





expressionName:	ID |	ambiguousName '.' ID;
ambiguousName:	ID |	ambiguousName '.' ID;


literal:	IntegerLiteral |	DoubleLiteral |	BooleanLiteral |	CharacterLiteral |	StringLiteral | NullLiteral;

//Lexers
fragment NonZeroDigit: [1-9];
fragment Digit: [0-9];
fragment Letter: [a-zA-Z];
fragment Sign: [+-];
//Literals
DoubleLiteral: Sign? NonZeroDigit Digit;
IntegerLiteral: Sign? ('0' | NonZeroDigit Digit*);
ScientificNotation: ;
BooleanLiteral: 'true' | 'false';
CharacterLiteral: '\'' ~['\\\r\n] '\'';
StringLiteral: '"' ~["\\\r\n]* '"';
// Keywords
NullLiteral: 'Null';
BOOLEAN : 'boolean';
BREAK : 'break';
CASE : 'case';
CATCH : 'catch';
CHAR : 'char';
CLASS : 'class';
CONST : 'const';
DEFAULT : 'default';
DO : 'do';
DOUBLE : 'double';
ELSE : 'else';
FLOAT : 'float';
FOR : 'for';
IF : 'if';
IMPLEMENTS : 'implements';
INT : 'int';
INTERFACE : 'interface';
LONG : 'long';
NATIVE : 'native';
NEW : 'new';
PRIVATE : 'private';
PUBLIC : 'public';
RETURN : 'return';
SWITCH : 'switch';
THIS : 'this';
TRY : 'try';
WHILE : 'while';
// Separators
LPAREN : '(';
RPAREN : ')';
LBRACE : '{';
RBRACE : '}';
LBRACK : '[';
RBRACK : ']';
SEMI : ';';
COMMA : ',';
DOT : '.';
// Operators
ASSIGN : '=';
GT : '>';
LT : '<';
BANG : '!';
TILDE : '~';
QUESTION : '?';
COLON : ':';
EQUAL : '==';
LE : '<=';
GE : '>=';
NOTEQUAL : '!=';
AND : '&&';
OR : '||';
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

ADD_ASSIGN : '+=';
SUB_ASSIGN : '-=';
MUL_ASSIGN : '*=';
DIV_ASSIGN : '/=';
AND_ASSIGN : '&=';
OR_ASSIGN : '|=';
XOR_ASSIGN : '^=';
MOD_ASSIGN : '%=';
LSHIFT_ASSIGN : '<<=';
RSHIFT_ASSIGN : '>>=';
URSHIFT_ASSIGN : '>>>=';

WS :  [ \t\r\n]+ -> skip;
COMMENT:   '/*' .*? '*/' -> skip;
LINE_COMMENT: '//' ~[\r\n]* -> skip;

ID: ;