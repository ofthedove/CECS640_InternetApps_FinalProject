<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList,com.andrewcombs13.CECS640.Assignment4.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Manage | ACM Lending Library</title>
	
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
			<h1>Manage</h1>
			
			<%
				if (session.getAttribute("clearError") != null)
				{
					out.println(session.getAttribute("clearError"));
					
					session.removeAttribute("clearError");
					session.removeAttribute("clearResult");
				}
				else
				{
					if (session.getAttribute("clearResult") != null)
					{
						out.println("<p>" + (String)session.getAttribute("clearResult") + "</p>");
						session.removeAttribute("clearResult");
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
					if (session.getAttribute("transactions") != null)
					{
						if (session.getAttribute("transactions") instanceof String) {
							out.println("<p>" + (String)session.getAttribute("transactions") + "</p>");
						} else {
							out.println("<h2>Transactions</h2>");
							out.println("<table border=\"1\"><tr><td>Item ID</td><td>Type</td><td>Date</td></tr>");
							out.println("<tr><td colspan=\"3\">Description</td></tr>");

							ArrayList<Transaction> transactions = (ArrayList<Transaction>)session.getAttribute("transactions");
							for (Transaction t: transactions) {
							    out.println("<tr>");
							    
							    out.println("<td>");
							    out.println(t.ItemID);
							    out.println("</td><td>");
							    out.println(t.ttype);
							    out.println("</td><td>");
							    out.println(t.tdate);
							    out.println("</td>");
							    
							    out.println("</tr><tr>");
							    
							    out.println("<td colspan=\"3\">");
							    out.println(t.description);
							    out.println("</td>");
							    
							    out.println("</tr>");
							}
							
							out.println("</table>");
							
							out.println("<a href=\"ClearTransactions\">Clear transaction log</a>");
						}
					}
					
					if (session.getAttribute("updates") != null)
					{
						if (session.getAttribute("updates") instanceof String) {
							out.println("<p>" + (String)session.getAttribute("transactions") + "</p>");
						} else {
							out.println("<h2>Updates</h2>");
							out.println("<table border=\"1\"><tr><td>Item ID</td><td>Type</td><td>Date</td></tr>");
							out.println("<tr><td colspan=\"3\">Description</td></tr>");
							
							ArrayList<Update> updates = (ArrayList<Update>)session.getAttribute("updates");
							for (Update u: updates) {
							    out.println("<tr>");
							    
							    out.println("<td>");
							    out.println(u.ItemID);
							    out.println("</td><td>");
							    out.println(u.utype);
							    out.println("</td><td>");
							    out.println(u.udate);
							    out.println("</td>");
							    
							    out.println("</tr><tr>");
							    
							    out.println("<td colspan=\"3\">");
							    out.println(u.description);
							    out.println("</td>");
							    
							    out.println("</tr>");
							}
							
							out.println("</table>");
						}
					}
				}
			%>
		</div>
	</div>
</body>
</html>