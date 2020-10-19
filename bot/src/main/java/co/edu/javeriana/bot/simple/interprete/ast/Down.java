package co.edu.javeriana.bot.simple.interprete.ast;

import java.util.Map;
import org.jpavlich.bot.*;

public class Down implements ASTNode {

	private ASTNode data; 
	private Bot bot;

	public Down(ASTNode data, Bot bot) {
		super();
		this.data = data;
		this.bot = bot;
	    
	}


	@Override
	public Object execute(Map<String, Object> symbolTable) {
		bot.down((int)data.execute(symbolTable));
		return null;
	}

}
