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
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public Login() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String successURL = "/WelcomePage.jsp";
        String failURL = "/LoginPage.jsp";
        Boolean succeeded = true;
        String errorMessage = "";
        
        String uname = request.getParameter("uname");
        String pwd = request.getParameter("pwd");
    	
    	String displayName = "";
        
        SQLExecuter executer = new SQLExecuter();
         if (executer.IsOpen())
        {
	        if (uname == null || uname.length() == 0)
	        {
	        	succeeded = false;
	        	errorMessage = "Username must be provided";
	        }
	        else
	        {
	            try
	            {
	            	displayName = executer.findUser(uname, pwd);
	                if (displayName.compareTo("") != 0)
	                {
	                    request.setAttribute("uname", displayName);
	                }
	                else
	                {
	                	succeeded = false;
	                	errorMessage = "Credentials not found in database";
	                }
	            }
	            catch (Exception e)
	            {
	            	succeeded = false;
	            	errorMessage = e.getMessage();
	                e.printStackTrace();
	            }
	        }

	        executer.Close();
	    }
	    else
	    {
	    	errorMessage = "<span style'color:red'>Error! Could not connect to Database.</span>";
	    }
        
        RequestDispatcher dispatcher = null;
        HttpSession session = request.getSession();
        
        if (succeeded)
        {
        	session.setAttribute("loggedIn", "success");
        	session.setAttribute("uname", displayName);
            dispatcher = getServletContext().getRequestDispatcher(successURL);
        } else {
        	session.setAttribute("errorMsg", errorMessage);
            dispatcher = getServletContext().getRequestDispatcher(failURL);
        }
        
        dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
