import java.sql.*;

public class DBModel {
    private static Connection con;
    private static DBModel instance;
    private static boolean on = false;
    private DBModel() throws SQLException {
        con=DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/BusRadar","postgres","takbir103");
    }
    public static DBModel getDB() throws SQLException {
        if(!on)
        {
            instance = new DBModel();
            on = true;
        }
        return instance;
    }

    public ResultSet selectQuery(String s) throws SQLException {
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(s);
        return rs;
    }

    public boolean manipulationQuery(String s)
    {

        try {
            Statement stmt=con.createStatement();
            stmt.executeQuery(s);
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

}















