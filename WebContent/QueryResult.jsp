<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>SQL Query Result Viewer | ACM Lending Library</title>
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
		<div class="queryResult-page">
			<p>Result of Query:</p>
			<p>${query}</p>
			<p>${queryResult}</p>
			<p>
				<a href="QuerySubmit.jsp">Submit Another Query</a>
			</p>
		</div>
	</div>
</body>
</html>