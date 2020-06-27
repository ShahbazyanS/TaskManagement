<%@ page import="java.util.List" %>
<%@ page import="model.Task" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%
    List<Task> tasks = (List<Task>) request.getAttribute("searchList");
    request.getAttribute("search");
%>

<div class="search">
   <h2> All Tasks:</h2><br>
    <table border="1">
        <tr>
            <th><h2>name</h2></th>
            <th><h2>description</h2></th>
            <th><h2>deadline</h2></th>
            <th><h2>status</h2></th>
            <th><h2>user</h2></th>
            <th><h2>update status</h2></th>
        </tr>
        <%
            for (Task task : tasks) { %>
        <tr>
            <td><%=task.getName()%>
            </td>
            <td><%=task.getDescription()%>
            </td>
            <td><%=task.getDeadline()%>
            </td>
            <td><%=task.getStatus().name()%>
            </td>
            <td><%=task.getUser().getName() + " " + task.getUser().getSurname()%>
            </td>
            <td>
                <form action="/changeTaskStatus" method="post">
                    <input type="hidden" name="taskId" value="<%=task.getId()%>">
                    <select name="status">
                        <option value="NEW">NEW</option>
                        <option value="IN_PROGRESS">IN_PROGRESS</option>
                        <option value="FINISHED">FINISHED</option>
                    </select><input type="submit" value="ok">
                </form>
            </td>
        </tr>
        <%
            }%>
    </table>
</div>

</body>
</html>
