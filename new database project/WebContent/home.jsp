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

<br><br>

<!-- CATEGORY SEARCH -->
<form action="controller.jsp" method="POST" >
  <h4>Search Items By Category </h4><br>
  <input type="text" name="SearchCategory"><br>
  <input type = "hidden" name ="FormName" value ="CategorySearch" >
  <input type="submit" value="submit"></form>


<!-- LIST MOST EXPENSIVE -->
<form action="controller.jsp" method="POST" > <br>
<h4>List Most Expensive Item in Each Category</h4>
  <input type = "hidden" name ="FormName" value ="Expensive" >
  <input type="submit" value="List Most Expensive"></form>

<br> 
<br>
<% 
// declare instances of the other classes in the package
// DbFunctions has all the important functions
// ItemClass stores information about the query
// listTitles stores the names of the 
DbFunctions searchItems = new DbFunctions();
ItemClass itemSet = new ItemClass();
itemSet = searchItems.SearchItems();
List<String> listTitles = new ArrayList<>(itemSet.getTitle());
PrintWriter output = response.getWriter();
%>

   <%
    ItemClass favoriteItemSet = new ItemClass();
    String user = String.valueOf(session.getAttribute("Username"));
    favoriteItemSet = searchItems.SearchFavorites(user);
    List<String> listFavorites = new ArrayList<>(favoriteItemSet.getTitle());
    List<String> listFavoriteID = new ArrayList<>(favoriteItemSet.getID());
    %>
    
    <!-- Display table of favorite items -->
    <h4>Favorite Items for current user</h4>
    
    <style> table, th, td {
  border: 1px solid black;
}</style>
    <table style="width:10%" >
    <tr> <%= user %></tr>
    <%  for(int i =0; i < listFavorites.size(); i++){ %>
  <tr>
  <th> <%=i+1 %>: </th>
    <th><%= listFavorites.get(i)%></th>
    
  </tr>
   <% } %>
 
</table>
<!-- ADD FAVORITE ITEM -->
<form action="controller.jsp" method="POST" > <br>
 <h4> Add Items to Favorite List </h4>
 
 <select name = "FavItem">
        <%  for(int i =0; i < listTitles.size(); i++){ %>
            <option value = "<%= listTitles.get(i)%>">
            <%= listTitles.get(i)%></option>
        <% } %>
  </select>
  <input type = "hidden" name ="FormName" value ="AddFavorite" >
  <input type="submit" value="Add"></form>
  
  <br>
    <br>
 
 <!-- DELETE FAVORITE ITEM -->
<form action="controller.jsp" method="POST" > <br>
 <h4> Delete Items from Favorite List </h4>
 

 <select name = "DeleteItem">
        <%  for(int i =0; i < listFavorites.size(); i++){ %>
            <option value = "<%= listFavoriteID.get(i)%>">
            <%= listFavorites.get(i)%></option>
        <% } %>
  </select>
  <input type = "hidden" name ="FormName" value ="DeleteFavorite" >
  <input type="submit" value="Add"></form>  

  
        
<br> 
<br>

  
</body>
</html>