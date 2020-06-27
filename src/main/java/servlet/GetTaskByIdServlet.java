package servlet;

import manager.CommentManager;
import manager.TaskManager;
import manager.UserManager;
import model.Comment;
import model.Task;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/taskById")
public class GetTaskByIdServlet extends HttpServlet {

    private CommentManager commentManager = new CommentManager();
    private TaskManager taskManager = new TaskManager();
    private UserManager userManager = new UserManager();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        int taskId = Integer.parseInt(req.getParameter("task_id"));
        List<Comment> comments = commentManager.getCommentsByTaskId(taskId);
        req.setAttribute("comments", comments);
        Task task = taskManager.getTaskById(taskId);
        req.getSession().setAttribute("task", task);

//        User user = (User) req.getSession().getAttribute("user");
        req.setAttribute("taskById", task);


        req.getRequestDispatcher("/WEB-INF/task.jsp").forward(req, resp);
    }
}
