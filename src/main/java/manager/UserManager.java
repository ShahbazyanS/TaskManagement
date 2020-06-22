package manager;

import db.DBConnectionProvider;
import model.User;
import model.UserType;

import java.sql.*;
import java.util.LinkedList;
import java.util.List;

public class UserManager {

    private Connection connection;

    public UserManager() {
        connection = DBConnectionProvider.getInstance().getConnection();
    }

    public User getManagerByEmailAndPassword(String email, String password) {
        String query = "SELECT * FROM user WHERE email = '" + email + "' AND password = '" + password + "'";
        return getUserFromDB(query);
    }

    public void addUser(User user) {

        String query = "INSERT INTO user (`name`, surname, email, password, user_type, picture_url) VALUES (?,?,?,?,?,?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getSurname());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getPassword());
            preparedStatement.setString(5, user.getUserType().name());
            preparedStatement.setString(6, user.getPictureUrl());
            preparedStatement.executeUpdate();
            ResultSet rs = preparedStatement.getGeneratedKeys();
            if (rs.next()) {
                user.setId(rs.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private User getUserFromResultSet(ResultSet resultSet) {
        try {
            return User.builder()
                    .id(resultSet.getInt(1))
                    .name(resultSet.getString(2))
                    .surname(resultSet.getString(3))
                    .email(resultSet.getString(4))
                    .password(resultSet.getString(5))
                    .userType(UserType.valueOf(resultSet.getString(6)))
                    .pictureUrl(resultSet.getString(7))
                    .build();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void deleteUserById(int id){
        String query = "DELETE FROM user WHERE id = " + id;
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate(query);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<User> getAllUser() {

        String query = "SELECT * FROM user";
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            List<User> users = new LinkedList<>();
            while (resultSet.next()) {
                users.add(getUserFromResultSet(resultSet));
            }
            return users;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getUserById(int id) {
        String query = "SELECT * FROM user WHERE id = " + id;
        return getUserFromDB(query);
    }


    private User getUserFromDB(String query) {
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            if (resultSet.next()) {
                return getUserFromResultSet(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
