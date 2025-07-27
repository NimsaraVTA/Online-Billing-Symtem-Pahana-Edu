<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Welcome | Pahana Edu Billing System</title>

  <!-- Link your custom CSS -->
  <link rel="stylesheet" href="CSS/index.css">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet"/>
</head>
<body>

<div class="main-container">
  <!-- Left Image Section -->
  <div class="left-section"></div>

  <!-- Right Login Section -->
  <div class="right-section d-flex flex-column">
    <!-- Logo Top Left -->
    <div class="logo-wrapper">
      <img src="images/PahanaEdu.png" alt="My Logo" />
    </div>

    <!-- Centered Login Box -->
    <div class="login-box mx-auto">
      <h2>Welcome to Pahana Edu</h2>
      <p class="form-text mb-4">Please login to access the billing system</p>
      
      <!-- Show server-side error message -->
      <% String errorMsg = (String) request.getAttribute("error"); %>
      <% if (errorMsg != null) { %>
        <p style="color: red; font-weight: bold; text-align: center;"><%= errorMsg %></p>
      <% } %>

      <form action="login" method="post">
        <div class="mb-3">
          <label for="username" class="form-label">Username</label>
          <%
            Boolean highlightError = (Boolean) request.getAttribute("highlightError");
            String borderStyle = (highlightError != null && highlightError) ? "border: 1px solid red;" : "";
          %>

          <input type="text" class="form-control" id="username" name="username" 
           placeholder="Enter your username" required style="<%= borderStyle %>">
        </div>

        <div class="mb-3">
          <label for="password" class="form-label">Password</label>
          <input type="password" class="form-control" id="password" name="password" 
          placeholder="Enter your password" required style="<%= borderStyle %>">
        </div>

        <button type="submit" class="btn btn-primary w-100">Login</button>

        <div class="signup-link">
          Don't have an account? <a href="signup.html">Sign up here</a>
        </div>
      </form>
    </div>

    <!-- Footer -->
    <div class="right-footer text-center mt-auto py-3">
      <small>&copy; 2025 Thathsarani Bandara | University ID: 23567. All rights reserved.</small>
    </div>
  </div>
</div>

<!-- Chatbot UI -->
<div id="chatbot" class="chatbot">
  <div class="chatbot-header" onclick="toggleChat()">💬 Need Help?</div>
  <div class="chatbot-body" id="chatBody">
    <div class="bot-msg">Hi! I'm here to help. Ask me something like:<br>
      - How to sign up?<br>
      - What is this system?<br>
      - Forgot password?</div>
  </div>
  <div class="chatbot-footer">
    <input type="text" id="chatInput" placeholder="Type your question..." onkeypress="handleKey(event)">
    <button onclick="sendMsg()">➤</button>
  </div>
</div>

<!-- JavaScript -->
<script>
  function toggleChat() {
    const body = document.getElementById('chatBody');
    const footer = document.querySelector('.chatbot-footer');
    const isVisible = body.style.display === 'block';
    body.style.display = isVisible ? 'none' : 'block';
    footer.style.display = isVisible ? 'none' : 'flex';
  }

  function sendMsg() {
    const input = document.getElementById('chatInput');
    const msg = input.value.trim();
    if (!msg) return;

    const chatBody = document.getElementById('chatBody');

    const userDiv = document.createElement('div');
    userDiv.className = 'user-msg';
    userDiv.innerText = msg;
    chatBody.appendChild(userDiv);

    const botDiv = document.createElement('div');
    botDiv.className = 'bot-msg';
    botDiv.innerText = getBotResponse(msg);
    chatBody.appendChild(botDiv);

    input.value = '';
    chatBody.scrollTop = chatBody.scrollHeight;
  }

  function handleKey(event) {
    if (event.key === 'Enter') {
      sendMsg();
    }
  }

  function getBotResponse(input) {
    input = input.toLowerCase();
    if (input.includes('hi')) return "Hello! How can I help you?";
    if (input.includes('sign up')) return "To sign up, click on the 'Sign up here' link below the login form.";
    if (input.includes('system')) return "This is an online billing system for Pahana Edu bookshop.";
    if (input.includes('forgot')) return "Please contact admin or click 'Forgot Password' (feature coming soon).";
    return "Sorry, I didn't understand. Try asking about 'sign up' or 'forgot password'.";
  }
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
