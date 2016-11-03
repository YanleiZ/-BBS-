<%@page import="java.sql.Statement"%>
<%@page import="com.mysql.jdbc.PreparedStatement"%>
<%@page import="com.yanlei.bbs.DB"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int pid = Integer.parseInt(request.getParameter("pid"));
	int rootId = Integer.parseInt(request.getParameter("rootId"));
	String title = request.getParameter("title");
	String cont = request.getParameter("cont");
	Connection conn = DB.getConn();
	String sql = "insert into article values (null,?,?,?,?,now(),?)";
	PreparedStatement pstmt = DB.preparedStmt(conn, sql);
	pstmt.setInt(1, pid);
	pstmt.setInt(2, rootId);
	pstmt.setString(3, title);
	pstmt.setString(4, cont);
	pstmt.setInt(5, 0);
	pstmt.executeUpdate();
	DB.close(pstmt);
	DB.close(conn);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>回复成功！
</body>
</html>