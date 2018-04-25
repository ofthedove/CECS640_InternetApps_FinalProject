<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>SQL Query Submitter | ACM Lending Library</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<div class="header">
		<div class="header-logo">
			<a href="WelcomePage.jsp">
				<img class="header-logo" src="logo.png" alt="ACM Logo" title="Home">
			</a>
		</div>
		<h1 class="header-name">ACM Lending Library</h1>
		<div class="header-login"> <%
			if(session.getAttribute("uname") != null) {
				if (session.getAttribute("uname").toString().trim().isEmpty()) {
					out.println("<a href=\"LoginPage.jsp\">Login</a>");
				} else {
					out.print("<p>Hello ");
					out.print(session.getAttribute("uname").toString());
					out.println("! (<a href=\"LoginPage.jsp\">Log Out</a>)</p>");
				}
			} else {
				out.println("<a class=\"header-login\" href=\"LoginPage.jsp\">Login</a>");
			}
		%> </div>
	</div>
	
	<div class="menu">
		<ul>
			<a href="Browse"><li>Browse</li></a>
			<a href="Circulation"><li>Circulation</li></a>
			<a href="Manage"><li>Manage</li></a>
			<a href="QuerySubmit.jsp"><li>Query</li></a>
		</ul>
	</div>

	<div class="sql-container">
		<div class="sqlSubmit-modal">
			<form action="LendingLibrarySQLProcessor" method="POST">
				<div>
					<label for="query">SQL Query:</label>
				</div>
				<div>
					<textarea rows="3" cols="80" name="query"></textarea>
				</div>
				<input type="submit" value="Submit Query" class="right-align">
			</form>
		</div>
	</div>
</body>
</html>