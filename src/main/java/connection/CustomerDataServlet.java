package connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

import org.bson.Document;

@WebServlet("/customerData")
public class CustomerDataServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");

        // Both cusAccNo and newCusAccNo are retrieved
        String accNoStr = request.getParameter("cusAccNo");
        String newAccNoStr = request.getParameter("newCusAccNo");

        int cusAccNo = (accNoStr != null && !accNoStr.trim().isEmpty()) ? Integer.parseInt(accNoStr) : -1;
        int newCusAccNo = (newAccNoStr != null && !newAccNoStr.trim().isEmpty()) ? Integer.parseInt(newAccNoStr) : -1;

        String cName = request.getParameter("cName");
        String cAddress = request.getParameter("cAddress");
        String cTele = request.getParameter("cTele");
        String cUnitsStr = request.getParameter("cUnits");

        int cUnits = (cUnitsStr != null && !cUnitsStr.trim().isEmpty()) ? Integer.parseInt(cUnitsStr) : 0;

        int targetAccNo = (newCusAccNo != -1) ? newCusAccNo : cusAccNo;

        CustomerDAO customerDAO = new CustomerDAO();

        switch (action) {
            case "add":
                boolean added = customerDAO.addCustomer(targetAccNo, cName, cAddress, cTele, cUnits);
                request.setAttribute("message", added ? "Customer added successfully." : "Customer already exists with this account number.");
                break;

            case "find":
                Document customer = customerDAO.getCustomerByAccNo(cusAccNo);
                if (customer != null) {
                    request.setAttribute("foundCustomer", customer);
                } else {
                    request.setAttribute("message", "Customer not found with the given account number.");
                }
                break;

            case "update":
                boolean updated = customerDAO.updateCustomer(cusAccNo, cName, cAddress, cTele, cUnits);
                request.setAttribute("message", updated ? "Customer updated successfully." : "Failed to update customer.");
                break;

            case "delete":
                boolean deleted = customerDAO.deleteCustomer(cusAccNo);
                request.setAttribute("message", deleted ? "Customer deleted successfully." : "Failed to delete customer.");
                break;

            default:
                request.setAttribute("message", "Invalid action.");
                break;
        }

        request.getRequestDispatcher("customerControl.jsp").forward(request, response);
    }
}
