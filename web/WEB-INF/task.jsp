<%@ page import="model.Comment" %>
<%@ page import="model.Task" %>
<%@ page import="model.User" %>
<%@ page import="model.UserType" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%
    Task task = (Task) request.getAttribute("taskById");
    List<Comment> comments = (List<Comment>) request.getAttribute("comments");
    User user = (User) session.getAttribute("user");
%>

<div class="comment">
   <h2> All Tasks:</h2><br>
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
<div class="add_comment">
<form action="/addComment" method="post">
    <input type="hidden" name="task_id" value="<%=task.getId()%>">
    <input type="te" name="comment" placeholder="comment"><br>
    <input type="submit" name="comment">
</form>
</div>
<br>
<div class="show_comments">
<ul>
    <%
        for (Comment comment : comments) {%>

    <li><%=comment.getUser().getName()%> <%=comment.getUser().getSurname()%>
        <%if (comment.getUser().getEmail().equals(user.getEmail()) | user.getUserType() == UserType.MANAGER) {%>
        <a href="/deleteComment?id=<%=comment.getId()%>" style="text-decoration: none; color: red">
            x
        </a><%}%><br><%=comment.getComment()%>
        - <%=comment.getDate()%>
       </li>

    <%}%>
</ul>
   </div>
</body>
</html>
