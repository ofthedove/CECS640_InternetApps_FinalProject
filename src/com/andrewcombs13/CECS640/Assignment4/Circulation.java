package com.andrewcombs13.CECS640.Assignment4;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Circulation
 */
@WebServlet("/Circulation")
public class Circulation extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public Circulation() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        SQLExecuter executer = new SQLExecuter();
        if (executer.IsOpen())
        {
        	if (session.getAttribute("uname") != null && !((String)session.getAttribute("uname")).isEmpty()) {
        		session.setAttribute("items", executer.getMyItems((String)session.getAttribute("uname")));
        	} else {
        		session.setAttribute("items", "You must be logged in to view your items!");
        	}
        	
            executer.Close();
        }
        else
        {
            session.setAttribute("error", "<span style'color:red'>Error! Could not connect to Database.</span>");
        }
        
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Circulation.jsp");
        dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
