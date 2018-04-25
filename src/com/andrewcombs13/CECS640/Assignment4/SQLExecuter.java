package com.andrewcombs13.CECS640.Assignment4;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

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
    
    public String findUser(String id, String password)
    {
        boolean foundUser = false;
        String displayName = "";
        
        String query = "SELECT * FROM USERS WHERE UNAME = '" + id + "' AND PASSWORD = '" + password + "'";
        
        try
        {
        	Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(query);
            if (rs.next())
            {
            	foundUser = true;
            	displayName = rs.getString("NAME");
            }
        }
        catch (SQLException e)
        {
            System.out.println(e.getMessage());
        }
        
        if (foundUser) {
        	return (displayName);
        } else {
        	return ("");
        }
    }
    
    public String checkOut(String ItemID, String uname)
    {
        String query = "UPDATE Items SET checkedOut = 1, checkedOutBy = '" + uname + "' WHERE ItemID = '" + ItemID + "'";
        String error = "Query Failed!";
        String success = "Successfully checked out item";
        
        if (IsOpen() == false)
        {
            return error + " No connection to database.";
        }
        try
        {
            Statement statement = connection.createStatement();
            int resultStatus = statement.executeUpdate(query);
            
            if (resultStatus == 0)
            {
            	error += " Unable to find item in database!";
            	return error;
            }
        }
        catch (SQLException e)
        {
        	error += e.getMessage();
            System.out.println("An SQL Databse error occured!");
            System.out.println("Error message: " + e.getMessage());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("Stack Trace: " + e.getStackTrace());
            return error;
        }
        
        return success;
    }
    
    public Object getAllItems()
    {
        return getMyItems(null);
    }
    
    public Object getMyItems(String username)
    {
        String query = "SELECT * FROM Items WHERE checkedOutBy = '" + username + "'";
    	if (username == null) {
    		query = "SELECT * FROM Items";
    	}
        String error = "Query Failed!";
        ArrayList<Item> resultList = new ArrayList<Item>();
        
        if (IsOpen() == false)
        {
            return error + " No connection to database.";
        }
        try
        {
            Statement statement = connection.createStatement();
            
            ResultSet resultSet = statement.executeQuery(query);
            
            while (resultSet.next())
            {
            	Item item = new Item();
            	item.ItemID = resultSet.getInt("ItemID");
            	item.name = resultSet.getString("name");
            	item.description = resultSet.getString("description");
            	item.checkedOut = resultSet.getInt("checkedOut") != 0;
            	item.checkedOutBy = resultSet.getString("checkedOutBy");
            	
            	resultList.add(item);
            }
            
            resultSet.close();
        }
        catch (SQLException e)
        {
        	error += e.getMessage();
            System.out.println("An SQL Databse error occured!");
            System.out.println("Error message: " + e.getMessage());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("Stack Trace: " + e.getStackTrace());
            return error;
        }
        return resultList;
    }
    
    public Object getAllTransactions()
    {
        String query = "SELECT * FROM transactions";
        String error = "Query Failed!";
        ArrayList<Transaction> resultList = new ArrayList<Transaction>();
        
        if (IsOpen() == false)
        {
            return error + " No connection to database.";
        }
        try
        {
            Statement statement = connection.createStatement();
            
            ResultSet resultSet = statement.executeQuery(query);
            
            while (resultSet.next())
            {
            	Transaction transaction = new Transaction();
            	
            	transaction.TransactionID = resultSet.getInt("TransactionID");
            	transaction.ItemID = resultSet.getInt("ItemID");
            	
            	String input = resultSet.getString("tdate");
            	SimpleDateFormat parser = new SimpleDateFormat("yyyy-mm-dd");
            	try { transaction.tdate = parser.parse(input); }
            	catch (ParseException e) { transaction.tdate = new Date(); }
            	
            	transaction.ttype = resultSet.getString("ttype");
            	transaction.description = resultSet.getString("description");
            	
            	resultList.add(transaction);
            }
            
            resultSet.close();
        }
        catch (SQLException e)
        {
        	error += e.getMessage();
            System.out.println("An SQL Databse error occured!");
            System.out.println("Error message: " + e.getMessage());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("Stack Trace: " + e.getStackTrace());
            return error;
        }
        return resultList;
    }
    
    public Object getAllUpdates()
    {
        String query = "SELECT * FROM updates";
        String error = "Query Failed!";
        ArrayList<Update> resultList = new ArrayList<Update>();
        
        if (IsOpen() == false)
        {
            return error + " No connection to database.";
        }
        try
        {
            Statement statement = connection.createStatement();
            
            ResultSet resultSet = statement.executeQuery(query);
            
            while (resultSet.next())
            {
            	Update update = new Update();
            	
            	update.UpdateID = resultSet.getInt("UpdateID");
            	update.ItemID = resultSet.getInt("ItemID");
            	
            	String input = resultSet.getString("udate");
            	SimpleDateFormat parser = new SimpleDateFormat("yyyy-mm-dd");
            	try { update.udate = parser.parse(input); }
            	catch (ParseException e) { update.udate = new Date(); }
            	
            	update.utype = resultSet.getString("utype");
            	update.description = resultSet.getString("description");
            	
            	resultList.add(update);
            }
            
            resultSet.close();
        }
        catch (SQLException e)
        {
        	error += e.getMessage();
            System.out.println("An SQL Databse error occured!");
            System.out.println("Error message: " + e.getMessage());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("Stack Trace: " + e.getStackTrace());
            return error;
        }
        return resultList;
    }
}
