package connection;

import com.mongodb.client.MongoDatabase;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/testMongo")
public class TestMongoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MongoDatabase db = MongoDBConnection.getDatabase();
        response.getWriter().println("Connected to database: " + db.getName());
    }
}
