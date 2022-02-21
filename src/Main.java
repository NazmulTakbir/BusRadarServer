import java.net.ServerSocket;
import java.net.Socket;

public class Main {
    public static void main(String[] args) {
        try {
            // 192.168.0.186
            ServerSocket welcomeSocket = new ServerSocket(6666);

            while(true) {
                Socket socket = welcomeSocket.accept();
                Thread worker = new QueryHandle(socket);
                worker.start();
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}




//import java.sql.*;

//class Main {
//    public static void main(String args[]){
//        try{
//            Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/BusRadar","postgres","takbir103");
//            Statement stmt=con.createStatement();
//            ResultSet rs=stmt.executeQuery("select * from public.\"Customer\"");
//            while(rs.next())
//                System.out.println(rs.getInt(1)+"  "+rs.getString(2));
//            con.close();
//        }catch(Exception e)
//        {
//            System.out.println(e);
//        }
//    }
//}

