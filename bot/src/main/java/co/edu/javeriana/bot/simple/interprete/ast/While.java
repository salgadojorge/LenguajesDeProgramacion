package co.edu.javeriana.bot.simple.interprete.ast;

import java.util.List;
import java.util.Map;

public class While implements ASTNode {

	private ASTNode condition;
	private List<ASTNode> body;

	
	
	public While(ASTNode condition, List<ASTNode> body) {
		super();
		this.condition = condition;
		this.body = body;
	}


	@Override
	public Object execute(Map<String, Object> symbolTable) {
		while((boolean) condition.execute(symbolTable)) {
			for(ASTNode n: body) {
				n.execute(symbolTable);
			}
		}

		return null;
	}

}
