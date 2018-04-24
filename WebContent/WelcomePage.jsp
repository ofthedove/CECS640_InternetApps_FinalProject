<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Welcome! | ACM Lending Library</title>
	
	<link rel="stylesheet" type="text/css" href="style.css">
	
</head>
<body>
	<div class="header">
		<img class="header-logo" src="logo.png" alt="ACM Logo">
		<h1 class="header-name">ACM Lending Library</h1>
		<%
			if(request.getAttribute("uname") != null) {
				if (request.getAttribute("uname").toString().trim().isEmpty()) {
					out.println("<a class=\"header-login\" href=\"LoginPage.jsp\">Login</a>");
				} else {
					out.print("<p>Hello ");
					out.print(request.getAttribute("uname").toString());
					out.print("! | ");
					out.println("<a class=\"header-login\" href=\"LoginPage.jsp\">Log Out</a></p>");
				}
			} else {
				out.println("<a class=\"header-login\" href=\"LoginPage.jsp\">Login</a>");
			}
		%>
	</div>
	
	<div class="content-container">
		<div class="content">
			<%
				if(request.getAttribute("loggedIn") != null) {
					if (request.getAttribute("loggedIn").toString().trim().equals("success")) {
						out.println("<p style=\"color:red;\"> You are now logged in!</p>");
					}
				}
			%>
			<p>Hello World</p>
			<p>This page is under development</p>
			<p>That is why there is so little content</p>
			<p>Sorry for the inconvenience</p>
		</div>
	</div>
</body>
</html>