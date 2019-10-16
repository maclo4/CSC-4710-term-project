<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "com.luv2code.jsp.*" %>
<%@ page import = "com.luv2code.jsp.DbServlet" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 



<html>

<meta charset="ISO-8859-1">


	<head>
		<title> login </title>
		<meta charset="utf-8">
	</head>

<h1>Test</h1><br><br>
<% DbConnect test = new DbConnect(); %>
<form action = "initializeDb.jsp" method = "GET">
	<input type="submit" value="Initialize" name = "initialize">
</form>


<!--form for user to input their username and password.-->
 <form action="dbConnect.jsp" method="POST">
  Username:<br>
  <input type="text" name="Username"><br>
  Password:<br>
  <input type="text" name="Password"><br><br>
  <input type="submit" value="Submit">
</form> 
<h2>

<% /* String username = request.getParameter("Username");
	String password = request.getParameter("Password");
	DbConnect test = new DbConnect();
	test.insert(username, password);
	*/ %>
	
<%= request.getParameter("Username") %>


</h2>

</html>

