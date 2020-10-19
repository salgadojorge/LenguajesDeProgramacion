package co.edu.javeriana.bot.simple.interprete.ast;

import java.util.Map;
import org.jpavlich.bot.*;

public class Left implements ASTNode {

	private ASTNode data; 
	private Bot bot;

	public Left(ASTNode data, Bot bot) {
		super();
		this.data = data;
		this.bot = bot;
	    
	}


	@Override
	public Object execute(Map<String, Object> symbolTable) {
		bot.left((int)data.execute(symbolTable));
		return null;
	}

}
