package com.andrewcombs13.CECS640.Assignment4;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import edu.louisville.ssoe.cecs.cecs640.controllers.ConnectionPool;
import edu.louisville.ssoe.cecs.cecs640.controllers.SQLUtil;
public class SQLExecuter
{
    private Boolean open   = false;
    Connection      connection;
    ConnectionPool  dbPool = ConnectionPool.getInstance("jdbc/AJCOMB01");
    
    public SQLExecuter()
    {
        super();
        connection = dbPool.getConnection();
        if (connection != null)
        {
            open = true;
        }
    }
    public Boolean IsOpen()
    {
        return open;
    }
    public void Close()
    {
        if (open)
        {
            dbPool.freeConnection(connection);
            System.out.println("Connection was freed");
        }
        else
        {
            System.out.println("Warning: Close was called on SQLExecuter more than once");
        }
    }
    public void finalize()
    {
        if (open)
        {
            System.out.println("Warning: SQLExecuter went out-of-scope without Close being called");
            Close();
        }
    }
    public String QueryToHTML(String query)
    {
        String result = "Query Failed!";
        if (IsOpen() == false)
        {
            return result + " No connection to database.";
        }
        try
        {
            Statement statement = connection.createStatement();
            // Determine if we're querying for data, or performing an operation
            if (query.toUpperCase().startsWith("SELECT"))
            {
                ResultSet resultSet = statement.executeQuery(query);
                result = SQLUtil.getHtmlTable(resultSet);
                resultSet.close();
            }
            else
            {
                int resultStatus = statement.executeUpdate(query);
                if (resultStatus == 0)
                {
                    result = "Statement executed successfully.";
                }
                else
                {
                    result = "Statement executed successfully. ";
                    if (resultStatus == 1)
                    {
                        result += resultStatus + " row affected.";
                    }
                    else
                    {
                        result += resultStatus + " rows affected.";
                    }
                }
            }
        }
        catch (SQLException e)
        {
            result += e.getMessage();
            System.out.println("An SQL Databse error occured!");
            System.out.println("Error message: " + e.getMessage());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("Stack Trace: " + e.getStackTrace());
        }
        return result;
    }
}
