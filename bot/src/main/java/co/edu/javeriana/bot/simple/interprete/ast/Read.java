package co.edu.javeriana.bot.simple.interprete.ast;

import java.util.Map;
import java.util.Scanner;
public class Read implements ASTNode {

	private String data;
	private Scanner scanner;
	

	public Read(String data) {
		super();
		this.data = data;
		this.scanner = new Scanner(System.in);
		
	}


	@Override
	public Object execute(Map<String, Object> symbolTable) {
		String name = this.scanner.nextLine();
		symbolTable.put(data, name);
		return null;
	}

}
