<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "com.luv2code.jsp.*" %>
<%@ page import = "com.luv2code.jsp.AuthenticateServlet" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 



<html>

<meta charset="ISO-8859-1">


	<head>
		<title> login </title>
		<meta charset="utf-8">
	</head>

<h1>Test</h1><br><br>

<form action = "controller.jsp" method = "GET">
	<input type="submit" value="Initialize" name = "initialize">
	 <input type="hidden" name="FormName" value="Initialize"/>
</form>


<!--form for user to input their username and password.-->
 <form action="controller.jsp" method="POST" >
  Username:<br>
  <input type="text" name="Username"><br>
  Password:<br>
  <input type="text" name="Password"><br><br>
  <input type="hidden" name="FormName" value="Authenticate"/>
  <input type="submit" value="Submit">
</form> 
<h2>

<%= session.getAttribute("Username") %>
	
<%= request.getParameter("Username") %>


</h2>

</html>

