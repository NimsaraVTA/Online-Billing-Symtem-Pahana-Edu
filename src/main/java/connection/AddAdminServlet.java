package connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import org.bson.Document;

@WebServlet("/addAdmin")
public class AddAdminServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from form
        String action = request.getParameter("action");
        String adminId = request.getParameter("adminId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String designation = request.getParameter("designation");

        AdminDAO adminDAO = new AdminDAO();

        switch (action) {
        case "add":
            boolean added = adminDAO.addAdmin(name, email, password, designation, adminId);
            request.setAttribute("message", added ? "Admin added successfully." : "Admin already exists with the same ID or email.");
            break;

        case "find":
            Document admin = adminDAO.getAdminById(adminId);
            if (admin != null) {
                request.setAttribute("foundAdmin", admin);
            } else {
                request.setAttribute("message", "Admin not found with the given ID.");
            }
            break;

        default:
            request.setAttribute("message", "Invalid action.");
            break;
            }

        // Forward back to adminControl.jsp with feedback
        request.getRequestDispatcher("adminControl.jsp").forward(request, response);
    }
}