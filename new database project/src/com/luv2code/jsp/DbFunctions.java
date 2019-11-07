package com.luv2code.jsp;
import java.io.IOException;
import java.io.PrintWriter;
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

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/DbConnect")
public class DbFunctions extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private Connection connect = null;
	private Statement statement = null;
	private PreparedStatement preparedStatement = null;
	private ResultSet resultSet = null;
	

	/**
     * @see HttpServlet#HttpServlet()
     */
    public DbFunctions() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */ 
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();
        System.out.println("inside the servlet");
        PrintWriter out = response.getWriter();
        out.println("it workeddd" + action);
        
        
        // Figure out which button was pressed
        
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	public static String printSomething(String test) {
		return test.toLowerCase();
	}
	
	//========================================================
	// CONNECT TO DATABASE
	//========================================================
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
	//========================================================
	// DISCONNECT FROM DATABASE
	//========================================================
	  protected void disconnect() throws SQLException {
	        if (connect != null && !connect.isClosed()) {
	        	connect.close();
	        }
	    }
	  
	//========================================================
	// INSERT ITEM INTO DATABASE
	//========================================================
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
	  
	//========================================================
	// INSERT CATEGORY INTO DATABASE
	//========================================================
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
	//========================================================
	// INSERT USER INTO DATABASE
	//========================================================
	  public boolean insertUser(String userID, String password, String email,
			  String firstName, String lastName, String gender, String age, Boolean admin) throws SQLException {
		  
		  connect_func();
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
	
	// =======================================================
	// SEARCH FOR AN ITEM BASED ON THE CATEGORY
	//========================================================
	  public ItemClass categorySearch(String category) throws SQLException{
		  
		  connect_func();
		  ItemClass Items = new ItemClass();
		  
		  String sql0 = "SELECT * \r\n" + 
		  		"FROM Items I\r\n" + 
		  		"WHERE ID IN (\r\n" + 
		  		"SELECT ItemID\r\n" + 
		  		"FROM ItemCategories\r\n" + 
		  		"WHERE Category = ?)";
		  
		  preparedStatement = (PreparedStatement) connect.prepareStatement(sql0);
		  preparedStatement.setString(1, category);
		  
				// try blocks so that the system doesn't crash when sql statements are rejected
				try {
				ResultSet resultSet2 = preparedStatement.executeQuery();
				
		        // class that holds data for this type of search
		        List<String> PriceList = new ArrayList<>();
		        List<String> IDList = new ArrayList<>();
		        while(resultSet2.next()) {
		        	PriceList.add(resultSet2.getString("Price"));
		        	IDList.add(resultSet2.getString("title"));
		        	
		        }
		       
		        Items.setPrice(PriceList);
		        Items.setID(IDList);
		        preparedStatement.close();
				}
				catch(Exception e) {
					System.out.println(e);}
		        
				return Items;
		  }
	  
	  
	//========================================================
	  // big function that just initializes all the necessary
	  // tables using other insert functions
	//========================================================
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
		 			"ItemID int NOT NULL," + 
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
		 	DbFunctions test = new DbFunctions();
		 	test.insertItem("Banana", "12.50", "Yellow and Yummy");
		 	test.insertItem("Dvd", "12.00", "Fast and Furious");
		 	test.insertItem("Watermelon", "6.50", "Red and Yummy");
		 	test.insertItem("Black socks", "2.50", "Black");
		 	test.insertItem("Laptop", "120.50", "Silver");
		 	test.insertItem("Trash bag", "1.50", "black");
		 	test.insertItem("White tee", "5.50", "Plain white tee");
		 	test.insertItem("Sunflower Seeds", "12.50", "For eating");
		 	test.insertItem("iPhone", "1200.00", "Black");
		 	test.insertItem("China Plates", "120.50", "Genuine ceramics");
		 	
		 	// initialize categories for items
		 	test.insertCategory("Banana", "fruit");
		 	test.insertCategory("Banana", "food");
		 	test.insertCategory("Dvd", "entertainment");
		 	test.insertCategory("Black socks", "clothing");
		 	test.insertCategory("Dvd", "technology");
		 	test.insertCategory("Laptop", "testingg");
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
	  
	  
	//========================================================
	  // authenticate username and password
	//========================================================
	  public boolean authenticate(String username, String password) throws SQLException
	  {
		  connect_func();
		  
		  
		  String sql0 = "SELECT Password FROM Users Where UserID = ?";
		  
		  preparedStatement = (PreparedStatement) connect.prepareStatement(sql0);
		  	preparedStatement.setString(1, username);
		  	System.out.println("after ps");
		  
		  String pass = "";
		  try {
		  ResultSet resultSet = preparedStatement.executeQuery();
		 
		  		while(resultSet.next())
		  		{
		  			pass = resultSet.getString("Password");
		  			System.out.println(pass);
		  		}
		  } catch(Exception e) {
			  System.out.println(e);}
		  

		  if(pass.equals(password)){
			  System.out.println("Password matched");
			  return true;}
		  else {
			  System.out.println("Password not matched: " + pass + ", " + password);
			  return false;}
		 
	  }
	  
}
