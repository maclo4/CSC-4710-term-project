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
	  test.insertItem(ItemName, Price, Description);
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
	  
	  if(!test.searchUsers(newUsername) && newPassword.equals(verifyPassword) && validateEmail){
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