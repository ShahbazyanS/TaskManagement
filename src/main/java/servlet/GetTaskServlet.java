package servlet;

import manager.TaskManager;
import model.Task;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/tasklist")
public class GetTaskServlet extends HttpServlet {
private TaskManager taskManager = new TaskManager();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Task> allTasks = taskManager.getAllTasks();
        req.setAttribute("tasks", allTasks);
        req.getRequestDispatcher("/WEB-INF/tasklist.jsp").forward(req, resp);
    }
}
