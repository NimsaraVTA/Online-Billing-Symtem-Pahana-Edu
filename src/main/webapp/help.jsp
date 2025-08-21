<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Help - Pahana Edu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="CSS/help.css">
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
                <li class="nav-item"><a class="nav-link" href="customerControl.jsp">Customers</a></li>
                <li class="nav-item"><a class="nav-link" href="itemDashboard.jsp">Items</a></li>
                <li class="nav-item"><a class="nav-link" href="billing.jsp">Billing</a></li>
                <li class="nav-item"><a class="nav-link active" href="help.jsp">Help</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Help Content -->
<div class="container my-5">
    <h2 class="mb-4">Help Section - How to Use the Online Billing System</h2>
    
    <div class="card mb-3">
        <div class="card-header bg-primary text-white">1. User Authentication</div>
        <div class="card-body">
            <p>Login to the system using your username and password to access the dashboard securely.</p>
        </div>
    </div>

    <div class="card mb-3">
        <div class="card-header bg-primary text-white">2. Add New Customer Accounts</div>
        <div class="card-body">
            <p>Navigate to <strong>Customers</strong> → <strong>Add Customer</strong> to register a new customer. Enter account number, name, address, phone number, and units consumed.</p>
        </div>
    </div>

    <div class="card mb-3">
        <div class="card-header bg-primary text-white">3. Edit Customer Information</div>
        <div class="card-body">
            <p>Update customer details by selecting a customer from the list and clicking <strong>Edit</strong>.</p>
        </div>
    </div>

    <div class="card mb-3">
        <div class="card-header bg-primary text-white">4. Manage Item Information</div>
        <div class="card-body">
            <p>Add, update, or delete items using the <strong>Items</strong> menu. Ensure item details are accurate for billing.</p>
        </div>
    </div>

    <div class="card mb-3">
        <div class="card-header bg-primary text-white">5. Display Account Details</div>
        <div class="card-body">
            <p>View detailed customer account information in the <strong>Customers</strong> section. Search by account number or name.</p>
        </div>
    </div>

    <div class="card mb-3">
        <div class="card-header bg-primary text-white">6. Calculate and Print Bill</div>
        <div class="card-body">
            <p>Go to <strong>Billing</strong> → Select Customer → Click <strong>Generate Bill</strong> to compute and print the bill based on units consumed.</p>
        </div>
    </div>

    <div class="card mb-3">
        <div class="card-header bg-primary text-white">7. Help Section</div>
        <div class="card-body">
            <p>You are currently viewing the help section. Use this page to understand system functionalities and workflows.</p>
        </div>
    </div>

    <div class="card mb-3">
        <div class="card-header bg-primary text-white">8. Exit System</div>
        <div class="card-body">
            <p>Click <strong>Logout</strong> in the navigation bar to safely exit the system.</p>
        </div>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
