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
 * Servlet implementation class ClearTransactions
 */
@WebServlet("/ClearTransactions")
public class ClearTransactions extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public ClearTransactions() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String result = "";
		HttpSession session = request.getSession();
        
        SQLExecuter executer = new SQLExecuter();
        if (executer.IsOpen())
        {
        	Object uname = session.getAttribute("uname");
        	if (uname != null && uname instanceof String && !((String)uname).isEmpty() )
        	{
            	result = executer.clearTransactions();
        	}
        	else
        	{
        		result = "You must be logged in to clear transactions";
        	}
        	
        	session.setAttribute("clearResult", result);
        	
            executer.Close();
        }
        else
        {
            session.setAttribute("clearError", "<span style'color:red'>Error! Could not connect to Database.</span>");
        }
        
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Manage");
        dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}