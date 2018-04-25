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
 * Servlet implementation class CheckOut
 */
@WebServlet("/CheckOut")
public class CheckOut extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public CheckOut() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ItemID = request.getParameter("ItemID");
        String result = "";
		HttpSession session = request.getSession();
        
        SQLExecuter executer = new SQLExecuter();
        if (executer.IsOpen())
        {
        	Object uname = session.getAttribute("uname");
        	if (uname != null && uname instanceof String && !((String)uname).isEmpty() )
        	{
            	result = executer.checkOut(ItemID, (String)session.getAttribute("uname"));
        	}
        	else
        	{
        		result = "You must be logged in to check out an item";
        	}
        	
        	session.setAttribute("checkOutResult", result);
        	
            executer.Close();
        }
        else
        {
            session.setAttribute("checkOutError", "<span style'color:red'>Error! Could not connect to Database.</span>");
        }
        
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Browse");
        dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
