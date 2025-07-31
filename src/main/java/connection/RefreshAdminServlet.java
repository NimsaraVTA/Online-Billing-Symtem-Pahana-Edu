//package connection;
//
//import com.mongodb.client.FindIterable;
//import org.bson.Document;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//import java.io.IOException;
//import java.io.PrintWriter;
//
//@WebServlet("/RefreshAdmin")
//public class RefreshAdminServlet extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
//
//        AdminDAO adminDAO = new AdminDAO();
//        FindIterable<Document> adminList = adminDAO.getAllAdmins();
//
//        for (Document admin : adminList) {
//            out.println("<tr>");
//            out.println("<td>" + admin.getString("name") + "</td>");
//            out.println("<td>" + admin.getString("email") + "</td>");
//            out.println("<td>" + admin.getString("designation") + "</td>");
//            out.println("</tr>");
//        }
//    }
//}