package model;

import dao.MysqlConnect;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class User {
        private int userID;
        private String fullName;
        private String email;
        private String passWord;
        private String address;
        private Date birthDay;
        private Date registationDay;
        private String userRole;
        private String phoneNumber;

   
}
