<%@ page import="connection.AdminDAO" %>
<%@ page import="org.bson.Document" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Table Data</title>
    <style>
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            padding: 12px;
            border: 1px solid #888;
            text-align: left;
        }
        th {
            background-color: #f0f0f0;
        }
        h1 {
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>Admin Table</h1>

    <%
        AdminDAO adminDAO = new AdminDAO();
        List<Document> admins = adminDAO.getAllAdmins();
    %>

    <table>
        <thead>
            <tr>
                <th>Admin ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Password</th>
                <th>Designation</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (Document admin : admins) {
            %>
            <tr>
                <td><%= admin.getString("adminID") %></td>
                <td><%= admin.getString("name") %></td>
                <td><%= admin.getString("email") %></td>
                <td><%= admin.getString("password") %></td>
                <td><%= admin.getString("designation") %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
