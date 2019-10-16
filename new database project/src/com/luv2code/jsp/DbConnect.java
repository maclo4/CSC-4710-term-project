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
			
			boolean rowInserted = false;
			
			// try blocks so that the system doesn't crash when sql statements are rejected
			try {
			 rowInserted = preparedStatement.executeUpdate() > 0;
		        preparedStatement.close();}
			catch(Exception e){
				System.out.println(e);}
			
//		        disconnect();
		        return rowInserted;
		    }     
	  
	  public boolean insertCategory(String item, String category) throws SQLException {
		  String sql0 = "INSERT INTO ItemCategories(ItemID, Category) VALUES (" + 
		  		"	(SELECT ID FROM Items WHERE title = ?)," + 
		  		"     ?)";	
		  Boolean rowInserted = false;
		  preparedStatement = (PreparedStatement) connect.prepareStatement(sql0);
			preparedStatement.setString(1, item);
			preparedStatement.setString(2, category);
		
			// try blocks so that the system doesn't crash when sql statements are rejected
			try {
			rowInserted = preparedStatement.executeUpdate() > 0;
	        preparedStatement.close();}
			catch(Exception e) {
				System.out.println(e);}
//	        disconnect();
	        return rowInserted;
	  }
	  
	  public boolean insertUser(String userID, String password, String email,
			  String firstName, String lastName, String gender, String age, Boolean admin) throws SQLException {
		  
		  //store sql statement as string
		  String sql0 = "INSERT INTO Users(UserID, Password, Email, FirstName, LastName, Gender, Age, Admin)\r\n" + 
		  		" VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		 
		  String adminString;
		  Boolean rowInserted = false;
		  if(admin == true)
			  adminString = "1";
		  else
			  adminString = "0";
		  // create and load prepared statement
		  	preparedStatement = (PreparedStatement) connect.prepareStatement(sql0);
		  	preparedStatement.setString(1, userID);
			preparedStatement.setString(2, password);
			preparedStatement.setString(3,email);
			preparedStatement.setString(4, firstName);
			preparedStatement.setString(5, lastName);
			preparedStatement.setString(6, gender);
			preparedStatement.setString(7, age);
			preparedStatement.setString(8, adminString);
			
			try {
			//execute prepared statement
			rowInserted = preparedStatement.executeUpdate() > 0;
		        preparedStatement.close();}
			catch(Exception e) {
				System.out.println(e);
			}

		        return rowInserted;
	  }
	  
	  // big function that just initializes all the necessary tables using other insert functions
	  public boolean initializeDb() throws SQLException{
		  
		 	connect_func();  
	    	//request.getParameter("Username");
		 	
		 	String sql0 = "DROP TABLE IF EXISTS ItemCategories";
		 	String sql1 = "drop table IF EXISTS Items" ;
		 	String sql12 = "DROP TABLE IF EXISTS Users";
		 		
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
		 			"Admin boolean NOT NULL," + 
		 			"PRIMARY KEY(UserID)," + 
		 			"CHECK (Gender='Male' OR Gender = \"Female\" OR Gender = \"Non-binary\")," + 
		 			"CHECK (Email like '%_@__%.__%'));";
		 	
		 	// drop the tables then recreate them
		 	statement =  (Statement) connect.createStatement();
		 	statement.executeUpdate(sql0);
		 	statement.executeUpdate(sql1);
		 	statement.executeUpdate(sql12);
		 	statement.executeUpdate(sql2);
		 	statement.executeUpdate(sql3);
		 	statement.executeUpdate(sql4);
		 	
		 	System.out.println("tables created.");
		 	
		 	// initialize items table
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
		 	
		 	// initialize categories for items
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
		 	
		 	// initialize user table
		 	test.insertUser("root", "pass1234", "scott@gmail.com", "Scott", "Howard", "Male", "22", true);
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
