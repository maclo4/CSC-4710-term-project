<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "com.luv2code.jsp.*" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<%
 	String username = request.getParameter("Username");
 	String password = request.getParameter("Password");
 	DbFunctions test = new DbFunctions();
 	boolean authenticate = test.authenticate(username, password);
 	
 	if(authenticate == true)
 	{
 	//String username=request.getParameter("Username"); 
 	out.print("Welcome "+ username);
 	session.setAttribute("sessname",username); }
 %>
	
<%
    String redirectURL = "index.jsp";
    response.sendRedirect(redirectURL);
%>
