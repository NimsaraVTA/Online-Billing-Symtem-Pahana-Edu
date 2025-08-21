package connection;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

import static org.mockito.Mockito.*;

class LoginServletTest {

    private LoginServlet loginServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private AdminDAO adminDAO;
    private RequestDispatcher dispatcher;

    @BeforeEach
    void setUp() {
        loginServlet = spy(new LoginServlet());
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        adminDAO = mock(AdminDAO.class);
        dispatcher = mock(RequestDispatcher.class);

        // Override getAdminDAO() to return our mock
        doReturn(adminDAO).when(loginServlet).getAdminDAO();
    }

    @Test
    void testSuccessfulLoginRedirectsToDashboard() throws ServletException, IOException {
        when(request.getParameter("username")).thenReturn("admin");
        when(request.getParameter("password")).thenReturn("password123");
        when(adminDAO.validateAdmin("admin", "password123")).thenReturn(true);

        loginServlet.doPost(request, response);

        // Verify redirect
        verify(response).sendRedirect("adminDashboard.jsp");
    }

    @Test
    void testFailedLoginForwardsToIndex() throws ServletException, IOException {
        when(request.getParameter("username")).thenReturn("admin");
        when(request.getParameter("password")).thenReturn("wrongpass");
        when(adminDAO.validateAdmin("admin", "wrongpass")).thenReturn(false);
        when(request.getRequestDispatcher("index.jsp")).thenReturn(dispatcher);

        loginServlet.doPost(request, response);

        // Verify attributes set
        verify(request).setAttribute("error", "Invalid username or password!");
        verify(request).setAttribute("highlightError", true);

        // Verify forward
        verify(dispatcher).forward(request, response);
    }
}
