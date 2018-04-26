<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList,com.andrewcombs13.CECS640.Assignment4.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Circulation | ACM Lending Library</title>
	
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
	
	<div class="content-container">
		<div class="content">
			<h1>Circulation</h1>
			
			<%
				if (session.getAttribute("checkInError") != null)
				{
					out.println(session.getAttribute("checkInError"));
					
					session.removeAttribute("checkInError");
					session.removeAttribute("checkInResult");
				}
				else
				{
					if (session.getAttribute("checkInResult") != null)
					{
						out.println("<p>" + (String)session.getAttribute("checkInResult") + "</p>");
						session.removeAttribute("checkInResult");
					}
				}
			%>
			
			<%
				if (session.getAttribute("error") != null)
				{
					out.println(session.getAttribute("error"));
				}
				else
				{
					if (session.getAttribute("items") != null)
					{
						if (session.getAttribute("items") instanceof String) {
							out.println("<p>" + (String)session.getAttribute("items") + "</p>");
						} else {
							ArrayList<Item> items = (ArrayList<Item>)session.getAttribute("items");
							
							if (items.size() == 0)
							{
								out.println("<p>You do not currently have any items checked out</p>");
							}
							else
							{
								out.println("<h2>Your Checked Out Items</h2>");
								out.println("<table border=\"1\"><tr><td>Name</td><td>Check In</td></tr>");
								out.println("<tr><td colspan=\"2\">Description</td></tr>");
	
								for (Item t: items) {
								    out.println("<tr>");
								    
								    out.println("<td>");
								    out.println(t.name);
								    out.println("</td><td>");
								    out.println("<a href=\"CheckIn?ItemID=" + t.ItemID + "\">Check In</a>");
								    out.println("</td>");
								    
								    out.println("</tr><tr>");
								    
								    out.println("<td colspan=\"2\">");
								    out.println(t.description);
								    out.println("</td>");
								    
								    out.println("</tr>");
								}
								
								out.println("</table>");
							}
						}
					}
				}
			%>
			
			<p>To check out an item, go to <a href="Browse">Browse</a></p>
		</div>
	</div>
</body>
</html>