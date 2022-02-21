import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        Path imagesBase = Paths.get(System.getProperty("user.dir"), "images");

        try {
            // 192.168.0.186
            ServerSocket welcomeSocket = new ServerSocket(6666);

            while(true) {
                Socket socket = welcomeSocket.accept();
                Thread worker = new Worker(socket, imagesBase);
                worker.start();
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}

class Worker extends Thread {
    Socket socket;
    Path imagesBase;

    public Worker(Socket socket, Path imagesBase) {
        this.socket = socket;
        this.imagesBase = imagesBase;
    }

    public void run() {
        try {
            ObjectOutputStream out = new ObjectOutputStream(this.socket.getOutputStream());
            ObjectInputStream in = new ObjectInputStream(this.socket.getInputStream());

            String queryType = (String) in.readObject();

            if( queryType.equalsIgnoreCase("trending") ) {
                ArrayList<String> trendingBuses = new ArrayList<>();
                trendingBuses.add("Boishakhi");
                trendingBuses.add("Silk Line");
                trendingBuses.add("Super");

                out.writeObject(trendingBuses.size());
                for( int i=0; i<trendingBuses.size(); i++ ) {
                    out.writeObject(trendingBuses.get(i));
                }
                System.out.println("SUCCESS");
            }

            socket.close();

        } catch (Exception e) {
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

