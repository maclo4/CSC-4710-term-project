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

switch(htmlFormName) {

// ====================================================================
// AUTHENTICATE CASE
// ====================================================================
  case "Authenticate":
    // code block
     String action = request.getServletPath();
     System.out.println("inside the authenticate" + htmlFormName);
    
     output.println("it workeddd" + action + "  :  " + htmlFormName);
     
     // actual code is here. Above is debugging
   
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
 		String redirectURL = "home.jsp";
 		response.sendRedirect(redirectURL);
 	}
 	else {
 	
 		out.println("<br> Incorrect password or username: redirect here in future parts");
 		String redirectURL = "index.jsp";
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
    String redirectURL = "index.jsp";
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
		List<String> readCat = new ArrayList<>(item.getPrice());
		
		
		output.println("Category found:  " +readCat.get(0));
		printItem(item, response);
		}
	catch(Exception e){System.out.println(e);}
	
	  // display item
	  
		break;
// ========================================================
// DEFAULT CASE
// ========================================================
  default:
    // code block
}
%>

<%! 
   public void printItem(ItemClass item, ServletResponse response) throws IOException{
	
	PrintWriter out = response.getWriter();
	List<String> listName = new ArrayList<>(item.getID());
	List<String> listPrice = new ArrayList<>(item.getPrice());
	for (int i = 0; i < listName.size(); i++)
	out.println("<br> Item Name:  " +listName.get(i) + "<br>");
	
	}
%>