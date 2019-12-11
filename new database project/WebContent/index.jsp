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

<h1>Login</h1><br><br>

<!-- =============== REQUIREMENT PART 1:1 =============== -->

<form action = "controller.jsp" method = "GET">
	<input type="submit" value="Initialize" name = "initialize">
	 <input type="hidden" name="FormName" value="Initialize"/>
</form>


<!--form for user to input their username and password.-->
<!-- =============== REQUIREMENT PART 1:2 =============== -->

 <form action="controller.jsp" method="POST" >
  Username:<br>
  <input type="text" name="Username"><br>
  Password:<br>
  <input type="text" name="Password"><br><br>
  <input type="hidden" name="FormName" value="Authenticate"/>
  <input type="submit" value="Submit">
</form> 
<% 
		String validateUser = "Valid Inputs";
		if(validateUser.equals(session.getAttribute("ValidUser")))
			{%><h4><font color = "red">New User Created</font></h4> <%}%>
<br><br><hr><br><br>
<h2> New? Sign up here
</h2>

<!--form for new user to input their username and password.-->
<!-- =============== REQUIREMENT PART 3:1 =============== -->

 <form action="controller.jsp" method="POST" >
  Username:
  <input type="text" name="Username"><br><br>
  Email: 
  <input type = "text" name="Email"><br><br>
  Password:
  <input type="text" name="Password"><br><br>
  Verify Password:
  <input type="text" name="VerifyPassword"><br><br>
  First Name:
  <input type="text" name="FirstName"><br><br>
  Last Name:
  <input type="text" name="LastName"><br><br>
  Age:
  <input type="text" name="Age"><br><br>
  Gender:
  <select name = "Gender">
  		<option value = "Male">Male</option>
  		<option value = "Female">Female</option>
  		<option value = "NonBinary">Non-binary</option>
  		<option value = "0">Would Rather Not Disclose</option>
  </select>
  <br><br>
  
  <input type="hidden" name="FormName" value="NewUser"/>
  <input type="submit" value="Submit">
</form> 
<% 
		validateUser = "Invalid Inputs";
		if(validateUser.equals(session.getAttribute("ValidUser")))
			{%><h4><font color = "red">Invalid Inputs</font></h4> <%}%>
<br><br><br><br><br>

</html>

