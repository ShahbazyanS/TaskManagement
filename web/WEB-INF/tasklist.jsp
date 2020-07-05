<%@ page import="model.Task" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%List<Task> tasks = (List<Task>) request.getAttribute("tasks");%>
<table border="1">
    <tr>
        <th>name</th>
        <th>description</th>
        <th>deadline</th>
        <th>status</th>
        <th>user</th>
    </tr>
    <%
        for (Task task : tasks) { %>
    <tr>
        <td><a href="/taskById?task_id=<%=task.getId()%>"><%=task.getName()%>
        </a>
        </td>
        <td><%=task.getDescription()%>
        </td>
        <td><%=task.getDeadline()%>
        </td>
        <td><%=task.getStatus().name()%>
        </td>
        <td><%=task.getUser().getName() + " " + task.getUser().getSurname()%>
        </td>
    </tr>
    <%
        }%>
</table>