import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.lang.Math;
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
            else if( queryType.equalsIgnoreCase("busroute") ) {
                busroute();
            }

            socket.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void trendingSearches() throws Exception {
        ArrayList<String> trendingBuses = BusQuery.getTrendingList();

        boolean flag = false;
        ArrayList<String> selected = new ArrayList<>();
        while(true) {
            for( int i=0; i<trendingBuses.size(); i++ ) {
                if(  Math.random() < 0.5 ) {
                    selected.add(trendingBuses.get(i));
                    flag = true;
                }
            }
            if(flag) break;
        }

        out.writeObject(selected.size());
        for( int i=0; i<selected.size(); i++ ) {
            out.writeObject(selected.get(i));
        }
    }

    private void searchByName() throws Exception {
        String searchString = (String) in.readObject();

        ArrayList<String> trendingBuses = BusQuery.getBusList(searchString);

        out.writeObject(trendingBuses.size());
        for( int i=0; i<trendingBuses.size(); i++ ) {
            out.writeObject(trendingBuses.get(i));
        }
    }

    private void getRating() throws Exception {
        String busName = (String) in.readObject();

        double rating = BusQuery.getBusRating(busName);
        out.writeObject(rating);
    }

    private void getReview() throws Exception {
        String busName = (String) in.readObject();

        ArrayList<String> data = BusQuery.getComments(busName);
        if( data.size()>2 ) {
            out.writeObject(2);
            for( int i=0; i<2; i++ ) {
                String customer = data.get(i).split("#")[0];
                String comment = data.get(i).split("#")[1];
                out.writeObject(customer);
                out.writeObject(comment);
            }
        }
        else {
            out.writeObject(data.size());
            for( int i=0; i<data.size(); i++ ) {
                String customer = data.get(i).split("#")[0];
                String comment = data.get(i).split("#")[1];
                out.writeObject(customer);
                out.writeObject(comment);
            }
        }
    }

    private void srcdstquery() throws Exception {
        String src = (String) in.readObject();
        String dst = (String) in.readObject();

        ArrayList<String> data = StationQuery.getRoute(src, dst);
        out.writeObject(data.size());
        for( int i=0; i<data.size(); i++ ) {
            out.writeObject(data.get(i).split("#")[0]); // latitude
            out.writeObject(data.get(i).split("#")[1]); // longitude
            out.writeObject(Integer.toString(i+1)+". "+data.get(i).split("#")[2]); // address
        }
    }

    private void routequery() throws Exception {
        String src = (String) in.readObject();
        String dst = (String) in.readObject();
        System.out.println(src+","+dst);

        ArrayList<String> data = StationQuery.suggestedBuses(src, dst);
        System.out.println(data.size());
        out.writeObject(data.size());
        for( int i=0; i<data.size(); i++ ) {
            String name = data.get(i).split("#")[0];
            out.writeObject(name); // company name

            String rating = Double.toString(BusQuery.getBusRating(name));
            out.writeObject(rating);  // rating

            out.writeObject(data.get(i).split("#")[2]); // fare
        }
    }

    private void busroute() throws Exception {
        String busName = (String) in.readObject();

        String temp = BusQuery.getABusWithRoute(busName);
        ArrayList<String> data = StationQuery.getABusCompanyRoute(temp);
        String fareData = StationQuery.getMinMaxFare(temp);

        out.writeObject(data.size());
        for( int i=0; i<data.size(); i++ ) {
            out.writeObject(data.get(i).split("#")[0]); // latitude
            out.writeObject(data.get(i).split("#")[1]); // longitude
            out.writeObject(Integer.toString(i+1)+". "+data.get(i).split("#")[2]); // address
        }
        out.writeObject(fareData.split("#")[0]);
        out.writeObject(fareData.split("#")[1]);
    }
}