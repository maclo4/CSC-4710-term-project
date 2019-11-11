<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
</head>
<body>
<h1>Home Page</h1>
<br>

<!-- forms to ad an item to the database  -->
 <form action="controller.jsp" method="POST" >
  Insert Item into Database: <br>
  Item Name:<br>
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
  Search Items By Category <br>
  <input type="text" name="SearchCategory"><br>
  <input type = "hidden" name ="FormName" value ="CategorySearch" >
  <input type="submit" value="submit"></form>


<!-- LIST MOST EXPENSIVE -->
<form action="controller.jsp" method="POST" > <br>
  <input type = "hidden" name ="FormName" value ="Expensive" >
  <input type="submit" value="List Most Expensive"></form>

<!-- ADD FAVORITE ITEM -->
<form action="controller.jsp" method="POST" > <br>
  <input type = "text" name = "FavItem">
  <input type = "hidden" name ="FormName" value ="AddFavorite" >
  <input type="submit" value="Add"></form>
  
  
  <!-- forms to ad an item to the database  -->
 <form action="controller.jsp" method="POST" >
  Insert Item into Database: <br>
  Item Name:<br>
  <input type="text" name="ItemName"><br>
  
  Description:<br>
  <textarea id="msg" name="Description" 
  rows = "8" cols = "70">Description...</textarea> <br>
  
  Category: <br>
  <input type="text" name="Category"> <br>
  
  Price: <br>
  <input type = "text" name = "Price"><br>
  
  <input type="hidden" name="FormName" value="AddReview"/>
  <br>
  <input type="submit" value="Submit">
</form> 
  
</body>
</html>