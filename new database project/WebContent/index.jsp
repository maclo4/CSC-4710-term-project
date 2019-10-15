<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "com.luv2code.jsp.*" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<% 
try {
    //Class.forName("com.mysql.jdbc.Driver");
	Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e) {
    throw new SQLException(e);
}
Connection connect = null;
connect = (Connection) DriverManager
	      .getConnection("jdbc:mysql://127.0.0.1:3306/projectdb?"
	          + "user=john&password=pass1234");
System.out.println(connect);
System.out.println("IT WORKED!!"); %>

<html>

<meta charset="ISO-8859-1">


	<head>
		<title> login </title>
		<meta charset="utf-8">
	</head>

<h1>Test</h1><br><br>


<!--form for user to input their username and password.-->
 <form action="dbConnect.jsp" method="post">
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

