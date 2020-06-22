package listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class ApplicationListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("server was started");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("server was stoped");
    }
}
