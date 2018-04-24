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
			<img class="header-logo" src="logo.png" alt="ACM Logo">
		</div>
		<h1 class="header-name">ACM Lending Library</h1>
		<a class="header-login" href="LoginPage.jsp">Login</a>
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