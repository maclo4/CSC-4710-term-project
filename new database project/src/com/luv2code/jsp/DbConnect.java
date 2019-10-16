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
	  public boolean insertItem(String item, String price, String description) throws SQLException {
	    	
		  	connect_func();  
	    	
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
	  
	  public boolean insertCategory(String item, String category) throws SQLException {
		  String sql0 = "INSERT INTO ItemCategories(ItemID, Category) VALUES (" + 
		  		"	(SELECT ID FROM Items WHERE title = ?)," + 
		  		"     ?)";
		  preparedStatement = (PreparedStatement) connect.prepareStatement(sql0);
			preparedStatement.setString(1, item);
			preparedStatement.setString(2, category);
			
			boolean rowInserted = preparedStatement.executeUpdate() > 0;
	        preparedStatement.close();
//	        disconnect();
	        return rowInserted;
	  }
	  
	  public boolean insertUsers(String userID, String password, String email,
			  String firstName, String lastName, String gender, String age) throws SQLException {
		  
		  
		  return true;
	  }
	  public boolean initializeDb() throws SQLException{
		  
		 	connect_func();  
	    	//request.getParameter("Username");
		 	
		 	String sql0 = "DROP TABLE IF EXISTS ItemCategories";
		 	String sql1 = "drop table IF EXISTS Items" ;
		 	//String sql12 = "DROP TABLE"
		 		
		 	String sql2 =	"CREATE TABLE Items(" + 
		 			"Title varchar(50)," + 
		 			"ID int NOT NULL AUTO_INCREMENT," + 
		 			"Price DECIMAL(7,2)  NOT NULL," + 
		 			"Description TEXT," + 
		 			"DatePosted TIMESTAMP DEFAULT CURRENT_TIMESTAMP," + 
		 			"Primary key(ID))";
		 	
		 	String sql3 = "CREATE TABLE ItemCategories(" + 
		 			"ItemID int NOT NULL AUTO_INCREMENT," + 
		 			"Category varchar(25) NOT NULL," + 
		 			"PRIMARY KEY(ItemId, Category)," + 
		 			"FOREIGN KEY (ItemID) REFERENCES Items(ID)" + 
		 			"ON DELETE CASCADE ON UPDATE CASCADE)";
		 	
		 	String sql4 = "CREATE TABLE Users(" + 
		 			"UserID varchar(40) NOT NULL," + 
		 			"Password varChar(40) NOT NULL," + 
		 			"Email varChar(40) NOT NULL," + 
		 			"FirstName varchar(40) NOT NULL," + 
		 			"LastName varchar(40) NOT NULL," + 
		 			"Gender varchar(10) NOT NULL," + 
		 			"Age int(3) NOT NULL," + 
		 			"PRIMARY KEY(UserID)," + 
		 			"CHECK (Gender='Male' OR Gender = \"Female\" OR Gender = \"Non-binary\")," + 
		 			"CHECK (Email like '%_@__%.__%'));";
		 	
		 	statement =  (Statement) connect.createStatement();
		 	statement.executeUpdate(sql0);
		 	statement.executeUpdate(sql1);
		 	statement.executeUpdate(sql2);
		 	statement.executeUpdate(sql3);
		 	System.out.println("tables created.");
		 	
		 	DbConnect test = new DbConnect();
		 	test.insertItem("Banana", "12.50", "Yellow and Yummy");
		 	test.insertItem("Dvd", "12.00", "Fast and Furious");
		 	test.insertItem("Watermelon", "6.50", "Red and Yummy");
		 	test.insertItem("Black socks", "2.50", "Black");
		 	test.insertItem("Laptop", "120.50", "Silver");
		 	test.insertItem("Trash bag", "1.50", "black");
		 	test.insertItem("White tee", "5.50", "Plain white tee");
		 	test.insertItem("Sunflower Seeds", "12.50", "For eating");
		 	test.insertItem("iPhone X", "1200.00", "Black");
		 	test.insertItem("China Plates", "120.50", "Genuine ceramics");
		 	
		 	
		 	test.insertCategory("Banana", "fruit");
		 	test.insertCategory("Banana", "food");
		 	test.insertCategory("Dvd", "entertainment");
		 	test.insertCategory("Socks", "clothing");
		 	test.insertCategory("DVD", "technology");
		 	test.insertCategory("Laptop", "technology");
		 	test.insertCategory("Laptop", "windows");
		 	test.insertCategory("Watermelon", "fruit");
		 	test.insertCategory("Sunflower Seeds", "food");
		 	test.insertCategory("iPhone", "technology");
		 	test.insertCategory("China Plates", "home");
		 	
		 	
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
