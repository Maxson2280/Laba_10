package org.example;

import java.sql.*;
import java.sql.Statement.*;
public class Main {
    private static Connection connection;

    private static Statement statement;

    public static void main(String[] args) {
        try{
            connect();
            ResultSet rs = statement.executeQuery("SELECT * from students");
            statement.executeUpdate("delete from students where postgres.public.students.id_students = 3");
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally {
            disconect();
        }
    }

    public static void connect() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postger", "postgres","23011992==");
            System.out.println(connection);
            statement = connection.createStatement();
        }
        catch (ClassNotFoundException | SQLException e) {
            throw new SQLException("Unable the connect database");
        }

    }
    private static void disconect() {
        try{
            statement.close();
        } catch (SQLException e){
            e.printStackTrace();
        }
    }
}