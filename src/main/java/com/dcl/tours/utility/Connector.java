package com.dcl.tours.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connector {
	
	public static Connection requestConnection() {
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/voyage_db", "root", "tiger"); 
			
		} catch (ClassNotFoundException | SQLException e) {
		
			e.printStackTrace();
		}
		return con;
	}
	
	public static void main(String args[]) {
		requestConnection();
	}
	

}
