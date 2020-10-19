package co.edu.javeriana.bot.simple.interprete.ast;

import java.util.Map;

public class Modulo implements ASTNode {

	private ASTNode operand1;

	
	
	
	public Modulo(ASTNode operand1, ASTNode operand2) {
		super();
		this.operand1 = operand1;

	}



	@Override
	public Object execute(Map<String, Object> symbolTable) {
		return -(int)operand1.execute(symbolTable) ;

	}

}
