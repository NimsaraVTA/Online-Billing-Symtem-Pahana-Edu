package connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import org.bson.Document;

@WebServlet("/BillControl")
public class BillControl extends HttpServlet {
    private BillDAO billDAO;

    @Override
    public void init() throws ServletException {
        billDAO = new BillDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int billId = Integer.parseInt(request.getParameter("bill_id"));
        String itemName = request.getParameter("item_name");
        String customerName = request.getParameter("customer_name");
        double itemPrice = Double.parseDouble(request.getParameter("item_price"));
        int unitCount = Integer.parseInt(request.getParameter("unit_count"));
        double totalPrice = Double.parseDouble(request.getParameter("total_price"));
        String customerAccNo = request.getParameter("customer_acc_no");

        Document billDoc = new Document("bill_id", billId)
                .append("item_name", itemName)
                .append("customer_name", customerName)
                .append("item_price", itemPrice)
                .append("unit_count", unitCount)
                .append("total_price", totalPrice)
                .append("customer_acc_no", customerAccNo);

        billDAO.insertBill(billDoc);

        response.sendRedirect("billing.jsp?success=true");
    }
}
