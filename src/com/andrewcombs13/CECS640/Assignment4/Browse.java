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
 * Servlet implementation class Browse
 */
@WebServlet("/Browse")
public class Browse extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public Browse() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        SQLExecuter executer = new SQLExecuter();
        if (executer.IsOpen())
        {
        	session.setAttribute("items", executer.getAllItems());
        	
            executer.Close();
        }
        else
        {
            session.setAttribute("error", "<span style'color:red'>Error! Could not connect to Database.</span>");
        }
        
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Browse.jsp");
        dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
