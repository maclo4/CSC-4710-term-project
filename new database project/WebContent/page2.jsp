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
<form action="controller.jsp" method="POST" align = "center">
  <h3>Search for users who have posted items in two <br>
   different categories, specified below, on the same day </h3>
  Category 1: <input type="text" name="CategoryX" ><br>
  Category 2: <input type="text" name="CategoryY" ><br>
  <input type = "hidden" name ="FormName" value ="GetCategoryXY" >
  <input type="submit" value="submit"></form>
  
  <hr>
  
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



 <!-- ADD FAVORITE SELLER -->
<form action="controller.jsp" method="POST" align ="center"> <br>
 <h3>Find Mutual Favorite Sellers </h3>
 
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
  <hr>
    <br>

<form action ="controller.jsp" method = "POST" align = "center">
<h3>Find Seller With The Most Items</h3>
	<input type="hidden" name = "FormName" value="FindSellerWithMostItems">
	<input type = "submit" value="Search">
</form>
<br>
<br>

<%
  		ReviewClass userReviews = new ReviewClass();
        String user = String.valueOf(session.getAttribute("Username"));
        String seller = request.getParameter("Sellers");
        userReviews = dbFunctions.getGoodReviews(seller);
        List<String> listUserReviews = new ArrayList<>(userReviews.getRating());
        List<String> listUserReviewItems = new ArrayList<>(userReviews.getTitle());
        
  %>
     <!-- Display table of favorite sellers -->
     <hr>
   
   <h2 align="center">Good Reviews by <%=user %></h2>
    
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
   
   <br>
   <%
  		userList = new UserClass();
        //user = String.valueOf(session.getAttribute("Username"));
        userList = dbFunctions.getUsers();
        listAllSellers = new ArrayList<>(userList.getUsername());
        
  %>
</table>


 <!-- DROP DOWN BOX TO DISPLAY ALL THE USERS FROM WHICH TO CHOOSE -->
<form action="page2.jsp" method="POST" align="center" > <br>
 <h4> Choose a Seller </h4>
 
 <select name = "Sellers">
        <%  for(int i =0; i < listAllSellers.size(); i++){ %>
            <option value = "<%= listAllSellers.get(i)%>">
            <%= listAllSellers.get(i)%></option>
        <% } %>
  </select>
  <input type = "hidden" name ="FormName" value ="GetUserReviews" >
  <input type="submit" value="Add"></form>
  
 <br><br>
 
 <%
  		UserClass niceUsers = new UserClass();
        niceUsers = dbFunctions.listNoPoorReviews();
        List<String> listNiceUsers = new ArrayList<>(niceUsers.getUsername());
       
        
  %>
     <!-- Display table of nice users  -->
     <hr>
   
   <h2 align="center">Users With No Poor Reviews</h2>
    
    <style> table, th, td {
  border: 1px solid black;
 
}</style>
    <table style="width:10%" align = "center">
    <tr>
    <th> </th>
    <th>Item </th>
    
    </tr>
    <%
    	for(int i =0; i < listNiceUsers.size(); i++){
    %>
  <tr>
  <th> <%=i+1%>: </th>
   
    <th> <%=listNiceUsers.get(i) %></th>
    
    
  </tr>
   <%
   	}
   %>
   </table>
   
   <br>

<br><br>
<%
  		UserClass meanUsers = new UserClass();
        niceUsers = dbFunctions.listNoExcellentReviews();
        List<String> listMeanUsers = new ArrayList<>(niceUsers.getUsername());
       
        
  %>
     <!-- Display table of mean users-->
     <hr>
   
   <h2 align="center">Users With No Excellent Reviews</h2>
    
    <style> table, th, td {
  border: 1px solid black;
 
}</style>
    <table style="width:10%" align = "center">
    <tr>
    <th> </th>
    <th>Item </th>
    
    </tr>
    <%
    	for(int i =0; i < listMeanUsers.size(); i++){
    %>
  <tr>
  <th> <%=i+1%>: </th>
   
    <th> <%=listMeanUsers.get(i) %></th>
    
    
  </tr>
   <%
   	}
   %>
   </table>
   
   
   <br><br>
<%
  		UserClass poorUsers = new UserClass();
        niceUsers = dbFunctions.listAllReviewsPoor();
        List<String> listPoorUsers = new ArrayList<>(poorUsers.getUsername());
       
        
  %>
     <!-- Display table of poor users-->
     <hr>
   
   <h2 align="center">Users With All Reviews Poor</h2>
    
    <style> table, th, td {
  border: 1px solid black;
 
}</style>
    <table style="width:10%" align = "center">
    <tr>
    <th> </th>
    <th>User </th>
    
    </tr>
    <%
    	for(int i =0; i < listPoorUsers.size(); i++){
    %>
  <tr>
  <th> <%=i+1%>: </th>
   
    <th> <%=listPoorUsers.get(i) %></th>
    
    
  </tr>
   <%
   	}
   %>
   </table>   
   
   
        <!-- Display table of poor users-->
   
      <br><hr><br>
      
   <h2 align="center">Users Who Posted No Poor Reviews</h2>
    
   <!-- ================	List No Poor Reviews	================-->

	<form action="controller.jsp" method="POST" > <br>
	<h4>List Users Who Posted No Poor Reviews</h4>
	<input type = "hidden" name ="FormName" value="ListNoPoor" >
	<input type="submit" value="List Users">
	</form>

   
   
   <br><hr><br>
   
      
      <!-- ================	List No Poor Reviews	================-->

	<form action="controller.jsp" method="POST" align="center"> <br>
	<h4>List Users Who Have Given Each Other Only Excellent Reviews</h4>
	<select name = "User1">
        <%  for(int i =0; i < listAllSellers.size(); i++){ %>
            <option value = "<%= listAllSellers.get(i)%>">
            <%= listAllSellers.get(i)%></option>
        <% } %>
  </select>
  <select name = "User2">
        <%  for(int i =0; i < listAllSellers.size(); i++){ %>
            <option value = "<%= listAllSellers.get(i)%>">
            <%= listAllSellers.get(i)%></option>
        <% } %>
  </select>
	<input type = "hidden" name ="FormName" value="GetUserPairs" >
	<input type="submit" value="Find Pairs">
	</form>
   

<br><br>

	<form action="controller.jsp" method="POST" align="center"> <br>
	<h4>List Items By User With Only Excellent or Good Reviews </h4>
	<select name = "User1">
        <%  for(int i =0; i < listAllSellers.size(); i++){ %>
            <option value = "<%= listAllSellers.get(i)%>">
            <%= listAllSellers.get(i)%></option>
        <% } %>
  </select>
 
	<input type = "hidden" name ="FormName" value="GetExcellentItems" >
	<input type="submit" value="Find Pairs">
	</form>
   

<br><br>

<form action = "home.jsp" method = "GET">
	<input type="submit" value="Home Page" name = "Home Page">
	</form>
</body>
</html>