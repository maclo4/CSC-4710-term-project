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
<form action="controller.jsp" method="POST" >
  Search Items By Category <br>
  <input type="text" name="CategorySearch"><br>
  <input type = "hidden" name ="FormName" value ="CategorySearch" >
  <input type="submit" value="submit"></form>

</body>
</html>