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
NullLiteral: 'Null';
// Keywords
DataTypeList: 'int' | 'double' | 'bool' | 'string' | 'char';
AccessLevel: 'private' | 'public';
REQUIRE: 'require';
BEGIN: 'begin';
END: 'end';
FROM: 'from';
CONST : 'const';
CLASS : 'class';
IMPLEMENTS : 'implements';
THIS : 'this';
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

ID: (Letter | '$') (Letter | Digit | '$' | '_')+;
WS :  [ \t\r\n]+ -> skip;
COMMENT:   '/*' .*? '*/' -> skip;
LINE_COMMENT: '//' ~[\r\n]* -> skip;