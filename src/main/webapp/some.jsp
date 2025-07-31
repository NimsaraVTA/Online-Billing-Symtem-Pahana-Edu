case "update":
    boolean updated = adminDAO.updateAdmin(adminId, newAdminId, name, email, password, designation);
    request.setAttribute("message", updated ? "Admin updated successfully." : "Failed to update. Admin ID might be in use.");
    break;
