package manager;

import db.DBConnectionProvider;
import model.Comment;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class CommentManager {

    private Connection connection;

    public CommentManager() {
        connection = DBConnectionProvider.getInstance().getConnection();
    }
    private TaskManager taskManager = new TaskManager();
    private UserManager userManager = new UserManager();

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public void addComment(Comment comment) {
        String query = "INSERT INTO comment (task_id, user_id, comment, `date`) VALUES (?,?,?,?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setLong(1, comment.getTask_id());
            preparedStatement.setInt(2, comment.getUser_id());
            preparedStatement.setString(3, comment.getComment());
            preparedStatement.setString(4, sdf.format(comment.getDate()));
            preparedStatement.executeUpdate();
            ResultSet rs = preparedStatement.getGeneratedKeys();
            if (rs.next()) {
                comment.setId(rs.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Comment getCommentFromResultSet(ResultSet resultSet) {
        try {
            Comment comment = Comment.builder()
                    .id(resultSet.getInt(1))
                    .task_id(resultSet.getInt(2))
                    .user_id(resultSet.getInt(3))
                    .comment(resultSet.getString(4))
                    .date(resultSet.getDate(5))
                    .build();
            comment.setUser(userManager.getUserById(comment.getUser_id()));
            return comment;
        } catch ( SQLException e) {
            e.printStackTrace();
        }return null;
    }

    public List<Comment> getCommentsByTaskId(long taskId) {
        List<Comment> comments = new ArrayList<>();
        String query = "SELECT * FROM comment WHERE task_id = '" + taskId + "'";
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                Comment comment = getCommentFromResultSet(resultSet);
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }

    public void deleteCommentById(int id){
        String query = "DELETE FROM comment WHERE id = " + id;
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate(query);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
