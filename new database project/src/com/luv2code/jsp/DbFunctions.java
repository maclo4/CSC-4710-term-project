package com.luv2code.jsp;
import com.luv2code.*;
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
	  public boolean insertItem(String item, String price, String seller, String description) throws SQLException {
	    	
		  	connect_func();  
	    	
			String sql = "insert into Items(title, price, SellerUsername, description) values (?, ?, ?, ?)";
			preparedStatement = (PreparedStatement) connect.prepareStatement(sql);
			preparedStatement.setString(1, item);
			preparedStatement.setString(2, price);
			preparedStatement.setString(3, seller);
			preparedStatement.setString(4, description);

			
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
// INSERT FAVORITE ITEM INTO DATABASE
//========================================================
  public boolean addFavSeller(String favSeller, String username) throws SQLException {
	  connect_func();
	  String sql0 = "INSERT INTO FavoriteSellers (Username, FavoriteSeller) VALUES (?, ?)";	
	  Boolean rowInserted = false;
	  preparedStatement = (PreparedStatement) connect.prepareStatement(sql0);
		preparedStatement.setString(1, username);
		preparedStatement.setString(2, favSeller);
	
		// try blocks so that the system doesn't crash when sql statements are rejected
		try {
		rowInserted = preparedStatement.executeUpdate() > 0;
        preparedStatement.close();}
		catch(Exception e) {
			System.out.println(e);}
		
		
        return rowInserted;
  }	  
//========================================================
// INSERT FAVORITE ITEM INTO DATABASE
//========================================================
  public boolean addFavItem(String username, String itemName) throws SQLException {
	  connect_func();
	  String sql0 = "INSERT INTO FavoriteItems (Username, ItemID, Title) \r\n" + 
	  		"SELECT ?, ID, title \r\n" + 
	  		"FROM Items\r\n" + 
	  		"WHERE title = ?";	
	  Boolean rowInserted = false;
	  preparedStatement = (PreparedStatement) connect.prepareStatement(sql0);
		preparedStatement.setString(1, username);
		preparedStatement.setString(2, itemName);
	
		// try blocks so that the system doesn't crash when sql statements are rejected
		try {
		rowInserted = preparedStatement.executeUpdate() > 0;
        preparedStatement.close();}
		catch(Exception e) {
			System.out.println(e);}
		
		
        return rowInserted;
  }
  
//========================================================
// DELETE FAVORITE ITEM FROM DATABASE
//========================================================
 public boolean deleteFavItem(String username, String itemID) throws SQLException {
	  connect_func();
	  String sql0 = "DELETE FROM FavoriteItems WHERE ItemID = ? AND Username = ?";	
	  Boolean rowInserted = false;
	  preparedStatement = (PreparedStatement) connect.prepareStatement(sql0);
		preparedStatement.setString(1, itemID);
		preparedStatement.setString(2, username);
	
		// try blocks so that the system doesn't crash when sql statements are rejected
		try {
		rowInserted = preparedStatement.executeUpdate() > 0;
       preparedStatement.close();}
		catch(Exception e) {
			System.out.println(e);}
		
		
       return rowInserted;
 }

//========================================================
//DELETE FAVORITE ITEM FROM DATABASE
//========================================================
public boolean deleteFavSeller(String username, String favSeller) throws SQLException {
	  connect_func();
	  String sql0 = "DELETE FROM FavoriteSellers WHERE Username = ? AND FavoriteSeller = ?";	
	  Boolean rowInserted = false;
	  preparedStatement = (PreparedStatement) connect.prepareStatement(sql0);
		preparedStatement.setString(1, username);
		preparedStatement.setString(2, favSeller);
	
		// try blocks so that the system doesn't crash when sql statements are rejected
		try {
		rowInserted = preparedStatement.executeUpdate() > 0;
     preparedStatement.close();}
		catch(Exception e) {
			System.out.println(e);}
		
		
     return rowInserted;
}
// =======================================================
// SEARCH FOR FAVORITE ITEMS
//========================================================
  public ItemClass getFavoriteItems(String username) throws SQLException{
	  connect_func();
	  ItemClass Items = new ItemClass();
		  
	  System.out.println(username);
	  String sql0 = "SELECT * FROM FavoriteItems WHERE Username = ? ";
		preparedStatement = (PreparedStatement) connect.prepareStatement(sql0);
		preparedStatement.setString(1, username);
  //Statement statement2 = (Statement) connect.createStatement();
	  
	// try blocks so that the system doesn't crash when sql statements are rejected
	try {
		
		resultSet = preparedStatement.executeQuery();
		
        // class that holds data for this type of search
        List<String> usernameList = new ArrayList<>();
        List<String> IDList = new ArrayList<>();
        List<String> titleList = new ArrayList<>();
        
        System.out.println("line 359, search favorites");
        while(resultSet.next()) {
        	
        	usernameList.add(resultSet.getString("Username"));
        	titleList.add(resultSet.getString("Title"));
        	IDList.add(resultSet.getString("ItemID"));
        	
        	}
	       
        
        Items.setUsername(usernameList);
        Items.setID(IDList);
        Items.setTitle(titleList);
        
        
        preparedStatement.close();
			}
	catch(Exception e) {
		System.out.println("Get Favorite Items error: " + e);}
	        
	return Items;
	  }

//=======================================================
//SEARCH FOR FAVORITE ITEMS
//========================================================
 public ItemClass getFavoriteSellers(String username) throws SQLException{
	  connect_func();
	  ItemClass Items = new ItemClass();
		  
	  System.out.println(username);
	  String sql0 = "SELECT * FROM FavoriteSellers WHERE Username = ? ";
		preparedStatement = (PreparedStatement) connect.prepareStatement(sql0);
		preparedStatement.setString(1, username);
 //Statement statement2 = (Statement) connect.createStatement();
	  
	// try blocks so that the system doesn't crash when sql statements are rejected
	try {
		
		resultSet = preparedStatement.executeQuery();
		
       // class that holds data for this type of search
       List<String> favoriteSellersList = new ArrayList<>();

       while(resultSet.next()) {
       	
       	favoriteSellersList.add(resultSet.getString("FavoriteSeller"));
       	
       	}
	       
       
       Items.setUsername(favoriteSellersList);
       
       preparedStatement.close();
			}
	catch(Exception e) {
		System.out.println("Get Favorite Seller error: " + e);}
	        
	return Items;
	  }

  
  
	//========================================================
	// SEARCH: GET MOST EXPENSIVE
	//========================================================
	  public ItemClass getMostExpensive() throws SQLException {
		  
		  connect_func();
		  
		  ItemClass items = new ItemClass();
		  String sql0 = "DROP VIEW IF EXISTS Prices"; 
		  String sql1 = " CREATE VIEW Prices(Category, Price) AS \r\n" + 
		  		"	SELECT C.Category, MAX(I.Price)\r\n" + 
		  		"       FROM Items I, ItemCategories C\r\n" + 
		  		"	   WHERE I.ID = C.ItemID \r\n" + 
		  		"       GROUP BY Category";
		  
		  String sql2 = "SELECT I.Price, I.title, P.Category\r\n" + 
		  		" FROM  Prices P, Items I, ItemCategories C\r\n" + 
		  		" WHERE P.Price = I.price AND I.ID = C.ItemID AND C.Category = P.Category\r\n" + 
		  		" group by P.Category\r\n";
		  
		  try {
		  statement =  (Statement) connect.createStatement();
		   statement.executeUpdate(sql0);
		 	statement.executeUpdate(sql1);
		 	resultSet = statement.executeQuery(sql2);
		 	
		 	List<String> PriceList = new ArrayList<>();
	        List<String> titleList = new ArrayList<>();
	        List<String> categoryList = new ArrayList<>();
	        
	        System.out.println("line 208");
	        while(resultSet.next()) {
	        	//System.out.println("line 210");
	        	PriceList.add(resultSet.getString("Price"));
	        	titleList.add(resultSet.getString("title"));
	        	System.out.println(resultSet.getString("title"));
	        	categoryList.add(resultSet.getString("Category"));
	        	
	        }
	       
	        items.setPrice(PriceList);
	        items.setTitle(titleList);
	        items.setCategory(categoryList);
	        statement.close();
			}
			catch(Exception e) {
				System.out.println("line 223");
				System.out.println(e);}

		  return items;
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
		        List<String> TitleList = new ArrayList<>();
		        while(resultSet2.next()) {
		        	PriceList.add(resultSet2.getString("Price"));
		        	TitleList.add(resultSet2.getString("title"));
		        	
		        }
		       
		        Items.setPrice(PriceList);
		        Items.setTitle(TitleList);
		        preparedStatement.close();
				}
				catch(Exception e) {
					System.out.println(e);}
		        
				return Items;
		  }
	  
// =======================================================
// SEARCH FOR AN ITEM BASED ON THE CATEGORY
//========================================================
	  public ItemClass SearchItems() throws SQLException{
		  connect_func();
		  ItemClass Items = new ItemClass();
			  
		  String sql0 = "SELECT * FROM Items";
		  statement =  (Statement) connect.createStatement();
		  //Statement statement2 = (Statement) connect.createStatement();
			  
			// try blocks so that the system doesn't crash when sql statements are rejected
			try {
				resultSet = statement.executeQuery(sql0);
					
		        // class that holds data for this type of search
		        List<String> priceList = new ArrayList<>();
		        List<String> IDList = new ArrayList<>();
		        List<String> titleList = new ArrayList<>();
		        
		        while(resultSet.next()) {
		        	priceList.add(resultSet.getString("Price"));
		        	IDList.add(resultSet.getString("ID"));
		        	titleList.add(resultSet.getString("Title"));
		        	}
			       
		        Items.setPrice(priceList);
		        Items.setTitle(titleList);
		        Items.setID(IDList);
		       
		        statement.close();
					}
			catch(Exception e) {
				System.out.println(e);}
			        
			return Items;
			  }


// =======================================================
// SEARCH FOR AN ITEM BASED ON THE CATEGORY
//========================================================
  public UserClass getUsers() throws SQLException{
	  	connect_func();
	  	UserClass users = new UserClass();
				  
	  	String sql0 = "SELECT * FROM Users";
	  	statement =  (Statement) connect.createStatement();
	  	//Statement statement2 = (Statement) connect.createStatement();
		  
		// try blocks so that the system doesn't crash when sql statements are rejected
		try {
			resultSet = statement.executeQuery(sql0);
				
		// class that holds data for this type of search
		
		List<String> usernameList = new ArrayList<>();
		List<String> emailList = new ArrayList<>();
		
		while(resultSet.next()) {
			usernameList.add(resultSet.getString("UserID"));
			emailList.add(resultSet.getString("Email"));
		    	}
		       
	    users.setUsername(usernameList);
	    users.setEmail(emailList);
	    
	    statement.close();
				}
		catch(Exception e) {
			System.out.println(e);}
		        
		return users;

  }
  
  

//========================================================
  // Search for user
//========================================================
 public Boolean searchForUsername(String username) throws SQLException{
	 
	 UserClass allUsers = getUsers();
	 List<String> userList = allUsers.getUsername();
	 return userList.contains(username);
	
 }

//========================================================
 // Search for user
//========================================================
public Boolean searchForEmail(String email) throws SQLException{
	 
	 UserClass allUsers = getUsers();
	 List<String> emailList = allUsers.getEmail();
	 return emailList.contains(email);
	
}

//=======================================================
//SEARCH FOR AN ITEM BASED ON THE CATEGORY
//========================================================
public ItemClass getCatXY(String X, String Y) throws SQLException{
	  	connect_func();
	  	ItemClass items = new ItemClass();
				  
	  	String sql0 = "select * from ItemsAndCategories I\r\n" + 
	  			"where Category = ? AND SellerUsername IN(\r\n" + 
	  			"SELECT SellerUsername \r\n" + 
	  			"FROM ItemsAndCategories IC\r\n" + 
	  			"WHERE Category = ? AND DATE(I.DatePosted) = DATE(IC.DatePosted)\r\n" + 
	  			")";
	  	preparedStatement = (PreparedStatement) connect.prepareStatement(sql0);
	  	preparedStatement.setString(1, X);
		preparedStatement.setString(2, Y);
	  	//Statement statement2 = (Statement) connect.createStatement();
		  
		// try blocks so that the system doesn't crash when sql statements are rejected
		try {
			resultSet = preparedStatement.executeQuery();
				
		// class that holds data for this type of search
		
		List<String> usernameList = new ArrayList<>();
		
		
		while(resultSet.next()) {
			usernameList.add(resultSet.getString("SellerUsername"));
			
		    	}
		       
	    items.setUsername(usernameList);
	    
	    
	    preparedStatement.close();
				}
		catch(Exception e) {
			System.out.println(e);}
		        
		return items;

}

//=======================================================
//SEARCH FOR AN ITEM BASED ON THE CATEGORY
//========================================================
public UserClass getMutualFavoriteSellers(String userOne, String userTwo) throws SQLException{
	  	connect_func();
	  	UserClass users = new UserClass();
				  
	  	String sql0 = "select FavoriteSeller from FavoriteSellers WHERE Username = ? AND \r\n" + 
	  			"FavoriteSeller IN(\r\n" + 
	  			"	SELECT FavoriteSeller\r\n" + 
	  			"    FROM FavoriteSellers\r\n" + 
	  			"    WHERE Username = ?)";
	  	preparedStatement = (PreparedStatement) connect.prepareStatement(sql0);
	  	preparedStatement.setString(1, userOne);
		preparedStatement.setString(2, userTwo);
	  	//Statement statement2 = (Statement) connect.createStatement();
		  
		// try blocks so that the system doesn't crash when sql statements are rejected
		try {
			resultSet = preparedStatement.executeQuery();
				
		// class that holds data for this type of search
		
		List<String> mutualSellers = new ArrayList<>();
		
		
		while(resultSet.next()) {
			mutualSellers.add(resultSet.getString("FavoriteSeller"));
			
		    	}
		       
	    users.setUsername(mutualSellers);
	    
	    
	    preparedStatement.close();
				}
		catch(Exception e) {
			System.out.println(e);}
		        
		return users;

}

//=======================================================
//SEARCH FOR AN ITEM BASED ON THE CATEGORY
//========================================================
  public UserClass FindMaxItems() throws SQLException{
	  connect_func();
	  UserClass Items = new UserClass();
	  int maxItems;
	  
	  // first, get the max number of posts by a user
	  String sql0 = "SELECT MAX(itemCount) \r\n" + 
	  		"FROM (\r\n" + 
	  		"SELECT COUNT(title) itemCount\r\n" + 
	  		"FROM Items I\r\n" + 
	  		"GROUP BY SellerUsername) AS MostSold;";
	  
	  // then, use that number to search for users who have posted that number of times
	  String sql1 = "Select SellerUsername\r\n" + 
	  		"FROM Items\r\n" + 
	  		"group by SellerUsername having count(SellerUsername) = ?";
	  
	  statement =  (Statement) connect.createStatement();
	  
	  
	  //Statement statement2 = (Statement) connect.createStatement();
		  
		// try blocks so that the system doesn't crash when sql statements are rejected
		try {
			// find max items posted
			resultSet = statement.executeQuery(sql0);
			
			// max number of items posted
			resultSet.next();
			maxItems = resultSet.getInt("MAX(ItemCount)");
			
			// now use the max number of items in the preparedStatement
			// find the users who have posted that amount of times
			preparedStatement = (PreparedStatement) connect.prepareStatement(sql1);
			preparedStatement.setInt(1, maxItems);
			resultSet = preparedStatement.executeQuery();
			

	        List<String> sellerList = new ArrayList<>();
	        
	        while(resultSet.next()) {
	        	
	        	sellerList.add(resultSet.getString("SellerUsername"));
	        	}
		       
	       
	        Items.setUsername(sellerList);
	      
	       
	        statement.close();
	        preparedStatement.close();
		 
			  
		}catch(Exception e) {
			System.out.println(e);}
		
		        
		return Items;
		  }

  
//========================================================
// ADD REVIEW INTO DATABASE
//========================================================
  public boolean addReview(String reviewer, String item, String review) throws SQLException {
    	
	  	connect_func();  
    	String sql = "insert into Reviews(ReviewerId, itemId, reviewdescription) values (?, ?, ?)";
		preparedStatement = (PreparedStatement) connect.prepareStatement(sql);
		preparedStatement.setString(1, reviewer);
		preparedStatement.setString(2, item);
		preparedStatement.setString(3, review);
		
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
  // big function that just initializes all the necessary
  // tables using other insert functions
//========================================================
	  public boolean initializeDb() throws SQLException{
		  
		 	connect_func();  
	    	//request.getParameter("Username");
		 	
		 	String sql0 = "DROP TABLE IF EXISTS ItemCategories";
		 	String sql1 = "drop table IF EXISTS Items" ;
		 	String sql12 = "DROP TABLE IF EXISTS Users";
		 	String sql123 = "DROP TABLE IF EXISTS FavoriteItems";
		 	String sql1234 = "DROP TABLE IF EXISTS FavoriteSellers";
		 	String sql12345 = "DROP TABLE IF EXISTS Reviews";
		 		
		 	String sql2 =	"create table Items(\r\n" + 
		 			"title varchar(50) NOT NULL,\r\n" + 
		 			"ID int NOT NULL AUTO_INCREMENT,\r\n" + 
		 			"price DECIMAL(7,2)  NOT NULL,\r\n" + 
		 			"SellerUsername varchar(40),\r\n" + 
		 			"description TEXT,\r\n" + 
		 			"datePosted TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\r\n" + 
		 			"primary key(ID),\r\n" + 
		 			"FOREIGN KEY(SellerUsername) REFERENCES Users(UserID))";
		 	
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
		 	
		 	String sql5 ="create table FavoriteItems(\r\n" + 
		 			"Username varchar(50) NOT NULL,\r\n" + 
		 			"ItemID int NOT NULL,\r\n" + 
		 			"Title	varchar(50) NOT NULL,\r\n" + 
		 			"-- ID int NOT NULL AUTO_INCREMENT,\r\n" + 
		 			"FOREIGN KEY (Username) REFERENCES Users(UserID),\r\n" + 
		 			"FOREIGN KEY (ItemId) REFERENCES Items(ID),\r\n" + 
		 			"PRIMARY KEY(Username, ItemID));";
		 	
		 	String sql6="create table FavoriteSellers(\r\n" + 
		 			"Username varchar(50) NOT NULL,\r\n" + 
		 			"FavoriteSeller varchar(50) NOT NULL,\r\n" + 
		 			"FOREIGN KEY (Username) REFERENCES Users(UserID),\r\n" + 
		 			"FOREIGN KEY (FavoriteSeller) REFERENCES Users(UserID),\r\n" + 
		 			"PRIMARY KEY(Username, FavoriteSeller))";
		 	
		 	String sql7="DROP VIEW IF EXISTS ItemsAndCategories";
		 	String sql8="create view ItemsAndCategories AS\r\n" + 
		 			"SELECT I.ID, I.SellerUsername, I.title, C.Category, I.DatePosted\r\n" + 
		 			"FROM Items I, ItemCategories C\r\n" + 
		 			"WHERE I.ID = C.ItemID";
		 	
		 	String sql9 = "CREATE TABLE Reviews("
		 			+ "ReviewNumber int NOT NULL AUTO_INCREMENT," + 
		 			"ReviewerId varchar(50) NOT NULL," + 
		 			"ItemId int NOT NULL," + 
		 			"reviewdescription varchar(30)," +
		 			"PRIMARY KEY(ReviewNumber)," + 
		 			"FOREIGN KEY (ReviewerId) REFERENCES Users(UserID)," + 
		 			"FOREIGN KEY (ItemId) REFERENCES Items(ID)" + 
		 			"ON DELETE CASCADE ON UPDATE CASCADE)";
		 	
		 	// drop the tables then recreate them
		 	try {
		 	statement =  (Statement) connect.createStatement();
		 	statement.executeUpdate(sql123);
		 	statement.executeUpdate(sql1234);
		 	statement.executeUpdate(sql12345);
		 	statement.executeUpdate(sql0);
		 	statement.executeUpdate(sql1);
		 	statement.executeUpdate(sql12);
		 	
		 	statement.executeUpdate(sql4);
		 	statement.executeUpdate(sql2);
		 	statement.executeUpdate(sql3);
		 	statement.executeUpdate(sql5);
		 	statement.executeUpdate(sql6);
		 	statement.executeUpdate(sql7);
		 	statement.executeUpdate(sql8);
		 	statement.executeUpdate(sql9);

		 	}
		 	catch(Exception e) {
		 		System.out.println("Initialize failed: " + e);
		 	}
		 	
		 	System.out.println("tables created.");
		 	
		 	DbFunctions test = new DbFunctions();
			// initialize user table
		 	test.insertUser("root", "pass1234", "scott@gmail.com", "Scott", "Howard", "Male", "22", true);
		 	test.insertUser("maclo4", "pass1234", "maclo4@gmail.com", "Scott", "Howard", "Male", "22", false);
		 	test.insertUser("evan", "pass1234", "evan@gmail.com", "evan", "nguyen", "Male", "21", false);
		 	test.insertUser("corey", "pass1234", "scott@gmail.com", "corey", "tessler", "Male", "28", false);
		 	
		 	
		 	// initialize items table
		
		 	test.insertItem("Banana", "12.50", "maclo4", "Yellow and Yummy");
		 	test.insertItem("Dvd", "12.00", "maclo4", "Fast and Furious");
		 	test.insertItem("Watermelon", "6.50","maclo4", "Red and Yummy");
		 	test.insertItem("Black socks", "2.50", "evan","Black");
		 	test.insertItem("Laptop", "120.50", "evan","Silver");
		 	test.insertItem("Trash bag", "1.50", "evan","b1lack");
		 	test.insertItem("White tee", "5.50", "root","Plain white tee");
		 	test.insertItem("Sunflower Seeds", "12.50","root", "For eating");
		 	test.insertItem("iPhone", "1200.00", "root","Black");
		 	test.insertItem("China Plates", "120.50", "root","Genuine ceramics");
		 	
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
		 	
		 
	        return true;
			
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
