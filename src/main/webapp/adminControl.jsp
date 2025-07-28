<%-- 
    Document   : adminControl
    Created on : Jul 28, 2025, 6:50:16 AM
    Author     : ThathsaraniBandara
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Control - Pahana Edu</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="CSS/adminControl.css"/>
</head>
<body>
<!-- Navigation Bar -->
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

<!-- Content -->
<div class="container-fluid mt-4">
    <!-- Page Header Row -->
    <div class="page-header">
        <h3>Admin Control Panel</h3>
        <img class="back-icon" src="images/back-button.png" alt="Back Icon"> 
    </div>

    <div class="row">
        <!-- Left Column: Admin Table -->
        <div class="col-md-6 admin-list-section">
            <div class="section">
                <div class="search-bar">
                    <input type="text" class="form-control" id="adminSearch" placeholder="Search admin by name or email">
                </div>
                <div class="admin-table">
                    <table class="table table-hover table-bordered table-sm" id="adminTable">
                        <thead class="table-primary">
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Designation</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>ThathsaraniB</td>
                                <td>k9003.thathsarani@gmail.com</td>
                                <td>Owner</td>
                            </tr>
                            <tr>
                                <td>John Doe</td>
                                <td>john@example.com</td>
                                <td>Manager</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Right Column: Add/Update/Delete Form -->
        <div class="col-md-6">
            <div class="section">
                <h5>Manage Admin</h5>
                <form method="post" action="AdminServlet">
                    <!-- Admin ID Row with Find Button -->
                    <div class="mb-3">
                        <label class="form-label">Admin ID</label>
                        <div class="input-group">
                            <input type="text" name="adminId" class="form-control" placeholder="Enter Admin ID">
                            <button type="button" class="btn btn-find">Find</button>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Designation</label>
                        <select name="designation" class="form-select" required>
                            <option value="Owner">Owner</option>
                            <option value="Manager">Manager</option>
                            <option value="Staff">Staff</option>
                        </select>
                    </div>
                    <div class="action-buttons">
                        <button type="submit" name="action" value="add" class="btn btn-primary">Add</button>
                        <button type="submit" name="action" value="update" class="btn btn-warning">Update</button>
                        <button type="submit" name="action" value="delete" class="btn btn-danger">Delete</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Search Filter for Admin Table
    document.getElementById("adminSearch").addEventListener("keyup", function () {
        const query = this.value.toLowerCase();
        document.querySelectorAll("#adminTable tbody tr").forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(query) ? "" : "none";
        });
    });
</script>
</body>
</html>
