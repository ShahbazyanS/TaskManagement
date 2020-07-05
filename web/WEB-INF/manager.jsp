<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="model.Task" %>
<%@ page import="model.UserType" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<%List<User> users = (List<User>) request.getAttribute("users");%>
<%List<Task> tasks = (List<Task>) request.getAttribute("tasks");%>
<form action="/searchTask" method="post" style="margin-left: 1000px">
    <input type="search" name="search" placeholder="search">
    <button type="submit">search</button>
</form>
<a href="/logout" style="text-decoration: none; color: black">logout</a>
<div class="manager">
    <div class="add_user">
        <h2> Add User: </h2>
        <form action="/userRegister" method="post" enctype="multipart/form-data" onsubmit="validate()">
            <p id="p" style="color: red"></p>
            <input type="text" id="n" name="name" placeholder="name"><br>
            <input type="text" id="s" name="surname" placeholder="surname"><br>
            <input type="text" id="e" name="email" placeholder="email"><br>
            <input type="text" id="pass" name="password" placeholder="password"><br>
            <select name="user_type" id="t">
                <option value="USER">USER</option>
                <option value="MANAGER">MANAGER</option>
            </select><br>
            <input type="file" name="image"><br>
            <input type="submit" id="button" class="btn btn-success" value="add">
        </form>
    </div>
    <script src="../js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="../js/valid.js" type="text/javascript"></script>

    <%--    <script>function validate() {--%>
    <%--        var name = document.getElementById("n")--%>
    <%--        var surname = document.getElementById("s")--%>
    <%--        var email = document.getElementById("e")--%>
    <%--        var password = document.getElementById("pass")--%>
    <%--        var type = document.getElementById("t")--%>

    <%--        if (name.val == ""){--%>
    <%--            name.style.border = "2px solid red";--%>
    <%--            document.getElementById("p").innerHTML = "please input name"--%>
    <%--            return false;--%>
    <%--        }else--%>
    <%--        if (!surname.value || surname.value === " "){--%>
    <%--            surname.style.border = "2px solid red";--%>
    <%--            document.getElementById("p").innerHTML = "please input surname"--%>
    <%--            return false;--%>
    <%--        }else--%>

    <%--        if (!email.value || password.value === " "){--%>
    <%--            email.style.border = "2px solid red";--%>
    <%--            document.getElementById("p").innerHTML = "please input email"--%>
    <%--            return false;--%>
    <%--        }else--%>
    <%--        if (!password.value || password.value === " "){--%>
    <%--            password.style.border = "2px solid red";--%>
    <%--            document.getElementById("p").innerHTML = "please input password"--%>
    <%--            return false;--%>
    <%--        }else--%>
    <%--        if (!type.value || password.type === " "){--%>
    <%--            type.style.border = "2px solid red";--%>
    <%--            document.getElementById("p").innerHTML = "please input user type"--%>
    <%--            return false;--%>
    <%--        }--%>


    <%--        return true;--%>
    <%--    }--%>
    <%--//     </script>--%>
    <div class="add_task">
        <h2> Add Task: </h2>
        <p id="pp" style="color: red"></p>
        <form action="/addTask" id="addTask" method="post" onsubmit="validateTask()">
            <input type="text" id="tn" name="name" placeholder="name"><br>
            <textarea name="description" id="td" placeholder="description"></textarea><br>
            <input type="date" id="date" name="deadline"><br>
            <select name="status">
                <option value="NEW">NEW</option>
                <option value="IN_PROGRESS">IN_PROGRESS</option>
                <option value="FINISHED">FINISHED</option>
            </select><br>
            <select name="user_id">
                <%
                    for (User user : users) { %>
                <option value="<%=user.getId()%>"><%=user.getName()%>  <%=user.getSurname()%>
                </option>
                <%
                    }%>

            </select><br>
            <input type="submit" value="add"><br>
        </form>
    </div>
</div>
<script>
    $(document).ready(function () {

        $("#addTask").submit(function (e) {
            e.preventDefault()

        })


        let getList = function () {
            $.ajax({
                url: "/tasklist",
                method: "GET",
                success: function (result) {
                    $("#all_tasks").html(result)
                }
            })
        };
        setInterval(getList, 2000);
        {
        }
    })
</script>
<script>function validateTask() {
    var name = document.getElementById("tn")
    var description = document.getElementById("td")
    var date = document.getElementById("date")


    if (!name.value || name.value === " ") {
        name.style.border = "2px solid red";
        document.getElementById("pp").innerHTML = "please input name"
        return false;
    }
    if (!description.value) {
        description.style.border = "2px solid red";
        document.getElementById("pp").innerHTML = "please input description"
        return false;
    }
    if (!date.value) {
        date.style.border = "2px solid red";
        document.getElementById("pp").innerHTML = "please input date"
        return false;
    }


    return true;
}
</script>

<div class="all_users">
    All Users:<br>
    <table border="1">
        <tr>
            <th><h2>name</h2></th>
            <th><h2>surname</h2></th>
            <th><h2>email</h2></th>
            <th><h2>type</h2></th>
            <th><h2>delete user</h2></th>
        </tr>
        <%
            for (User user : users) { %>
        <tr>
            <td><%=user.getName()%>
            </td>
            <td><%=user.getSurname()%>
            </td>
            <td><%=user.getEmail()%>
            </td>
            <td><%=user.getUserType().name()%>
            </td>
            <td><%if (user.getUserType() == UserType.USER || !user.getEmail().equals("admin@mail.com")) {%><a
                    href="/deleteUser?id=<%=user.getId()%>">
                delete
            </a><%}%></td>
        </tr>
        <%
            }%>
    </table>
</div>
<div id="all_tasks" class="all_tasks">
    All Tasks:<br>
    <%--    <table border="1">--%>
    <%--        <tr>--%>
    <%--            <th>name</th>--%>
    <%--            <th>description</th>--%>
    <%--            <th>deadline</th>--%>
    <%--            <th>status</th>--%>
    <%--            <th>user</th>--%>
    <%--        </tr>--%>
    <%--        <%--%>
    <%--            for (Task task : tasks) { %>--%>
    <%--        <tr>--%>
    <%--            <td><a href="/taskById?task_id=<%=task.getId()%>"><%=task.getName()%>--%>
    <%--            </a>--%>
    <%--            </td>--%>
    <%--            <td><%=task.getDescription()%>--%>
    <%--            </td>--%>
    <%--            <td><%=task.getDeadline()%>--%>
    <%--            </td>--%>
    <%--            <td><%=task.getStatus().name()%>--%>
    <%--            </td>--%>
    <%--            <td><%=task.getUser().getName() + " " + task.getUser().getSurname()%>--%>
    <%--            </td>--%>
    <%--        </tr>--%>
    <%--        <%--%>
    <%--            }%>--%>
    <%--    </table>--%>
</div>

</body>
</html>
