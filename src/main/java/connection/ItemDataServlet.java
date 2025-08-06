package connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import org.bson.Document;

@WebServlet("/itemData")
public class ItemDataServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");
        String itemIdStr = request.getParameter("itemId");
        String newItemIdStr = request.getParameter("newItemId");

        int itemId = (itemIdStr != null && !itemIdStr.isEmpty()) ? Integer.parseInt(itemIdStr) : -1;
        int newItemId = (newItemIdStr != null && !newItemIdStr.isEmpty()) ? Integer.parseInt(newItemIdStr) : -1;
        int targetId = (newItemId != -1) ? newItemId : itemId;

        String itemName = request.getParameter("itemName");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String description = request.getParameter("description");

        int price = (priceStr != null && !priceStr.isEmpty()) ? Integer.parseInt(priceStr) : 0;
        int stock = (stockStr != null && !stockStr.isEmpty()) ? Integer.parseInt(stockStr) : 0;

        ItemDAO itemDAO = new ItemDAO();

        switch (action) {
            case "add":
                boolean added = itemDAO.addItem(targetId, itemName, price, stock, description);
                request.setAttribute("message", added ? "Item added successfully." : "Item already exists.");
                break;
            case "find":
                Document found = itemDAO.getItemById(itemId);
                if (found != null) {
                    request.setAttribute("foundItem", found);
                } else {
                    request.setAttribute("message", "Item not found.");
                }
                break;
            case "update":
                boolean updated = itemDAO.updateItem(itemId, itemName, price, stock, description);
                request.setAttribute("message", updated ? "Item updated successfully." : "Update failed.");
                break;
            case "delete":
                boolean deleted = itemDAO.deleteItem(itemId);
                request.setAttribute("message", deleted ? "Item deleted successfully." : "Delete failed.");
                break;
            default:
                request.setAttribute("message", "Invalid action.");
        }

        request.getRequestDispatcher("itemDashboard.jsp").forward(request, response);
    }
}
