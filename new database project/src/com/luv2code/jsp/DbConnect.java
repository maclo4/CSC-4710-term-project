package com.luv2code.jsp;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.PreparedStatement;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
//import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class DbConnect{
	private static final long serialVersionUID = 1L;
	private Connection connect = null;
	private Statement statement = null;
	private PreparedStatement preparedStatement = null;
	private ResultSet resultSet = null;
	

	public DbConnect() {

    }
	public static String printSomething(String test) {
		return test.toLowerCase();
	}
	public void connect_func() throws SQLException {
        if (connect == null || connect.isClosed()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                throw new SQLException(e);
            }
            connect = (Connection) DriverManager
  			      .getConnection("jdbc:mysql://127.0.0.1:3306/projectdb?"
  			          + "user=john&password=pass1234");
            System.out.println(connect);
            System.out.println("IT WORKED!!");
        }
    }
	  protected void disconnect() throws SQLException {
	        if (connect != null && !connect.isClosed()) {
	        	connect.close();
	        }
	    }
	  public boolean insert(String item, String price, String description) throws SQLException {
	    	connect_func();  
	    	//request.getParameter("Username");
			String sql = "insert into Items(title, price, description) values (?, ?, ?)";
			preparedStatement = (PreparedStatement) connect.prepareStatement(sql);
			preparedStatement.setString(1, item);
			preparedStatement.setString(2, price);
			preparedStatement.setString(3, description);
			
//			preparedStatement.executeUpdate();
			 boolean rowInserted = preparedStatement.executeUpdate() > 0;
		        preparedStatement.close();
//		        disconnect();
		        return rowInserted;
		    }     
	  public boolean initializeDb() throws SQLException{
		  
		 	connect_func();  
	    	//request.getParameter("Username");
		 	String sql1 = "drop table IF EXISTS Items" ;
		 		
		 	String sql2 =	"CREATE TABLE Items(" + 
		 			"Title varchar(50)," + 
		 			"ID int NOT NULL AUTO_INCREMENT," + 
		 			"Price DECIMAL(7,2)  NOT NULL," + 
		 			"Description TEXT," + 
		 			"DatePosted TIMESTAMP DEFAULT CURRENT_TIMESTAMP," + 
		 			"Primary key(ID))";
		 	
		 	
		 	
		 	statement =  (Statement) connect.createStatement();
		 	statement.executeUpdate(sql1);
		 	statement.executeUpdate(sql2);
		 	System.out.println("table initialized?");
		 	
		 	DbConnect test = new DbConnect();
		 	test.insert("bananas", "12.50", "Yellow and Yummy");
		 	test.insert("dvd", "12.00", "Fast and Furious");
		 	test.insert("watermelon", "6.50", "Red and Yummy");
		 	test.insert("socks", "2.50", "Black");
		 	test.insert("laptop", "120.50", "Silver");
		 	test.insert("trash bag", "1.50", "black");
		 	test.insert("white tee", "5.50", "Plain white tee");
		 	test.insert("seeds", "12.50", "For growing fruit");
	        return true;
			/*String sql = "insert into Items(title, price) values (?, ?)";
			preparedStatement = (PreparedStatement) connect.prepareStatement(sql);
			preparedStatement.setString(1, item);
			preparedStatement.setString(2, price);
			
//			preparedStatement.executeUpdate();
			 boolean rowInserted = preparedStatement.executeUpdate() > 0;
		        preparedStatement.close();
//		        disconnect();
		        return rowInserted;*/
	  }
}
