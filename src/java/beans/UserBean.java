package beans;

// schysst böna
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class UserBean {
    private String email;
    private String password;
    private String firstName;
    private String lastName;
    private float balance;
    private boolean loggedIn;
    
    public UserBean() {
    }

    public void login(String email, String password) {
        if (authenticate(email, password)) {
            // hämta från databasen
            loggedIn = true;
        }
    }

    public void logout() {
        loggedIn = false;
    }

    public boolean db_insert() {
        try {
            PreparedStatement p = getDb().getConnection().prepareStatement(
                    "insert into users set first_name = ?," + //1
                    "                 last_name = ?," + //2
                    "                 password = ?," + //3
                    "                 balance = ?," + //4
                    "                 email = ?"); //5
            p.setString(1, firstName);
            p.setString(2, lastName);
            p.setString(3, password);
            p.setFloat(4, balance);
            p.setString(5, email);
            p.execute();
            return true;
        } catch (Exception ex) {
            System.err.println(ex.getMessage());
            return false;
        }
    }

    void db_update() {
        try {
            PreparedStatement p = getDb().getConnection().prepareStatement(
                    "update users set first_name = ?," +
                    "                 last_name = ?," +
                    "                 password = ?," +
                    "                 balance = ?" +
                    "           where email = ? limit 1");
            p.setString(1, firstName);
            p.setString(2, lastName);
            p.setString(3, password);
            p.setFloat(4, balance);
            p.setString(5, email);
            p.execute();
        } catch (Exception ex) {
            System.err.println(ex.getMessage());
        }
    }

    public boolean authenticate(String email, String password) {
        try {
            PreparedStatement p = getDb().getConnection().prepareStatement("select * from users where email = ? and password = ? limit 1");
            p.setString(1, email);
            p.setString(2, password);
            p.execute();
            ResultSet rs = p.getResultSet();
            rs.next();
            this.email = rs.getString("email");
            firstName = rs.getString("first_name");
            return true;
        } catch (Exception ex) {
            return false;
        }
    }
    
    public float getBalance() {
        return balance;
    }

    public void setBalance(float balance) {
        this.balance = balance;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isLoggedIn() {
        return loggedIn;
    }

    public DataSource getDb() throws NamingException {
        Context c = new InitialContext();
        return (DataSource) c.lookup("java:comp/env/db");
    }
}
