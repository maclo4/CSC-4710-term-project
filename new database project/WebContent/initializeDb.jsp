<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "com.luv2code.jsp.*" %>
<%@ page import = "com.luv2code.jsp.DbServlet" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>


<%// I made this page because I couldnt figure out how to use the servlets to cntralize calling functions 
// initialize DbConnect object to call functions from
DbConnect test = new DbConnect();
test.initializeDb();

String redirectURL = "index.jsp";
response.sendRedirect(redirectURL);
%>
