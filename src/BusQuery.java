import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;

public class BusQuery {
    private BusQuery()
    {

    }
    public static ArrayList<String> getTrendingList() {
        ArrayList<String> busNames = new ArrayList<>();
        try {
            String query = "select company_name from company";
            DBModel dbModel = DBModel.getDB();
            ResultSet rs = dbModel.selectQuery(query);
            while (rs.next())
            {
                busNames.add(rs.getString(1));
            }
        }
        catch(Exception e) {
            e.printStackTrace();
        }
        return busNames;
    }
    public static ArrayList<String> getBusList(String name)
    {
        name = "'%"+name.toLowerCase()+"%'";
        ArrayList<String> busNames = new ArrayList<String>();


        try {
            String query = "select company_name from company where lower(company_name) like "+name;
            DBModel dbModel = DBModel.getDB();
            ResultSet rs = dbModel.selectQuery(query);
            while (rs.next())
            {
                busNames.add(rs.getString(1));
            }
        } catch (SQLException e) {
            return busNames;
        }

        return busNames;
    }
    private static int getCompanyID(String name)
    {
        name = "'"+name.trim()+"'";
        int ans=-1;
        try {
            String query = "select company_id from company where company_name="+name;
            DBModel dbModel = DBModel.getDB();
            ResultSet rs = dbModel.selectQuery(query);
            int id=-1;
            while (rs.next())
            {
                id = rs.getInt(1);
                break;
            }
            ans=id;
        } catch (SQLException e) {
            return ans;
        }
        return ans;
    }
    public static double getBusRating(String name)
    {
        double ans=0;
        try {
            DBModel dbModel = DBModel.getDB();
            int id=getCompanyID(name);
            String query="select avg(rating) from reviews r left outer join bus b on (r.bus_no=b.bus_id) where b.company_id="
                    +id;
            ResultSet rs = dbModel.selectQuery(query);
            while (rs.next())
            {
                ans = rs.getDouble(1);
                break;
            }
        } catch (SQLException e) {
            return ans;
        }
        return ans;
    }

    public static ArrayList<String> getComments(String name)
    {
        ArrayList<String> comments = new ArrayList<String>();
        try {
            DBModel dbModel = DBModel.getDB();
            int id=getCompanyID(name);
            String query="select c.customer_name,r.comment from reviews r left outer join bus b on (r.bus_no=b.bus_id) left outer join customer c on (r.customer_id=c.customer_id) " +
                    "where r.comment is not null and b.company_id="
                    +id;
            ResultSet rs = dbModel.selectQuery(query);
            while (rs.next())
            {
                comments.add(rs.getString(1)+"#"+rs.getString(2));
            }
            Collections.shuffle(comments);
        } catch (SQLException e) {
            return comments;
        }
        return comments;
    }

    public static String getABusWithRoute(String name)
    {
        String ans="";
        try {
            DBModel dbModel = DBModel.getDB();
            int id=getCompanyID(name);
            String query="select bus_id, route_id from bus where company_id="
                    +id;
            ResultSet rs = dbModel.selectQuery(query);
            while (rs.next())
            {
                ans=ans+(rs.getString(1)+"#"+rs.getString(2));
                break;
            }
        } catch (SQLException e) {
            return ans;
        }
        return ans;
    }
}

