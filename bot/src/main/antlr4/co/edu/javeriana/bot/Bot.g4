grammar Bot;

@parser::header {

import org.jpavlich.bot.*;
import java.util.Map;
import java.util.HashMap;
import co.edu.javeriana.bot.simple.interprete.ast.*;
}

@parser::members {
Map<String, Object> symbolTable = new HashMap<String,Object>();
private Bot bot;

public BotParser(TokenStream input, Bot bot) {
    this(input);
    this.bot = bot;
}

}



/* 
start
:
	'hello' 'world' {
		bot.up(5);
		bot.down(5);
		bot.right(5);
		bot.left(5);
		
	} 
;
*/
program
:
		{
			List<ASTNode> body = new ArrayList<ASTNode>();
			Map<String, Object> symbolTable = new HashMap<String, Object>();
		}
	 (sentence {body.add($sentence.node);})*  
	 {
	 	for(ASTNode n: body){
	 		n.execute(symbolTable);
	 	}
	 };


sentence returns [ASTNode node]: 
	println {$node =$println.node;}
	|conditional{$node =$conditional.node;}
	|loop {$node = $loop.node;}
	|var_decl {$node = $var_decl.node;}
	|var_assign {$node = $var_assign.node;}
	|up {$node = $up.node;}
	|down {$node = $down.node;}
	|left {$node = $left.node;}
	|right {$node = $right.node;}
	;

loop returns [ASTNode node]: 
	WHILE   expression DECLARE
	{
		List<ASTNode> body = new ArrayList<ASTNode>();
	}
		(s1=sentence{body.add($s1.node);})* END SEMICOLON
		{
			$node = new While($expression.node, body);
		};


conditional returns [ASTNode node]: 
		IF  expression DECLARE
		{
			List<ASTNode> body = new ArrayList<ASTNode>();
		}
			(s1=sentence {body.add($s1.node);})* END SEMICOLON
		ELSE 
		{
			List<ASTNode> elseBody = new ArrayList<ASTNode>();
		}
			(s2=sentence {elseBody.add($s2.node);})* END SEMICOLON
		
		{
			$node=new If($expression.node,body, elseBody );
		}
		 ;
println returns [ASTNode node]: PRINT expression SEMICOLON
 {$node = new Println($expression.node);};
 
var_decl returns [ASTNode node]:
	VAR ID SEMICOLON {$node = new VarDecl($ID.text);}
;

var_assign returns [ASTNode node]:
	ID ASSIGN expression SEMICOLON {$node = new VarAssign($ID.text, $expression.node);}
;
 
expression returns [ASTNode node]:
	t1=factor{$node = $t1.node;}
		(PLUS t2=factor{$node = new Addition($node, $t2.node);})*;
		
factor returns [ASTNode node]: t1=term{$node = $t1.node;}
	(MULTIPLICATION t2=term{$node = new Multiplication($node, $t2.node);})*;
		
		
term returns [ASTNode node]:
	NUMBER {$node = new Constant(Integer.parseInt($NUMBER.text));}
	| BOOL {$node = new Constant(Boolean.parseBoolean($BOOL.text));}
	|ID  {$node= new VarRef($ID.text);}
	|LBRACKET expression{$node = $expression.node;} RBRACKET
	;
		
	
move_bot returns [ASTNode node]: up ;

up returns [ASTNode node]: UP (expression) SEMICOLON
	{$node = new Up($expression.node, bot);};

down returns [ASTNode node]: DOWN (expression) SEMICOLON
	{$node = new Down($expression.node, bot);};

left returns [ASTNode node]: LEFT (expression) SEMICOLON
	{$node = new Left($expression.node, bot);};
	
right returns [ASTNode node]: RIGHT(expression) SEMICOLON
	{$node = new Right($expression.node, bot);};
/*

pick returns [ASTNode node]: PICK SEMICOLON;
drop returns [ASTNode node]: DROP SEMICOLON;

read_command returns [ASTNode node]: READ ID SEMICOLON;	
function_declaration returns [ASTNode node]: 
	DEFINE ID LBRACKET params RBRACKET 
	DECLARE sentence* END SEMICOLON;

function_call returns [ASTNode node]: ID LBRACKET params RBRACKET SEMICOLON;
params returns [ASTNode node]: ( ( arguments COMMA)* arguments | arguments?);
arguments returns [ASTNode node]: (ID | dataType);
*/
IF: 'if';
ELSE: 'else';
WHILE: 'while';
END: 'end';
DECLARE:'->';

MAIN: 'main';

ASSIGN: '<-';

 

VAR: '\'';

 

UP: '^';
DOWN: 'V';
RIGHT: '>';
LEFT:'<';


PICK:'P';
DROP: 'D';

 

DEFINE: 'define';
PRINT: '$';
READ: '?';

 

AND: '&';
OR: '|';
NOT: '!';

 

LT: '<';
GT: '>';
LEQ: '<=';
GEQ: '>=';
NEQ:'<>';
EQUAL: '=';
 



PLUS:'+';
MINUS:'-';
MULTIPLICATION: '*';
DIVISION: '/';
INVERSE:'inverse';

LBRACKET: '(';
RBRACKET: ')';

SEMICOLON: ';'; 
COMMA: ',';

BOOL:'true'|'false'; 
ID: [a-zA-Z][a-zA-Z0-9]* ;
NUMBER: [0-9]+;
STRING:  '"' (~[\r\n"] | '""')* '"';
WS:[ \n\t\r]+ -> skip;
 

 

