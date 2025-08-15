<%@ page import="connection.MongoDBConnection, com.mongodb.client.MongoCollection, org.bson.Document, java.util.List, java.util.ArrayList" %>
<%@ page import="com.mongodb.client.MongoCursor" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    MongoCollection<Document> itemCollection = MongoDBConnection.getDatabase().getCollection("item");
    MongoCollection<Document> customerCollection = MongoDBConnection.getDatabase().getCollection("customer");

    List<Document> items = new ArrayList<>();
    List<Document> customers = new ArrayList<>();

    try (MongoCursor<Document> cursor = itemCollection.find().iterator()) {
        while (cursor.hasNext()) items.add(cursor.next());
    }
    try (MongoCursor<Document> cursor = customerCollection.find().iterator()) {
        while (cursor.hasNext()) customers.add(cursor.next());
    }

    String success = request.getParameter("success");

    // Read submitted values if available (for printing after reload)
    String billId = request.getParameter("bill_id");
    String itemName = request.getParameter("item_name");
    String itemPrice = request.getParameter("item_price");
    String customerName = request.getParameter("customer_name");
    String customerAccNo = request.getParameter("customer_acc_no");
    String unitCountVal = request.getParameter("unit_count");
    String totalPriceVal = request.getParameter("total_price");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Billing Dashboard - Pahana Edu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root { --light-blue:#f4f8ff; }
        body { background-color: var(--light-blue); }
        .card { border-radius:12px; box-shadow:0 4px 15px rgba(0,0,0,.1); padding:20px; background:#fff; }

        .print-only{ display:none; }
        @media print {
            .no-print{ display:none !important; }
            .print-only{ display:block !important; }
            body { background:#fff !important; }
            .receipt { max-width:720px; margin:0 auto; }
        }
        .receipt h2 { margin-bottom:.25rem; }
        .receipt table{ width:100%; }
        .receipt .lh-condensed { line-height:1.25; }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark no-print">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Pahana Edu</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link active" href="adminDashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="billing.jsp">Billing</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4 no-print">
    <% if ("true".equals(success)) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            Bill submitted successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <div class="card">
        <h3 class="mb-3">Create Bill</h3>

        <form action="BillControl" method="post" id="billForm">
            <div class="mb-3">
                <label class="form-label">Bill ID</label>
                <input type="number" name="bill_id" id="bill_id" class="form-control" required value="<%= billId != null ? billId : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Item Name</label>
                <select name="item_name" id="item_name" class="form-select" required>
                    <option value="">Select Item</option>
                    <% for (Document item : items) {
                           String name = String.valueOf(item.get("item_name"));
                           String priceStr = item.get("price") == null ? "" : String.valueOf(item.get("price"));
                           boolean selected = name.equals(itemName);
                    %>
                        <option value="<%=name%>" data-price="<%=priceStr%>" <%= selected ? "selected" : "" %>><%=name%></option>
                    <% } %>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Item Price</label>
                <input type="text" id="item_price" name="item_price" class="form-control" readonly value="<%= itemPrice != null ? itemPrice : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Customer Name</label>
                <select name="customer_name" id="customer_name" class="form-select" required>
                    <option value="">Select Customer</option>
                    <% for (Document cust : customers) {
                           String cname = String.valueOf(cust.get("cName"));
                           String acc = cust.get("CusAccNo")==null ? "" : String.valueOf(cust.get("CusAccNo"));
                           boolean selected = cname.equals(customerName);
                    %>
                        <option value="<%=cname%>" data-acc="<%=acc%>" <%= selected ? "selected" : "" %>><%=cname%></option>
                    <% } %>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Customer Account No</label>
                <input type="text" id="customer_acc_no" name="customer_acc_no" class="form-control" readonly value="<%= customerAccNo != null ? customerAccNo : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Unit Count</label>
                <input type="number" id="unit_count" name="unit_count" class="form-control" required value="<%= unitCountVal != null ? unitCountVal : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Total Price</label>
                <input type="text" id="total_price" name="total_price" class="form-control" readonly value="<%= totalPriceVal != null ? totalPriceVal : "" %>">
            </div>

            <div class="d-flex gap-2">
                <button type="button" id="previewBtn" class="btn btn-outline-secondary">Preview/Print</button>
                <button type="submit" class="btn btn-primary flex-grow-1">Submit Bill</button>
            </div>
        </form>
    </div>
</div>

<!-- PRINT RECEIPT -->
<div class="print-only">
    <div class="receipt p-4">
        <h2 class="text-center">Pahana Edu</h2>
        <p class="text-center mb-2">Billing Receipt</p>
        <hr/>
        <table class="table table-borderless lh-condensed">
            <tbody>
                <tr><th style="width:220px">Bill ID</th><td id="print_bill_id"></td></tr>
                <tr><th>Item</th><td id="print_item_name"></td></tr>
                <tr><th>Item Price</th><td>Rs. <span id="print_item_price"></span></td></tr>
                <tr><th>Customer</th><td id="print_customer_name"></td></tr>
                <tr><th>Account No</th><td id="print_customer_acc_no"></td></tr>
                <tr><th>Quantity</th><td id="print_unit_count"></td></tr>
                <tr class="table-light"><th>Total</th><td><strong>Rs. <span id="print_total_price"></span></strong></td></tr>
            </tbody>
        </table>
        <hr/>
        <p class="text-center">Thank you for your purchase!</p>
    </div>
</div>

<script>
document.getElementById('previewBtn').addEventListener('click', () => {
    // Copy form values into print section
    document.getElementById('print_bill_id').textContent = document.getElementById('bill_id').value;
    document.getElementById('print_item_name').textContent = document.getElementById('item_name').value;
    document.getElementById('print_item_price').textContent = document.getElementById('item_price').value;
    document.getElementById('print_customer_name').textContent = document.getElementById('customer_name').value;
    document.getElementById('print_customer_acc_no').textContent = document.getElementById('customer_acc_no').value;
    document.getElementById('print_unit_count').textContent = document.getElementById('unit_count').value;
    document.getElementById('print_total_price').textContent = document.getElementById('total_price').value;

    window.print();
});
</script>


<script>
document.addEventListener('DOMContentLoaded', () => {
    const itemSel = document.getElementById('item_name');
    const custSel = document.getElementById('customer_name');
    const itemPrice = document.getElementById('item_price');
    const custAcc = document.getElementById('customer_acc_no');
    const unitCount = document.getElementById('unit_count');
    const totalPrice = document.getElementById('total_price');
    const form = document.getElementById('billForm');

    function updatePrice() {
        const opt = itemSel.options[itemSel.selectedIndex];
        const p = parseFloat(opt?.dataset.price || '0');
        itemPrice.value = isNaN(p) ? '' : p;
        calcTotal();
    }
    function updateCustomerAcc() {
        const opt = custSel.options[custSel.selectedIndex];
        custAcc.value = opt?.dataset.acc || '';
    }
    function calcTotal() {
        const p = parseFloat(itemPrice.value || '0');
        const q = parseInt(unitCount.value || '0', 10);
        if (!isNaN(p) && !isNaN(q)) totalPrice.value = (p * q).toFixed(2);
    }

    itemSel.addEventListener('change', updatePrice);
    custSel.addEventListener('change', updateCustomerAcc);
    unitCount.addEventListener('input', calcTotal);
});
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
