<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="org.bson.Document, java.util.List" %>
<%@ page import="connection.AdminDAO" %>
<%@ page import="org.bson.Document" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Control - Pahana Edu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="CSS/adminAndCustomerDashboard.css"/>
</head>
<body>
<%
    String message = (String) request.getAttribute("message");
    Document foundAdmin = (Document) request.getAttribute("foundAdmin");
    boolean isEditing = (foundAdmin != null);
%>

<% if (message != null) { %>
    <div id="notificationBox" class="alert <%= message.contains("successfully") ? "alert-success" : "alert-danger" %> text-center" role="alert">
        <%= message %>
    </div>
<% } %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Pahana Edu</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav" id="navLinks">
                <li class="nav-item"><a class="nav-link" href="adminDashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link active" href="adminControl.jsp">Admin Control</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid mt-4">
    <div class="page-header d-flex align-items-center justify-content-between">
        <h3>Admin Control Panel</h3>
        <img class="back-icon" src="images/back-button.png" alt="Back Icon" style="cursor:pointer;" onclick="history.back();">
    </div>

    <div class="row mt-3">
        <!-- Admin Table -->
        <div class="col-md-6 admin-list-section p-4">
            <div class="section">
                <div class="search-bar mb-3">
                    <input type="text" class="form-control" id="adminSearch" placeholder="Search admin by name or email">
                </div>
                <div class="admin-table">
                    <%
                    AdminDAO adminDAO = new AdminDAO();
                    List<Document> admins = adminDAO.getAllAdmins();
                %>
                <table class="table table-hover table-bordered table-sm" id="adminTable">
                   <thead>
                           <tr>
                               <th>Admin Name</th>
                               <th>Email</th>
                               <th>Designation</th>
                           </tr>
                   </thead>
                   <tbody>
                           <%
                               for (Document admin : admins) {
                           %>
                           <tr>
                               <td><%= admin.getString("name") %></td>
                               <td><%= admin.getString("email") %></td>
                               <td><%= admin.getString("designation") %></td>
                           </tr>
                           <%
                               }
                           %>
                   </tbody>
                </table>
                </div>
            </div>
        </div>

        <!-- Admin Management Form -->
        <div class="col-md-6">
            <div class="section <%= (message != null && !message.contains("successfully")) ? "error-border" : "" %>">
                <h5>Manage Admin</h5>

                <!-- Find Form -->
                <form method="post" action="addAdmin" class="mb-3">
                    <label class="form-label">Admin ID</label>
                    <div class="input-group">
                        <input type="text" name="adminId" class="form-control" placeholder="Enter Admin ID"
                               value="<%= foundAdmin != null ? foundAdmin.getString("adminID") : "" %>">
                        <button type="submit" name="action" value="find" class="btn btn-find">Find</button>
                    </div>
                </form>

                <!-- Add/Update/Delete Form -->
                <form method="post" action="addAdmin">
                    <% if (!isEditing) { %>
                        <!-- Show New Admin ID field only for Add -->
                        <div class="mb-3">
                            <label class="form-label">New Admin ID</label>
                            <input type="text" name="newAdminId" class="form-control" placeholder="Enter New Admin ID" required>
                        </div>
                    <% } else { %>
                        <!-- For Update/Delete: Read-only display and hidden adminId -->
                        <div class="mb-3">
                            <label class="form-label">Admin ID</label>
                            <input type="text" class="form-control" value="<%= foundAdmin.getString("adminID") %>" readonly>
                            <input type="hidden" name="adminId" value="<%= foundAdmin.getString("adminID") %>">
                        </div>
                    <% } %>

                    <!-- Name -->
                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" name="name" class="form-control" required
                               value="<%= foundAdmin != null ? foundAdmin.getString("name") : "" %>">
                    </div>

                    <!-- Email -->
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" required
                               value="<%= foundAdmin != null ? foundAdmin.getString("email") : "" %>">
                    </div>

                    <!-- Password -->
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" required
                               value="<%= foundAdmin != null ? foundAdmin.getString("password") : "" %>">
                    </div>

                    <!-- Designation -->
                    <div class="mb-3">
                        <label class="form-label">Designation</label>
                        <select name="designation" class="form-select" required>
                            <option value="Owner" <%= (foundAdmin != null && "Owner".equals(foundAdmin.getString("designation"))) ? "selected" : "" %>>Owner</option>
                            <option value="Manager" <%= (foundAdmin != null && "Manager".equals(foundAdmin.getString("designation"))) ? "selected" : "" %>>Manager</option>
                            <option value="Staff" <%= (foundAdmin != null && "Staff".equals(foundAdmin.getString("designation"))) ? "selected" : "" %>>Staff</option>
                        </select>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <button type="submit" name="action" value="add" class="btn btn-primary">Add</button>
                        <button type="submit" name="action" value="update" class="btn btn-warning">Update</button>
                        <button id="deleteButton" type="submit" name="action" value="delete" class="btn btn-danger">Delete</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById("adminSearch").addEventListener("keyup", function () {
        const query = this.value.toLowerCase();
        document.querySelectorAll("#adminTable tbody tr").forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(query) ? "" : "none";
        });
    });

    window.addEventListener('DOMContentLoaded', () => {
        const notification = document.getElementById('notificationBox');
        if (notification) {
            setTimeout(() => {
                notification.style.display = 'none';
            }, 2000);
        }
    });

    // Confirm before delete
    const deleteBtn = document.getElementById("deleteButton");
    if (deleteBtn) {
        deleteBtn.addEventListener("click", function (event) {
            const confirmed = confirm("Are you sure you want to delete this admin?");
            if (!confirmed) {
                event.preventDefault(); // cancel form submission
            }
        });
    }
</script>
</body>
</html>
