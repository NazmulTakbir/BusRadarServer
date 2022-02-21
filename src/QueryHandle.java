import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.ArrayList;

public class QueryHandle extends Thread {
    Socket socket;
    ObjectOutputStream out;
    ObjectInputStream in;

    public QueryHandle(Socket socket) {
        try {
            this.socket = socket;
            this.out = new ObjectOutputStream(this.socket.getOutputStream());
            this.in = new ObjectInputStream(this.socket.getInputStream());
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void run() {
        try {
            String queryType = (String) in.readObject();

            if( queryType.equalsIgnoreCase("trending") ) {
                trendingSearches();
            }
            else if( queryType.equalsIgnoreCase("namequery") ) {
                searchByName();
            }
            else if( queryType.equalsIgnoreCase("ratingquery") ) {
                getRating();
            }
            else if( queryType.equalsIgnoreCase("reviewquery") ) {
                getReview();
            }
            else if( queryType.equalsIgnoreCase("srcdstquery") ) {
                srcdstquery();
            }
            else if( queryType.equalsIgnoreCase("routequery") ) {
                routequery();
            }

            socket.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void trendingSearches() throws Exception {
        ArrayList<String> trendingBuses = new ArrayList<>();
        trendingBuses.add("Boishakhi");
        trendingBuses.add("Silk Line");
        trendingBuses.add("Super");

        out.writeObject(trendingBuses.size());
        for( int i=0; i<trendingBuses.size(); i++ ) {
            out.writeObject(trendingBuses.get(i));
        }
    }

    private void searchByName() throws Exception {
        String searchString = (String) in.readObject();

        ArrayList<String> trendingBuses = new ArrayList<>();
        trendingBuses.add("Boishakhi");
        trendingBuses.add("Boishakhi");
        trendingBuses.add("Silk Line");
        trendingBuses.add("Super");

        out.writeObject(trendingBuses.size());
        for( int i=0; i<trendingBuses.size(); i++ ) {
            out.writeObject(trendingBuses.get(i));
        }
    }

    private void getRating() throws Exception {
        String busName = (String) in.readObject();

        double rating = 4;
        out.writeObject(rating);
    }

    private void getReview() throws Exception {
        String busName = (String) in.readObject();

        int count = 2;
        out.writeObject(count);
        for( int i=0; i<count; i++ ) {
            out.writeObject("Takbir");
            out.writeObject("Good");
        }
    }

    private void srcdstquery() throws Exception {
        String src = (String) in.readObject();
        String dst = (String) in.readObject();

        out.writeObject("route data");
    }

    private void routequery() throws Exception {
        String routeData = (String) in.readObject();

        ArrayList<String> trendingBuses = new ArrayList<>();
        trendingBuses.add("Boishakhi");
        trendingBuses.add("Boishakhi");
        trendingBuses.add("Silk Line");
        trendingBuses.add("Super");

        out.writeObject(trendingBuses.size());
        for( int i=0; i<trendingBuses.size(); i++ ) {
            out.writeObject(trendingBuses.get(i));
        }
    }
}