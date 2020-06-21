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

@WebServlet(urlPatterns = "/searchTask")
public class SearchTaskServlet extends HttpServlet {

    private TaskManager taskManager = new TaskManager();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String search = req.getParameter("search");

        List<Task> tasks = taskManager.searchTask(search);
        req.setAttribute("searchList", tasks);
        req.setAttribute("search", search);
        resp.sendRedirect("/WEB-INF/search.jsp");

    }
}
