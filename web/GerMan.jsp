<%@page import="java.util.Properties"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Gerente de Mantenimiento</h1>
        <form name="uno" action="asign.jsp" method="get" >
            <table border="1" width="600">
                <tr>
                    <th>Reporte</th>
                    <th>Nombre del caso</th>
                    <th>Estatus</th>
                    <th>Ingeniero</th> 
                    <th>Fecha de creación</th>
                </tr>
                <%
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = null;
                    Statement statement = null;
                    ResultSet resultSet = null;

                    try {
                        
                        String url = "jdbc:mysql://localhost:3306/elet";
                        Properties info = new Properties();
                        info.put("user", "root");
                        info.put("password", "n0m3l0");
                        connection = DriverManager.getConnection(url, info);

                        statement = connection.createStatement();
                        resultSet = statement.executeQuery("select case_id,case_name,case_status,user_name,user_creation_date from tbl_case_admin "
                                + "inner join tbl_cases on tbl_case_admin.case_id = tbl_cases.id_case "
                                + "inner join tbl_users on tbl_case_admin.admin_id = tbl_users.id_user;");
                        while (resultSet.next()) {
                            Integer id = resultSet.getInt("case_id");
                            String case_name = resultSet.getString("case_name");
                            String case_status = resultSet.getString("case_status");
                            String case_ing = resultSet.getString("user_name");
                            String last = resultSet.getString("user_creation_date");
                %>
                <tr> 
                    <th><%=id%></th>  
                    <th><%=case_name%></th>
                    <th><%=case_status%></th>
                    <th><%=case_ing%></th>
                    <th><%=last%></th>
                </tr>
                <%

                        }

                        statement.close();
                        resultSet.close();
                        connection.close();
                    } catch (Exception e) {
                        out.println("SQLException caught: " + e.getMessage());
                    }

                %>
            </table>
        </form>
    </body>
</html>
