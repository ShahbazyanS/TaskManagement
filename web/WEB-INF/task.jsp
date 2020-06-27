<%@ page import="model.Comment" %>
<%@ page import="model.Task" %>
<%@ page import="model.User" %>
<%@ page import="model.UserType" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    Task task = (Task) request.getAttribute("taskById");
//    User user = (User) request.getAttribute("user");
    List<Comment> comments = (List<Comment>) request.getAttribute("comments");
    User user = (User) session.getAttribute("user");
%>

<div>
    All Tasks:<br>
    <table border="1">
        <tr>
            <th>name</th>
            <th>description</th>
            <th>deadline</th>
            <th>status</th>
            <th>user</th>
            <th>update status</th>
        </tr>
        <tr>
            <td><%=task.getName()%>
            </td>
            <td><%=task.getDescription()%>
            </td>
            <td><%=task.getDeadline()%>
            </td>
            <td><%=task.getStatus().name()%>
            </td>
            <td><%=user.getName() + " " + user.getSurname()%>
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
    </table>
</div>
<form action="/addComment" method="post">
    <input type="hidden" name="task_id" value="<%=task.getId()%>">
    <input type="text" name="comment"><br>
    <input type="submit" name="comment">
</form>
<br>
<ul>
    <%
        for (Comment comment : comments) {%>

    <li><%=comment.getUser().getName()%> <%=comment.getUser().getSurname()%><br><%=comment.getComment()%>
        - <%=comment.getDate()%>
        <%if (comment.getUser().getEmail().equals(user.getEmail()) | user.getUserType() == UserType.MANAGER) {%>
        <a href="/deleteComment?id=<%=comment.getId()%>">
            delete
        </a><%}%></li>

    <%}%>
</ul>
</body>
</html>
