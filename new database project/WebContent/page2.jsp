<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "com.luv2code.jsp.*" %>
<%@ page import = "com.luv2code.jsp.AuthenticateServlet" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

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

</body>
</html>