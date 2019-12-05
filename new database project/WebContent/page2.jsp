<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "com.luv2code.jsp.*" %>
<%@ page import = "com.luv2code.jsp.AuthenticateServlet" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import= "java.util.List" %>
<%@ page import= "java.util.ArrayList" %>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Page 2</title>
</head>
<body>
<!-- CATEGORY SEARCH -->
<form action="controller.jsp" method="POST" >
  <h4>Search for users who have posted items in two <br>
   different categories, specified below, on the same day </h4>
  Category 1: <input type="text" name="CategoryX" ><br>
  Category 2: <input type="text" name="CategoryY" ><br>
  <input type = "hidden" name ="FormName" value ="GetCategoryXY" >
  <input type="submit" value="submit"></form>
  
  
  <%
  		// DECLARE VARIABLES FOR THE WHOLE PAGE HERE
  		
  		ItemClass itemSet = new ItemClass();
  		List<String> listTitles = new ArrayList<>(itemSet.getTitle());
 		PrintWriter output = response.getWriter();
 		DbFunctions dbFunctions = new DbFunctions();
  		UserClass userList = new UserClass();
        //user = String.valueOf(session.getAttribute("Username"));
        userList = dbFunctions.getUsers();
        List<String> listAllSellers = new ArrayList<>(userList.getUsername());
        
  %>
</table>


 <!-- ADD FAVORITE SELLER -->
<form action="controller.jsp" method="POST" > <br>
 <h4>Find Mutual Favorite Sellers </h4>
 
 <select name = "BuyerOne">
        <%  for(int i =0; i < listAllSellers.size(); i++){ %>
            <option value = "<%= listAllSellers.get(i)%>">
            <%= listAllSellers.get(i)%></option>
        <% } %>
  </select>
  <select name = "BuyerTwo">
        <%  for(int i =0; i < listAllSellers.size(); i++){ %>
            <option value = "<%= listAllSellers.get(i)%>">
            <%= listAllSellers.get(i)%></option>
        <% } %>
  </select>
  <input type = "hidden" name ="FormName" value ="FindMutualSellers" >
  <input type="submit" value="Find Mutual Favorites"></form>
  
  <br>
    <br>

<form action ="controller.jsp" method = "POST">
<h4>Find Seller With The Most Items</h4>
	<input type="hidden" name = "FormName" value="FindSellerWithMostItems">
	<input type = "submit" value="Search">
</form>
<br><br>

<%
  		ReviewClass userReviews = new ReviewClass();
        String user = String.valueOf(session.getAttribute("Username"));
        userReviews = dbFunctions.getGoodReviews(user);
        List<String> listUserReviews = new ArrayList<>(userReviews.getRating());
        List<String> listUserReviewItems = new ArrayList<>(userReviews.getTitle());
        
  %>
     <!-- Display table of favorite sellers -->
     <hr>
   
   <h2 align="center">Reviews by <%=user %></h2>
    
    <style> table, th, td {
  border: 1px solid black;
 
}</style>
    <table style="width:10%" align = "center">
    <tr>
    <th> </th>
    <th>Item </th>
    <th>Rating </th>
    </tr>
    <%
    	for(int i =0; i < listUserReviews.size(); i++){
    %>
  <tr>
  <th> <%=i+1%>: </th>
   
    <th> <%=listUserReviewItems.get(i) %></th>
    <th><%=listUserReviews.get(i)%></th>
    
  </tr>
   <%
   	}
   %>
   </table>
 

<br><br>

<form action = "home.jsp" method = "GET">
	<input type="submit" value="Home Page" name = "Home Page">
	</form>
</body>
</html>