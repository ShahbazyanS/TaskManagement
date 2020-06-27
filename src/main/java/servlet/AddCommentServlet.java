package servlet;

import manager.CommentManager;
import manager.TaskManager;
import model.Comment;
import model.Task;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@WebServlet(urlPatterns = "/addComment")
public class AddCommentServlet extends HttpServlet {
    private CommentManager commentManager = new CommentManager();
    private TaskManager taskManager = new TaskManager();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int taskId = Integer.parseInt(req.getParameter("task_id"));
        String comment = req.getParameter("comment");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Task task = taskManager.getTaskById(taskId);

            Comment comment1 = Comment.builder()
                    .task_id(taskId)
                    .user_id(user.getId())
                    .comment(comment)
                    .date(new Date())
                    .build();
            commentManager.addComment(comment1);
            resp.sendRedirect("/taskById?task_id="+ taskId);

    }
}
