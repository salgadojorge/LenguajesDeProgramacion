package co.edu.javeriana.bot.simple.interprete.ast;

import java.util.Map;
import org.jpavlich.bot.*;

public class Right implements ASTNode {

	private ASTNode data; 
	private Bot bot;

	public Right(ASTNode data, Bot bot) {
		super();
		this.data = data;
		this.bot = bot;
	    
	}


	@Override
	public Object execute(Map<String, Object> symbolTable) {
		bot.right((int)data.execute(symbolTable));
		return null;
	}

}
