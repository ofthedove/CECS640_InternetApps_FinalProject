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
		<div class="header-logo">
			<img class="header-logo" src="logo.png" alt="ACM Logo">
		</div>
		<h1 class="header-name">ACM Lending Library</h1>
		<div class="header-login"> <%
			if(session.getAttribute("uname") != null) {
				if (session.getAttribute("uname").toString().trim().isEmpty()) {
					out.println("<a href=\"LoginPage.jsp\">Login</a>");
				} else {
					out.print("<p>Hello ");
					out.print(session.getAttribute("uname").toString());
					out.print("! | ");
					out.println("<a href=\"LoginPage.jsp\">Log Out</a></p>");
				}
			} else {
				out.println("<a class=\"header-login\" href=\"LoginPage.jsp\">Login</a>");
			}
		%> </div>
	</div>
	
	<div class="menu">
		<ul>
			<a href="Browse.jsp"><li>Browse</li></a>
			<a href="Circulation.jsp"><li>Circulation</li></a>
			<a href="Manage.jsp"><li>Manage</li></a>
			<a href="QuerySubmit.jsp"><li>Query</li></a>
		</ul>
	</div>
	
	<div class="content-container">
		<div class="content">
			<%
				if(session.getAttribute("loggedIn") != null) {
					if (session.getAttribute("loggedIn").toString().trim().equals("success")) {
						out.println("<p style=\"color:red;\"> You are now logged in!</p>");
					}
				}
			%>
			<p>Use the Browse tab to view the items in the library</p>
			<p>Use the Circulation tab to check items in and out</p>
			<p>Use the Manage tab to manage library inventory (admin only)</p>
			<p>Use the Query tab to run queires directly against the database (admin only)</p>
		</div>
	</div>
</body>
</html>