package com.andrewcombs13.CECS640.Assignment4;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LendingLibrarySQLProcessor")
public class LendingLibrarySQLProcessor extends HttpServlet
{
    private static final long serialVersionUID = 1L;
    
    public LendingLibrarySQLProcessor()
    {
        super();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        String query = request.getParameter("query");
        String htmlResult = "";
        
        // Execute the query
        SQLExecuter executer = new SQLExecuter();
        if (executer.IsOpen())
        {
            htmlResult = executer.QueryToHTML(query);
            executer.Close();
        }
        else
        {
            htmlResult = "<span style'color:red'>Error! Could not connect to Database.</span>";
        }
        
        // Set results and return to page
        HttpSession session = request.getSession();
        session.setAttribute("query", query);
        session.setAttribute("queryResult", htmlResult);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/QueryResult.jsp");
        dispatcher.forward(request, response);
    }
}
