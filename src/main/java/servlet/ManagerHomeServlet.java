package servlet;


import manager.TaskManager;
import manager.UserManager;
import model.Task;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/managerHome")
public class ManagerHomeServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        TaskManager taskManager = new TaskManager();
        UserManager userManager = new UserManager();
        List<User> allUser = userManager.getAllUser();
        List<Task> allTasks = taskManager.getAllTasks();
        req.setAttribute("tasks", allTasks);
        req.setAttribute("users", allUser);
        req.getRequestDispatcher("/WEB-INF/manager.jsp").forward(req, resp);
    }
}

