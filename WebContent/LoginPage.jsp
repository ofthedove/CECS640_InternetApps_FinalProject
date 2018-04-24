<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Login | ACM Lending Library</title>
	
	<link rel="stylesheet" type="text/css" href="style.css">
	
</head>
<body>
	<div class="header">
		<div class="header-logo">
			<img class="header-logo" src="logo.png" alt="ACM Logo">
		</div>
		<h1 class="header-name">ACM Lending Library</h1>
		<div class="header-login">
			<p><a href="LoginPage.jsp">Login</a></p>
		</div>
	</div>
	
	<div class="login-container">
		<div class="login-modal">
			<form action="Login" method="GET">
				<div><label for="uname">Username:</label></div>
				<div><input type="text" name="uname"></div>
				<div><label for="pwd">Password:</label></div>
				<div><input type="password" name="pwd"></div>
				<input type="submit" value="Login">
			</form>
		</div>
	</div>
</body>
</html>