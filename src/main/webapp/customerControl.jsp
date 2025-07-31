<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ page import="org.bson.Document, java.util.List" %>
<%@ page import="connection.CustomerDAO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Control - Pahana Edu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="CSS/adminAndCustomerDashboard.css"/>
</head>
<body>
<%
    String message = (String) request.getAttribute("message");
    Document foundCustomer = (Document) request.getAttribute("foundCustomer");
    boolean isEditing = (foundCustomer != null);
%>

<% if (message != null) { %>
    <div id="notificationBox" class="alert <%= message.contains("successfully") ? "alert-success" : "alert-danger" %> text-center" role="alert">
        <%= message %>
    </div>
<% } %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Pahana Edu</a>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav" id="navLinks">
                <li class="nav-item"><a class="nav-link" href="adminDashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link active" href="customerControl.jsp">Customer Control</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid mt-4">
    <div class="page-header d-flex align-items-center justify-content-between">
        <h3>Customer Control Panel</h3>
        <img class="back-icon" src="images/back-button.png" alt="Back Icon" style="cursor:pointer;" onclick="history.back();">
    </div>

    <div class="row mt-3">
        <!-- Customer Table -->
        <div class="col-md-6 admin-list-section p-4">
            <div class="section">
                <div class="search-bar mb-3">
                    <input type="text" class="form-control" id="customerSearch" placeholder="Search by name or address">
                </div>
                <div class="admin-table">
                    <%
                        CustomerDAO customerDAO = new CustomerDAO();
                        List<Document> customers = customerDAO.getAllCustomers();
                    %>
                    <table class="table table-hover table-bordered table-sm" id="customerTable">
                        <thead>
                            <tr>
                                <th>Account No</th>
                                <th>Name</th>
                                <th>Address</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Document customer : customers) {
                            %>
                            <tr>
                                <td><%= customer.getInteger("CusAccNo") %></td>
                                <td><%= customer.getString("cName") %></td>
                                <td><%= customer.getString("cAddress") %></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Customer Management Form -->
        <div class="col-md-6">
            <div class="section <%= (message != null && !message.contains("successfully")) ? "error-border" : "" %>">
                <h5>Manage Customer</h5>

                <!-- Find Form -->
                <form method="post" action="customerData" class="mb-3">
                    <label class="form-label">Account No</label>
                    <div class="input-group">
                        <input type="number" name="cusAccNo" class="form-control" placeholder="Enter Account Number"
                               value="<%= isEditing ? foundCustomer.getInteger("CusAccNo") : "" %>">
                        <button type="submit" name="action" value="find" class="btn btn-find">Find</button>
                    </div>
                </form>

                <!-- Add/Update/Delete Form -->
                <form method="post" action="customerData">
                    <% if (!isEditing) { %>
                        <div class="mb-3">
                            <label class="form-label">New Account No</label>
                            <input type="number" name="newCusAccNo" class="form-control" placeholder="Enter New Account Number" required>
                        </div>
                    <% } else { %>
                        <div class="mb-3">
                            <label class="form-label">Account No</label>
                            <input type="text" class="form-control" value="<%= foundCustomer.getInteger("CusAccNo") %>" readonly>
                            <input type="hidden" name="cusAccNo" value="<%= foundCustomer.getInteger("CusAccNo") %>">
                        </div>
                    <% } %>

                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" name="cName" class="form-control" required
                               value="<%= isEditing ? foundCustomer.getString("cName") : "" %>">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Address</label>
                        <input type="text" name="cAddress" class="form-control" required
                               value="<%= isEditing ? foundCustomer.getString("cAddress") : "" %>">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Telephone</label>
                        <input type="text" name="cTele" class="form-control" required
                               value="<%= isEditing ? foundCustomer.getString("cTele") : "" %>">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Units</label>
                        <input type="number" name="cUnits" class="form-control" required
                               value="<%= isEditing ? foundCustomer.getInteger("cUnits") : "" %>">
                    </div>

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
    document.getElementById("customerSearch").addEventListener("keyup", function () {
        const query = this.value.toLowerCase();
        document.querySelectorAll("#customerTable tbody tr").forEach(row => {
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

    const deleteBtn = document.getElementById("deleteButton");
    if (deleteBtn) {
        deleteBtn.addEventListener("click", function (event) {
            const confirmed = confirm("Are you sure you want to delete this customer?");
            if (!confirmed) {
                event.preventDefault();
            }
        });
    }
</script>
</body>
</html>
