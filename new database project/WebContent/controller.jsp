<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "com.luv2code.jsp.*" %>
<%@ page import = "com.luv2code.jsp.AuthenticateServlet" %>
<%@ page import = "com.luv2code.jsp.DbFunctions" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import= "java.util.List" %>
<%@ page import= "java.util.regex.Matcher"%>
<%@ page import= "java.util.regex.Pattern"%>

<%
	// I made this page because I couldnt figure out how to use the servlets to cntralize calling functions 
// initialize DbConnect object to call functions from

// ====================================================================
// IMPORTANT VARIABLES
// ====================================================================
String htmlFormName = request.getParameter("FormName");
DbFunctions test = new DbFunctions();
Statement statement = null;
ResultSet results = null;
PrintWriter output = response.getWriter();
String redirectURL;

// get user
Object sessionUserObject = session.getAttribute("Username");
String sessionUser = String.valueOf(sessionUserObject);

switch(htmlFormName) {

// ====================================================================
// AUTHENTICATE CASE
// ====================================================================
  case "Authenticate":
    // code block
    
     // get http parameters
    String username = request.getParameter("Username");
 	String password = request.getParameter("Password");
 	
 	out.println(username + " " + password);
 	
 	// auth will be changed if the password and username match the database
 	Boolean auth = false;
 	
 	//DbConnect test = new DbConnect();
 	
 	// try calling the suthenticate function
 	try {
 	// call authenticate function and store boolean value
 	auth = test.authenticate(username, password);
 	}
 	catch(Exception e) { 
 		System.out.println(e);}
 	
 	if(auth == true)
 	{
 		out.println("<br> authenticated: redirect here in future parts");
 		session.setAttribute("Username", username); 
 		redirectURL = "home.jsp";
 		response.sendRedirect(redirectURL);
 	}
 	else {
 	
 		out.println("<br> Incorrect password or username: redirect here in future parts");
 		redirectURL = "index.jsp";
 		response.sendRedirect(redirectURL);
 	}
 	out.println(session.getAttribute("Username"));
 	
    break;
    
// =======================================================
// INITIALIZE CASE
// =======================================================
  case "Initialize":
    // code block
    test.initializeDb();
    redirectURL = "index.jsp";
    response.sendRedirect(redirectURL);
    break;
  
// ========================================================
// ADD ITEM CASE
// ========================================================
  case "AddItem":
	  output = response.getWriter();
	  output.println("Form submitted: " + htmlFormName);
	  
	  // REFACTOR SO THAT THESE ARE DECLARED AT THE TOP OF THE PAGE
	  // Get parameters from form
	  String ItemName = request.getParameter("ItemName");
	  String Description = request.getParameter("Description");
	  String Category = request.getParameter("Category");
	  String Price = request.getParameter("Price");
	  
	 
	  // call functions to add to database
	  test.insertItem(ItemName, Price, sessionUser, Description);
	  test.insertCategory(ItemName, Category);
	  
	 // test.insertCategory("iPhone", "more trash 2.0");
	  // display item
	  /* ReturnObject categories = new ReturnObject();
	  categories = test.categorySearch("fruit");
	  List<String> readCat = new ArrayList<>(categories.getCategories());
	  
	  output.println("Printing in the controller jsp!!! " +readCat.get(0)); */
		break;
// ========================================================	  
// SEARCH BY CATEGORY
// ========================================================
  case "CategorySearch":
	  
	output.println("Form submitted: " + htmlFormName);
	try{
		String ItemCategory = request.getParameter("SearchCategory");
		ItemClass item = new ItemClass();
		item = test.categorySearch(ItemCategory);
		List<String> readCat = new ArrayList<>(item.getTitle());
		
		
		output.print(" <br> " + ItemCategory +  " items: " );
		for(String currItem : readCat)
		{
			output.println(" <br>" + currItem);
		}
		//printItem(item, response);
		}
	catch(Exception e){System.out.println(e);}
	
	  // display item
	  
		break;

// ========================================================
// LIST MOST EXPENSIVE
// ========================================================
  case "Expensive":
	  ItemClass item = new ItemClass();
		item = test.getMostExpensive();
		
		
		List<String> listName = new ArrayList<>(item.getTitle());
		List<String> listPrice = new ArrayList<>(item.getPrice());
		List<String> listCategory = new ArrayList<>(item.getCategory());
		
		System.out.println("outside getExpensive for loop");
		for (int i=0; i < listName.size(); i++){
			System.out.println("inside getExpensive for loop");
			out.println("Category:  " + listCategory.get(i) + "<br>");
			out.println("Item Name:  " +listName.get(i) + "<br>");
			out.println("Price:  " + listPrice.get(i) + "<br> <hr> <br>");}
	  
	  break;
	  

// ========================================================
// ADD FAVORITE ITEM
// ========================================================
  case "AddFavorite":
	  
	sessionUserObject = session.getAttribute("Username");
	sessionUser = String.valueOf(sessionUserObject);
	System.out.println(sessionUser);
	
	String FavItem = request.getParameter("FavItem");
	output.println(sessionUser + ": fav item:  "+ FavItem);
	
	test.addFavItem(sessionUser, FavItem);
	
	// redirect back
	redirectURL = "home.jsp";
	response.sendRedirect(redirectURL);
	
	break;
	
// =========================================================
// ADD FAVORITE SELLER
// =========================================================
  case "AddFavoriteSeller":
	  
		System.out.println(sessionUser);
		
		String FavSeller = request.getParameter("FavSeller");
		output.println(sessionUser + ": fav seller:  "+ FavSeller);
		
		test.addFavSeller(FavSeller, sessionUser);
		
		// redirect back
		redirectURL = "home.jsp";
		response.sendRedirect(redirectURL);
		
		break;

// =========================================================
// ADD FAVORITE SELLER
// =========================================================
  case "DeleteFavoriteSeller":
	  
		System.out.println("User to delete: " + sessionUser);
		
		FavSeller = request.getParameter("DeleteFavSeller");
		System.out.println(sessionUser + ": fav seller:  "+ FavSeller);
		
		test.deleteFavSeller(sessionUser, FavSeller);
		
		// redirect back
		redirectURL = "home.jsp";
		response.sendRedirect(redirectURL);
		
		break;
			
// ========================================================
// ADD REVIEW
// ========================================================
  case "AddReview":
	  
	  output = response.getWriter();
	  output.println("Form submitted: " + htmlFormName);
	  
	  String reviewer = sessionUser;
	  String reviewItem = request.getParameter("ReviewItem");
	  String review = request.getParameter("ReviewDescription");
	  String rating = request.getParameter("ReviewRating");
	
	  output.println("review rating: " + rating);
	
	 
		test.addReview(reviewer, reviewItem, review, rating);
 	// redirect back
 		redirectURL = "home.jsp";
 		response.sendRedirect(redirectURL);
 	
	  break;


// ========================================================
// LIST NO POOR REVEIWS
// ========================================================
  case "ListNoPoor":	 
	  
	  UserClass niceUsers = new UserClass();
	  niceUsers = test.listNoPoorReviews();
		
		List<String> listReviewers = new ArrayList<>(niceUsers.getUsername());
		
		System.out.println("outside listNoPoor for loop");
		for (int i=0; i < listReviewers.size(); i++){
			System.out.println("inside listNoPoor for loop");
			out.println("Item Name:  " +listReviewers.get(i) + "<br>");}
			
		break;
			

// ========================================================
// LIST USERS WITH ITEMS THAT HAVE NO EXCELLENT REVIEWS
// ========================================================
  case "ListNoExcellent":	 
	  /*
	  ReviewClass reviewuser2 = new ReviewClass();
	  reviewuser2 = test.listNoPoorReviews();
		
		
		List<String> listUsers = new ArrayList<>(reviewuser2.getUsername());
		
		System.out.println("outside listNoExcellent for loop");
		for (int i=0; i < listUsers.size(); i++){
			System.out.println("inside listNoExcellent for loop");
			out.println("User Name:  " +listUsers.get(i) + "<br>");}
			
		*/
		break;
			
 
// ========================================================
// ADD FAVORITE ITEM
// ========================================================
  case "DeleteFavorite":
	  
	  // these variables are defined on line 160 in the add favorite case
	  sessionUserObject = session.getAttribute("Username");
		sessionUser = String.valueOf(sessionUserObject);
		System.out.println(sessionUser);
		
		// get the form parameter
		String deleteItemID = request.getParameter("DeleteItem");
		output.println(sessionUser + ": deleted item:  "+ deleteItemID);
		
		// dbFunction variable that calls deleteFavItem function
		test.deleteFavItem(sessionUser, deleteItemID);
		
		// redirect back
		redirectURL = "home.jsp";
    	response.sendRedirect(redirectURL);
 		
	  break;
// ========================================================
// ADD FAVORITE ITEM
// ========================================================
  case "NewUser":
	  String newPassword = request.getParameter("Password");
	  String verifyPassword = request.getParameter("VerifyPassword");
	  String email = request.getParameter("Email");
	  String newUsername = request.getParameter("Username");
	  String firstName = request.getParameter("FirstName");
	  String lastName = request.getParameter("LastName");
	  String gender = request.getParameter("Gender");
	  String age = request.getParameter("Age");
	  
	  Boolean validateEmail = validEmail(email);
	  Boolean emailExists = test.searchForEmail(email);
	  Boolean usernameExists = test.searchForUsername(newUsername);
	  
	  if(!usernameExists && !emailExists && newPassword.equals(verifyPassword) && validateEmail){
		  output.println("new user validated");
	 		test.insertUser(newUsername,newPassword, email,
	 				  firstName, lastName, gender, age, false);
	 		
	 		// redirect back
			session.setAttribute("ValidUser", "Valid Inputs");
			redirectURL = "index.jsp";
	    	response.sendRedirect(redirectURL);
	  }
	  else{
		// redirect back
			session.setAttribute("ValidUser", "Invalid Inputs");
			redirectURL = "index.jsp";
	    	response.sendRedirect(redirectURL);
		}
	  
	  
 		
	  break;

// ========================================================
// Get users who posted items in category X and Y
// ========================================================
  case "GetCategoryXY":
	  
	  ItemClass result;
	  String X = request.getParameter("CategoryX");
	  String Y = request.getParameter("CategoryY");
	  result = test.getCatXY(X, Y);
	  List<String> userList = result.getUsername();
	  session.setAttribute("CatXY", userList);
	  output.println("<h3>Users who posted items with category "+ X + " and " + Y + " on the same day</h3>");
	  int size = userList.size();
	  
	  for(int i =0; i<size; i++){
	  output.println(i+1 + ": "+ userList.get(i) + "<br>");}
	  
	  break;
	  
// ========================================================
// Find mutual favorite sellers
// ========================================================
  case "FindMutualSellers":
	  
	String userOne = request.getParameter("BuyerOne");
	String userTwo = request.getParameter("BuyerTwo");
	
	UserClass users = new UserClass();
	users = test.getMutualFavoriteSellers(userOne, userTwo);
	List<String> mutualSellers = users.getUsername();
	
	 output.println("<h3>Mutually favorited sellers from "+ userOne + " and " + userTwo + "<h3>");
	  size = mutualSellers.size();
	  
	  for(int i =0; i<size; i++){
	  output.println(i+1 + ": "+ mutualSellers.get(i) + "<br>");}
	  
	  break;
// ========================================================
// Find mutual favorite sellers
// ========================================================
  case "FindSellerWithMostItems":
	  
	  UserClass maxSellers = new UserClass();
	  
	  maxSellers = test.FindMaxItems();
	  
	  List<String> sellerList = maxSellers.getUsername();
	  
	  output.println("<h3> User(s) with the most items <h3>");
	  size = sellerList.size();
	  
	  for(int i =0; i<size; i++){
	  output.println(i+1 + ": "+ sellerList.get(i) + "<br>");}
	  
	  break;

  case "GetUserReviews":
	  	  
	  break;

  case "GetUserPairs": 
	  
	  // get the html super variables
	  String user1 = request.getParameter("User1");
	  String user2 = request.getParameter("User2");
	  
	  // these will all be necessary
	  ItemClass user1Items = new ItemClass();
	  ReviewClass user1Reviews = new ReviewClass();
	  
	  ItemClass user2Items = new ItemClass();
	  ReviewClass user2Reviews = new ReviewClass();
	
	  // spend some lines just initializing all these arrays, then ill search thru each of them
	  user1Items = test.getItemsByUser(user1);
	  user1Reviews = test.getReviewsByUser(user1);
	  
	  user2Items = test.getItemsByUser(user2);
	  user2Reviews = test.getReviewsByUser(user2);
	  
	  List<String> user1ItemIDs = user1Items.getID();
	  List<String> user1ReviewIDs = user1Reviews.getID();
	  List<String> user1Ratings = user1Reviews.getRating();	  
	  
	  List<String> user2ItemIDs = user2Items.getID();
	  List<String> user2ReviewIDs = user2Reviews.getID();
	  List<String> user2Ratings = user2Reviews.getRating();
	  
	  
	  String ratingString;
	  String IDString;
	  Boolean flag = false;
	  Boolean passed = true;

	  for (int i = 0; i< user1ItemIDs.size(); i++){
	  	

	  	for(int j=0; j< user2ReviewIDs.size(); j++){
	  		
	  		IDString = user1ItemIDs.get(i);
	  		
	  		if(IDString.equals(user2ReviewIDs.get(j)))
	  		{
	  			ratingString = user2Ratings.get(j);
	  			
	  			if(ratingString.equals("Excellent")){
	  				
	  				flag = true;}
	  		}
	  	
	  	}
	  	if(flag == false){
	  		output.println("<br>No excellent reviews from " + user2 + " for item with ID:" + user1ItemIDs.get(i));
	  		passed = false;}
	  	
	  	flag = false;
	 
	  }
	  
	  Boolean flag2 = false;
	  Boolean passed2 = true;

	  for (int i = 0; i< user2ItemIDs.size(); i++){
		  	
		  
	  	for(int j=0; j< user1ReviewIDs.size(); j++){
	  		
	  		IDString = user2ItemIDs.get(i);
	  		
	  		if(IDString.equals(user1ReviewIDs.get(j)))
	  		{
	  			ratingString = user1Ratings.get(j);
	  			
	  			if(ratingString.equals("Excellent")){
	  				
	  				flag2 = true;}
	  		}
	  	
	  	}

	  	if(flag2 == false)
	  		{output.println("<br>No excellent reviews from " + user1 + " for item with ID:" + user2ItemIDs.get(i));
	  		passed2 = false;}
	  	
	  	flag2 = false;
	  	
	  }
	  
	  
	  if(passed == true && passed2 == true)
		  output.println("<br>The test passed, each user has given excellent reviews to all of the items from the other user");
	  else
		  output.println("<br>Test was failed");
	  
	  break;
	  

// ========================================================
// FIND ITEMS BY USERS WITH ONLY EXCELLENT OR GOOD REVIEWS
// ========================================================
  case "GetExcellentItems":
	  
	// get the html super variables
	 user1 = request.getParameter("User1");
	 
	 ItemClass userItems = new ItemClass();
	 userItems = test.getItemsByUser(user1);
	 ReviewClass itemReviews = new ReviewClass();
	 List<String> listItemID= userItems.getID();
	 List<String> listItemNames= userItems.getTitle();
	 List<String> reviewRatings;
	 Boolean excellent = true;
	 Boolean empty = false;
	 String excellentString = "Excellent";
	 String goodString = "Good";
	 int countExcellent = 0;
	 
	 
	 for(int i = 0; i< listItemID.size(); i++){
		 itemReviews = test.getReviewsForItem(listItemID.get(i));
		 reviewRatings = itemReviews.getRating();
		 
		 for(int j = 0; j<reviewRatings.size(); j++){
			 
			 countExcellent++;
			 if(!(excellentString.equals(reviewRatings.get(j)) || goodString.equals(reviewRatings.get(j)))){
				 excellent = false;
			 }
		 }
		 
		if(countExcellent==0){
			empty = true;
		}
		 
		 if(excellent == true && empty ==false)
			 output.println("<br> "+ listItemNames.get(i) + 
					 ": All reviews for this item are Excellent or good<br>");
		 
		countExcellent=0;
		excellent = true;
		empty = false;
	 }
		  
	
	  break;
// ========================================================
// DEFAULT CASE
// ========================================================
  default:
    // code block
}
%>

<%! 
public static boolean validEmail(String email) 
{ 
    String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\."+ 
                        "[a-zA-Z0-9_+&*-]+)*@" + 
                        "(?:[a-zA-Z0-9-]+\\.)+[a-z" + 
                        "A-Z]{2,7}$"; 
                          
    Pattern pat = Pattern.compile(emailRegex); 
    if (email == null) 
        return false; 
    return pat.matcher(email).matches(); 
} 

   public void printItem(ItemClass item, ServletResponse response) throws IOException{
	
	PrintWriter out = response.getWriter();
	List<String> listName = new ArrayList<>(item.getTitle());
	List<String> listPrice = new ArrayList<>(item.getPrice());
	for (int i = 0; i < listName.size(); i++)
	out.println("<br> Item Name:  " +listName.get(i) + "<br>");
	
	}
%>