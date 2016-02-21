package AlexTest.service;

import java.util.List;
import AlexTest.entity.User;

public interface UserService {

    void addUser(User user);

    void removeUser(Integer id);

    void updateUser(User user);

    User getUserById(Integer id);

    List<User> search(String searchText);
}
