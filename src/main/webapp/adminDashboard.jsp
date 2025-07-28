<%-- 
    Document   : adminDashboard
    Created on : Jul 27, 2025, 2:17:36 PM
    Author     : ThathsaraniBandara
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Pahana Edu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="CSS/adminDashboard.css">
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
                <li class="nav-item"><a class="nav-link active" data-section="dashboardSection">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" data-section="customerForm">Customers</a></li>
                <li class="nav-item"><a class="nav-link" data-section="itemForm">Items</a></li>
                <li class="nav-item"><a class="nav-link" data-section="billingForm">Billing</a></li>
                <li class="nav-item"><a class="nav-link" data-section="helpSection">Help</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="row align-items-center mb-3">
        <div class="col-6">
          <h3 class="mb-0">Admin Dashboard</h3>
        </div>
        <div class="col-6 text-end">
            <a href="adminControl.jsp"><img src="images/setting.png" class="admin-setting" alt="admin setting logo" /></a>
        </div>
    </div>

    <!-- Dashboard Section -->
    <div id="dashboardSection" class="section text-dark">
        <h5 class="mb-3">Customer Overview</h5>

        <div class="dashboard-search">
            <input type="text" class="form-control" id="dashboardSearchInput" placeholder="Search by Account Number or Name...">
        </div>

        <div class="table-wrapper">
            <table class="table table-hover table-bordered" id="customerTable">
                <thead class="table-primary">
                    <tr>
                        <th>Account No</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Phone</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1001</td>
                        <td>Sri Wijeratne</td>
                        <td>Colombo 03</td>
                        <td>0771234567</td>
                    </tr>
                    <tr>
                        <td>1002</td>
                        <td>Chamila Silva</td>
                        <td>Gampaha</td>
                        <td>0719876543</td>
                    </tr>
                    <tr>
                        <td>1003</td>
                        <td>Nimal Perera</td>
                        <td>Kandy</td>
                        <td>0701112233</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Customer Form -->
    <div id="customerForm" class="section" style="display:none;">
        <h5>Customer Management</h5>
        <div class="row">
            <div class="col-md-6 d-flex align-items-center justify-content-center">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/M%C3%BCnster%2C_LVM%2C_B%C3%BCrogeb%C3%A4ude_--_2013_--_5149-51.jpg/1200px-M%C3%BCnster%2C_LVM%2C_B%C3%BCrogeb%C3%A4ude_--_2013_--_5149-51.jpg" class="img-fluid rounded shadow" alt="Customer Management">
            </div>
            <div class="col-md-6">
                <div class="search-bar mb-3">
                    <form method="post" action="CustomerServlet">
                        <div class="input-group">
                            <input type="text" name="searchQuery" class="form-control" placeholder="Search by Account Number or Name">
                            <button type="submit" name="action" value="search" class="btn btn-outline-primary">Search</button>
                        </div>
                    </form>
                </div>
                <form method="post" action="CustomerServlet">
                    <div class="mb-3">
                        <label class="form-label">Account Number</label>
                        <input type="text" name="accountNumber" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" name="name" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Address</label>
                        <input type="text" name="address" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phone</label>
                        <input type="tel" name="phone" class="form-control">
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

    <!-- Item Form -->
    <div id="itemForm" class="section" style="display:none;">
        <h5>Manage Items</h5>
        <form method="post" action="ManageItemsServlet">
            <div class="mb-3">
                <label class="form-label">Item Name</label>
                <input type="text" name="itemName" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Unit Price</label>
                <input type="number" name="unitPrice" step="0.01" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-success">Save Item</button>
        </form>
    </div>

    <!-- Billing Form -->
    <div id="billingForm" class="section" style="display:none;">
        <h5>Generate Bill</h5>
        <form method="post" action="GenerateBillServlet">
            <div class="mb-3">
                <label class="form-label">Customer Account Number</label>
                <input type="text" name="accountNumber" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Units Consumed</label>
                <input type="number" name="units" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-warning">Generate</button>
        </form>
    </div>

    <!-- Help Section -->
    <div id="helpSection" class="section" style="display:none;">
        <h5>Help</h5>
        <p>This dashboard allows administrators to manage customer accounts, item listings, and generate bills. For technical assistance, contact the IT support team.</p>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function showSection(sectionId) {
        document.querySelectorAll('.section').forEach(sec => sec.style.display = 'none');
        document.getElementById(sectionId).style.display = 'block';
    }

    document.querySelectorAll('#navLinks .nav-link').forEach(link => {
        link.addEventListener('click', function () {
            const sectionId = this.getAttribute('data-section');
            showSection(sectionId);
            document.querySelectorAll('#navLinks .nav-link').forEach(l => l.classList.remove('active'));
            this.classList.add('active');
        });
    });

    // Load dashboard by default
    showSection('dashboardSection');

    // Filter customer table
    document.getElementById("dashboardSearchInput").addEventListener("keyup", function () {
        const query = this.value.toLowerCase();
        const rows = document.querySelectorAll("#customerTable tbody tr");
        rows.forEach(row => {
            const cells = row.querySelectorAll("td");
            const match = Array.from(cells).some(cell => cell.textContent.toLowerCase().includes(query));
            row.style.display = match ? "" : "none";
        });
    });
</script>
</body>
</html>