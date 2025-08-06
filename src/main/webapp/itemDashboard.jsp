<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.bson.Document, java.util.List" %>
<%@ page import="connection.ItemDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="CSS/itemDashboard.css">
</head>
<body>

<%
    String message = (String) request.getAttribute("message");
    Document foundItem = (Document) request.getAttribute("foundItem");
    boolean isEditing = (foundItem != null);
%>

<% if (message != null) { %>
    <div class="alert <%= message.contains("successfully") ? "alert-success" : "alert-danger" %> text-center">
        <%= message %>
    </div>
<% } %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Pahana Edu</a>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="adminDashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link active" href="customerControl.jsp">Customer Control</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid py-5 item-dashboard-bg">
    <div class="page-header">
        <h3 class="mb-4 text-primary fw-bold text-center">Item Dashboard</h3>
    </div>
        <div class="row g-4">
            <!-- Item Table Section -->
            <div class="col-md-6 item-list-section ">
                <div class="section p-4 shadow">
                    <input type="text" id="searchInput" class="form-control mb-3" placeholder="Search items by ID or name">
                    <table id="itemTable" class="table table-bordered table-hover text-center">
                        <thead class="table-primary">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Stock</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            ItemDAO dao = new ItemDAO();
                            List<Document> items = dao.getAllItems();
                            for (Document item : items) {
                        %>
                            <tr>
                                <td><%= item.getInteger("item_id") %></td>
                                <td><%= item.getString("item_name") %></td>
                                <td><%= item.getInteger("stock") %></td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Item Form Section -->
            <div class="col-md-6">
                <div class="section p-4 shadow">
                    <!-- Find Item -->
                    <form method="post" action="itemData" id="findForm" class="mb-3">
                        <label for="itemId" class="form-label">Item ID</label>
                        <div class="input-group">
                            <input type="number" id="itemId" name="itemId" class="form-control" value="<%= isEditing ? foundItem.getInteger("item_id") : "" %>">
                            <button type="submit" class="btn btn-info" name="action" value="find">Find</button>
                        </div>
                    </form>

                    <!-- Add/Update/Delete -->
                    <form method="post" action="itemData" id="itemForm">
                        <div class="mb-3">
                            <label for="newItemId" class="form-label">New Item ID</label>
                            <input type="number" id="newItemId" name="newItemId" class="form-control"
                                   value="<%= request.getParameter("newItemId") != null ? request.getParameter("newItemId") : "" %>">
                        </div>

                        <div class="mb-3">
                            <label for="itemName" class="form-label">Item Name</label>
                            <input type="text" id="itemName" name="itemName" class="form-control" required
                                   value="<%= isEditing ? foundItem.getString("item_name") : "" %>">
                        </div>

                        <div class="mb-3">
                            <label for="price" class="form-label">Price</label>
                            <input type="number" id="price" name="price" class="form-control" required
                                   value="<%= isEditing ? foundItem.getInteger("price") : "" %>">
                        </div>

                        <div class="mb-3">
                            <label for="stock" class="form-label">Stock</label>
                            <input type="number" id="stock" name="stock" class="form-control" required
                                   value="<%= isEditing ? foundItem.getInteger("stock") : "" %>">
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea id="description" name="description" class="form-control" required><%= isEditing ? foundItem.getString("description") : "" %></textarea>
                        </div>

                        <div class="btn-group w-100" role="group">
                            <button type="submit" name="action" value="add" class="btn btn-primary">Add</button>
                            <button type="submit" name="action" value="update" class="btn btn-warning">Update</button>
                            <button type="submit" name="action" value="delete" class="btn btn-danger" onclick="return confirm('Are you sure?');">Delete</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById("searchInput").addEventListener("keyup", function () {
        const query = this.value.toLowerCase();
        document.querySelectorAll("#itemTable tbody tr").forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(query) ? "" : "none";
        });
    });
</script>
</body>
</html>
