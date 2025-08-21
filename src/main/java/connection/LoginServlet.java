package connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminDAO adminDAO = new AdminDAO();
        boolean isValid = adminDAO.validateAdmin(username, password);

        if (isValid) {
            // Redirect to dashboard if login is successful
            response.sendRedirect("adminDashboard.jsp");
        } else {
            // Show error if login fails
             request.setAttribute("error", "Invalid username or password!");
             request.setAttribute("highlightError", true); 
             request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
    
     public AdminDAO getAdminDAO() {
        return new AdminDAO();
    }
}
