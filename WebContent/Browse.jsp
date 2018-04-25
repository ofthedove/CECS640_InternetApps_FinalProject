<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList,com.andrewcombs13.CECS640.Assignment4.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Browse | ACM Lending Library</title>
	
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
			<h1>Browse</h1>
			
			<%
				if (session.getAttribute("checkOutError") != null)
				{
					out.println(session.getAttribute("checkOutError"));
					
					session.removeAttribute("checkOutError");
					session.removeAttribute("checkOutResult");
				}
				else
				{
					if (session.getAttribute("checkOutResult") != null)
					{
						out.println("<p>" + (String)session.getAttribute("checkOutResult") + "</p>");
						session.removeAttribute("checkOutResult");
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
							out.println("<h2>Transactions</h2>");
							out.println("<table border=\"1\"><tr><td>Name</td><td>Status</td></tr>");
							out.println("<tr><td colspan=\"2\">Description</td></tr>");

							ArrayList<Item> items = (ArrayList<Item>)session.getAttribute("items");
							for (Item t: items) {
							    out.println("<tr>");
							    
							    out.println("<td>");
							    out.println(t.name);
							    out.println("</td><td>");
							    if (t.checkedOutBy == null || t.checkedOutBy.isEmpty()) {
								    out.println("Available (<a href=\"CheckOut?ItemID=" + t.ItemID + "\">check out</a>)");
							    } else {
								    out.println("Out: " + t.checkedOutBy);
							    }
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
			%>
		</div>
	</div>
</body>
</html>