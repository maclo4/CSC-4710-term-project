<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "com.luv2code.jsp.*" %>
<%@ page import = "com.luv2code.jsp.AuthenticateServlet" %>
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
	  
	  // display item
	  //ReturnObject categories = new ReturnObject();
	  //categories = test.categorySearch(Category);
	  //List<String> readCat = new ArrayList<>(categories.getCategories());
	  
	  //output.println("Printing in the controller jsp!!! " +readCat.get(0));
	  
	  
	  
		break;
// ========================================================	  
// SEARCH BY CATEGORY
// ========================================================
  case "CategorySearch":
	  
	output.println("Form submitted: " + htmlFormName);
	  // display item
	  Category = request.getParameter("CategorySearch");
	  output.println(Category);
	  ReturnObject categories = new ReturnObject();
	  categories = test.categorySearch(Category);
	  List<String> readCat = new ArrayList<>(categories.getCategories());
	  
	  output.println("Printing in the controller jsp!!! " +readCat.get(0));
	  
		break;
// ========================================================
// DEFAULT CASE
// ========================================================
  default:
    // code block
}

%>
