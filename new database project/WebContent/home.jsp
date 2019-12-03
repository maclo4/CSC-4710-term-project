<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "com.luv2code.jsp.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import= "java.util.List" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
</head>
<body>
<h1>Home Page</h1>
<br>



<!-- forms to add an item to the database  -->
 <form action="controller.jsp" method="POST" >
  <h4>Insert Item into Database: </h4>
  <input type="text" name="ItemName"><br>
  
  Description:<br>
  <textarea id="msg" name="Description" 
  rows = "8" cols = "70">Description...</textarea> <br>
  
  Category: <br>
  <input type="text" name="Category"> <br>
  
  Price: <br>
  <input type = "text" name = "Price"><br>
  
  <input type="hidden" name="FormName" value="AddItem"/>
  <br>
  <input type="submit" value="Submit">
</form> 

<br>
<hr><br>

<!-- CATEGORY SEARCH -->
<form action="controller.jsp" method="POST" >
  <h4>Search Items By Category </h4><br>
  <input type="text" name="SearchCategory"><br>
  <input type = "hidden" name ="FormName" value ="CategorySearch" >
  <input type="submit" value="submit"></form>

<!-- ADD REVIEW -->
<form action="controller.jsp" method="POST" >
  <h4>Add Review By Item</h4><br>
  <input type="text" name="AddReview"><br>
  <input type = "hidden" name ="FormName" value ="AddReview">
  <input type="submit" value="submit"></form>


<hr>
<!-- LIST MOST EXPENSIVE -->
<form action="controller.jsp" method="POST" > <br>
<h4>List Most Expensive Item in Each Category</h4>
  <input type = "hidden" name ="FormName" value ="Expensive" >
  <input type="submit" value="List Most Expensive"></form>

<br> 
<hr>
<br>

<% 
// declare instances of the other classes in the package
// DbFunctions has all the important functions
// ItemClass stores information about the query
// listTitles stores the names of the 
DbFunctions dbFunctions = new DbFunctions();
ItemClass itemSet = new ItemClass();
itemSet = dbFunctions.SearchItems();
List<String> listTitles = new ArrayList<>(itemSet.getTitle());
PrintWriter output = response.getWriter();
%>

   <%
   	ItemClass favoriteItemSet = new ItemClass();
          String user = String.valueOf(session.getAttribute("Username"));
          favoriteItemSet = dbFunctions.getFavoriteItems(user);
          List<String> listFavorites = new ArrayList<>(favoriteItemSet.getTitle());
          List<String> listFavoriteID = new ArrayList<>(favoriteItemSet.getID());
   %>
    
    <!-- Display table of favorite items -->
    <h4>Favorite Items for current user</h4>
    
    <style> table, th, td {
  border: 1px solid black;
}</style>
    <table style="width:10%" >
    <tr> <%=user%></tr>
    <%
    	for(int i =0; i < listFavorites.size(); i++){
    %>
  <tr>
  <th> <%=i+1%>: </th>
    <th><%=listFavorites.get(i)%></th>
    
  </tr>
   <%
   	}
   %>
 
</table>
<!-- ADD FAVORITE ITEM -->
<form action="controller.jsp" method="POST" > <br>
 <h4> Add Items to Favorite List </h4>
 
 <select name = "FavItem">
        <%
        	for(int i =0; i < listTitles.size(); i++){
        %>
            <option value = "<%=listTitles.get(i)%>">
            <%=listTitles.get(i)%></option>
        <%
        	}
        %>
  </select>
  <input type = "hidden" name ="FormName" value ="AddFavorite" >
  <input type="submit" value="Add"></form>
  
  <br>
    <br>
 
 <!-- DELETE FAVORITE ITEM -->
<form action="controller.jsp" method="POST" > <br>
 <h4> Delete Items from Favorite List </h4>
 

 <select name = "DeleteItem">
        <%
        	for(int i =0; i < listFavorites.size(); i++){
        %>
            <option value = "<%=listFavoriteID.get(i)%>">
            <%=listFavorites.get(i)%></option>
        <%
        	}
        %>
  </select>
  <input type = "hidden" name ="FormName" value ="DeleteFavorite" >
  <input type="submit" value="Add"></form>  

  
        
<br> 
<hr>
<br>

  
   <%
  		ItemClass favoriteSellerSet = new ItemClass();
        user = String.valueOf(session.getAttribute("Username"));
        favoriteSellerSet = dbFunctions.getFavoriteSellers(user);
        List<String> listFavoriteSellers = new ArrayList<>(favoriteSellerSet.getUsername());
        
  %>
     <!-- Display table of favorite sellers -->
    <h4>Favorite Sellers for current user</h4>
    
    <style> table, th, td {
  border: 1px solid black;
}</style>
    <table style="width:10%" >
    <tr> <%=user%></tr>
    <%
    	for(int i =0; i < listFavoriteSellers.size(); i++){
    %>
  <tr>
  <th> <%=i+1%>: </th>
    <th><%=listFavoriteSellers.get(i)%></th>
    
  </tr>
   <%
   	}
   %>
   
   
 <%
  		UserClass userList = new UserClass();
        //user = String.valueOf(session.getAttribute("Username"));
        userList = dbFunctions.getUsers();
        List<String> listAllSellers = new ArrayList<>(userList.getUsername());
        
  %>
</table>


 <!-- ADD FAVORITE SELLER -->
<form action="controller.jsp" method="POST" > <br>
 <h4> Add Sellers to Favorite List </h4>
 
 <select name = "FavSeller">
        <%  for(int i =0; i < listAllSellers.size(); i++){ %>
            <option value = "<%= listAllSellers.get(i)%>">
            <%= listAllSellers.get(i)%></option>
        <% } %>
  </select>
  <input type = "hidden" name ="FormName" value ="AddFavoriteSeller" >
  <input type="submit" value="Add"></form>
  
  <br>
    <br>
    
 <!-- DELETE FAVORITE SELLER -->
<form action="controller.jsp" method="POST" > <br>
 <h4> Delete Sellers from Favorite List </h4>
 
 <select name = "DeleteFavSeller">
        <%  for(int i =0; i < listFavoriteSellers.size(); i++){ %>
            <option value = "<%= listFavoriteSellers.get(i)%>">
            <%= listFavoriteSellers.get(i)%></option>
        <% } %>
  </select>
  <input type = "hidden" name ="FormName" value ="DeleteFavoriteSeller" >
  <input type="submit" value="Delete"></form>
  
  <br>
  <br>
  <form action = "page2.jsp" method = "GET">
	<input type="submit" value="Next Page" name = "Next Page">
</form>
<br> <br>
    <br>
 
  
</body>
</html>