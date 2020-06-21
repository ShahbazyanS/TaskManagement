package manager;

import db.DBConnectionProvider;
import model.Status;
import model.Task;
import model.User;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class TaskManager {

    private Connection connection;

    public TaskManager() {
        connection = DBConnectionProvider.getInstance().getConnection();
    }

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    private UserManager userManager = new UserManager();

    public void addTask(Task task) {
        String query = "INSERT INTO task (name, description, deadline, status, user_id) VALUES (?,?,?,?,?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, task.getName());
            preparedStatement.setString(2, task.getDescription());
            preparedStatement.setString(3, sdf.format(task.getDeadline()));
            preparedStatement.setString(4, task.getStatus().name());
            preparedStatement.setInt(5, task.getUserId());
            preparedStatement.executeUpdate();
            ResultSet rs = preparedStatement.getGeneratedKeys();
            if (rs.next()) {
                task.setId(rs.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Task> getTasksByUser(int userId) {
        List<Task> tasks = new ArrayList<>();
        String query = "SELECT * FROM task WHERE user_id = '" + userId + "'";
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                Task task = getTaskFromResultSet(resultSet);
                task.setUser(userManager.getUserById(task.getUserId()));
                tasks.add(task);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;

    }

    private Task getTaskFromResultSet(ResultSet resultSet) {
        try {
            Task task = Task.builder()
                    .id(resultSet.getLong(1))
                    .name(resultSet.getString(2))
                    .description(resultSet.getString(3))
                    .deadline(sdf.parse(resultSet.getString(4)))
                    .status(Status.valueOf(resultSet.getString(5)))
                    .userId(resultSet.getInt(6))
                    .build();
            return task;
        } catch (ParseException | SQLException e) {
            e.printStackTrace();
            return null;
        }

    }

    public List<Task> getAllTasks() {
        String query = "SELECT * FROM task";
        try {
            List<Task> tasks = new LinkedList<>();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                Task task = getTaskFromResultSet(resultSet);
                task.setUser(userManager.getUserById(task.getUserId()));
                tasks.add(task);
            }
            return tasks;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateTaskStatus(int id, String status) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE task SET status = ? WHERE id = ?");
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Task> searchTask(String searc) {
        String query = "SELECT * FROM task WHERE `name` LIKE ?";
        List<Task> tasks = new LinkedList<>();
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, "%" + searc + "%");
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Task task = getTaskFromResultSet(resultSet);
                task.setUser(userManager.getUserById(task.getUserId()));
                tasks.add(task);
            }
            return tasks;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}