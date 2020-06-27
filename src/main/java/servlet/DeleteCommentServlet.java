package servlet;

import manager.CommentManager;
import model.Task;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/deleteComment")
public class DeleteCommentServlet extends HttpServlet {

    private CommentManager commentManager = new CommentManager();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        commentManager.deleteCommentById(id);
        Task task = (Task) req.getSession().getAttribute("task");

        resp.sendRedirect("/taskById?task_id=" + task.getId());

    }
}
