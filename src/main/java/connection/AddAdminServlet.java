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

        String action = request.getParameter("action");

        // Both adminId and newAdminId are retrieved
        String adminId = request.getParameter("adminId");
        String newAdminId = request.getParameter("newAdminId"); // For adding new admins

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String designation = request.getParameter("designation");

        // Determine which ID to use (newAdminId if provided, otherwise adminId)
        String targetAdminId = (newAdminId != null && !newAdminId.trim().isEmpty()) ? newAdminId : adminId;

        AdminDAO adminDAO = new AdminDAO();

        switch (action) {
            case "add":
                boolean added = adminDAO.addAdmin(name, email, password, designation, targetAdminId);
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

            case "update":
                boolean updated = adminDAO.updateAdmin(adminId, name, email, password, designation);
                request.setAttribute("message", updated ? "Admin updated successfully." : "Failed to update admin.");
                break;

            case "delete":
                boolean deleted = adminDAO.deleteAdmin(adminId);
                request.setAttribute("message", deleted ? "Admin deleted successfully." : "Failed to delete admin.");
                break;

            default:
                request.setAttribute("message", "Invalid action.");
                break;
        }
        
        request.getRequestDispatcher("adminControl.jsp").forward(request, response);
    }
    
}