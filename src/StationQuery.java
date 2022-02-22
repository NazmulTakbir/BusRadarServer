import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class StationQuery {
    private StationQuery()
    {

    }

    private static String[] convertRouteArray(String route)
    {
        String[] ans=route.trim().substring(1,route.length()-1).split(",");
        return ans;
    }

    private static String getCoordinate(String station_id)
    {
        station_id = "'"+station_id.toLowerCase().trim()+"'";
        String ans="";
        try {
            DBModel dbModel = DBModel.getDB();
            ResultSet rs = dbModel.selectQuery("select lactitude,longitude,address from bus_stops where bus_stop_id="+station_id);
            while (rs.next())
            {
                ans=ans+rs.getString(1)+"#"+rs.getString(2)+"#"+rs.getString(3);
                break;
            }
        } catch (SQLException e) {
            return ans;
        }
        return ans;
    }

    private static int getStationIndex(String station)
    {
        station = "'"+station.toLowerCase().trim()+"'";
        int ans=-1;
        try {
            DBModel dbModel = DBModel.getDB();
            ResultSet rs = dbModel.selectQuery("select bus_stop_id from bus_stops where lower(address)="+station);
            while (rs.next())
            {
                ans=rs.getInt(1);
                break;
            }
        } catch (SQLException e) {
            return ans;
        }
        return ans;
    }

    private static ArrayList<String> getRoute(int src,int dest)
    {
        ArrayList<String> route = new ArrayList<String>();
        try {
            DBModel dbModel = DBModel.getDB();
            ResultSet rs = dbModel.selectQuery("select bus_stop_list from bus_route where "+src+"=any(bus_stop_list) and "+dest+"=any(bus_stop_list)");
            String arrRoute="";
            while (rs.next())
            {
                arrRoute = arrRoute+rs.getString(1);
                break;
            }
            if(arrRoute.length()>0)
            {
                String []routeStationIDs = convertRouteArray(arrRoute);
                int cnt=0;
                boolean rev=false;
                String s=""+src;
                String d=""+dest;
                ArrayList<String> tempRoute = new ArrayList<String>();
                for(int i=0; i <routeStationIDs.length && cnt<2; i++)
                {
                    if(routeStationIDs[i].equals(s))
                    {
                        cnt++;
                        tempRoute.add(getCoordinate(routeStationIDs[i]));
                        rev = (cnt>1);
                    }
                    else if(routeStationIDs[i].equals(d))
                    {
                        cnt++;
                        tempRoute.add(getCoordinate(routeStationIDs[i]));
                    }
                    else if(cnt==1)
                    {
                        tempRoute.add(getCoordinate(routeStationIDs[i]));
                    }
                }
                if(rev)
                {
                    for(int i=tempRoute.size()-1;i>=0;i--)
                    {
                        route.add(tempRoute.get(i));
                    }
                }
                else
                {
                    for(int i=0;i<tempRoute.size();i++)
                    {
                        route.add(tempRoute.get(i));
                    }
                }
            }
        } catch (SQLException e) {
            return route;
        }
        return route;
    }

    public static ArrayList<String> getRoute(String src,String dest)
    {
        return getRoute(getStationIndex(src),getStationIndex(dest));
    }

    private static int getRouteID(int src,int dest)
    {
        int ans=-1;
        try {
            DBModel dbModel = DBModel.getDB();
            ResultSet rs = dbModel.selectQuery("select route_id from bus_route where "+src+"=any(bus_stop_list) and "+dest+"=any(bus_stop_list)");
            while (rs.next())
            {
                ans=rs.getInt(1);
                break;
            }
        } catch (SQLException e) {
            return ans;
        }
        return ans;
    }

    private static int getIndexInRoute(int routeID,int curr,int src,int dest)
    {
        int ans=-1;
        try {
            DBModel dbModel = DBModel.getDB();
            String query = "select array_position(bus_stop_list,"+curr+") from bus_route where "
                    +src+"=any(bus_stop_list) and "+dest+"=any(bus_stop_list) and route_id="+routeID;
            ResultSet rs = dbModel.selectQuery(query);
            while (rs.next())
            {
                ans=rs.getInt(1);
                break;
            }
        } catch (SQLException e) {
            return ans;
        }
        return ans;
    }

    public static ArrayList<String> suggestedBuses(String src,String dest)
    {
        ArrayList<String> ans = new ArrayList<String>();
        int src_idx = getStationIndex(src);
        int dest_idx = getStationIndex(dest);
        int routeID = getRouteID(src_idx,dest_idx);
        int start_idx = getIndexInRoute(routeID,src_idx,src_idx,dest_idx);
        int end_idx = getIndexInRoute(routeID,dest_idx,src_idx,dest_idx);
        try {
            DBModel dbModel = DBModel.getDB();
            String query = "select c.company_name,t.bus_no,t.price from ticket t left outer join bus b on (t.bus_no = b.bus_id) left outer join company c on (b.company_id = c.company_id) "+
                    "where t.route_id="+routeID+" and t.start_index="+start_idx+" and t.end_index="+end_idx;
            ResultSet rs = dbModel.selectQuery(query);
            while (rs.next())
            {
                ans.add(rs.getString(1)+"#"+rs.getString(2)+"#"+rs.getString(3));
            }
        } catch (SQLException e) {
            return ans;
        }
        return ans;
    }

    public static ArrayList<String> getABusCompanyRoute(String busNRouteIndex)
    {
        ArrayList<String> ans = new ArrayList<String>();
        String temp = busNRouteIndex;
        String []arr=temp.split("#");
        if(arr.length<2) return ans;
        String routeID = arr[1];
        try {
            DBModel dbModel = DBModel.getDB();
            String query = "select bus_stop_list from bus_route where route_id="+routeID;
            ResultSet rs = dbModel.selectQuery(query);
            temp="";
            while (rs.next())
            {
                temp=temp+rs.getString(1);
                break;
            }
            if(temp.length()<1) return ans;
            arr = convertRouteArray(temp);
            for(int i=0;i<arr.length;i++)
            {
                ans.add(getCoordinate(arr[i]));
            }
        } catch (SQLException e) {
            return ans;
        }
        return ans;
    }

    public static String getMinMaxFare(String busNRouteIndex)
    {
        String ans="";
        String temp = busNRouteIndex;
        String []arr=temp.split("#");
        if(arr.length<2) return ans;
        try {
            DBModel dbModel = DBModel.getDB();
            String query = "select min(price),max(price) from ticket where bus_no="+arr[0]+" and route_id="+arr[1];
            ResultSet rs = dbModel.selectQuery(query);

            while (rs.next())
            {
                ans=ans+rs.getString(1)+"#"+rs.getString(2);
                break;
            }
        } catch (SQLException e) {
            return ans;
        }
        return  ans;
    }
}
