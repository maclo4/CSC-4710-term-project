<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "com.luv2code.jsp.*" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<% String username = request.getParameter("Username");
	String password = request.getParameter("Password");
	DbConnect test = new DbConnect();
	test.insert(username, password);%>
	
<%
    String redirectURL = "index.jsp";
    response.sendRedirect(redirectURL);
%>
