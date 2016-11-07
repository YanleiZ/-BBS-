<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.yanlei.bbs.Article"%>
<%@page import="com.yanlei.bbs.DB"%>
<%@page import="java.io.Writer"%>
<%@page pageEncoding="utf-8"%>
<%@ include file="_sessioncheck.jsp" %>
<%!private void delete(int id, Connection conn, boolean isLeaf) {
		if (!isLeaf) {
			String sql = "select * from article where pid = " + id;
			Statement stmt = DB.createStmt(conn);
			ResultSet rs = DB.executeQuery(stmt, sql);
			try {
				while (rs.next()) {
					delete(rs.getInt("id"), conn, rs.getInt("isleaf") == 0);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DB.close(rs);
				DB.close(stmt);
			}
		}
		DB.executeUpdate(conn, "delete from article where id = " + id);
	}%>
<%
	int id = Integer.parseInt(request.getParameter("id"));
	int pid = Integer.parseInt(request.getParameter("pid"));
	boolean isLeaf = Boolean.parseBoolean(request.getParameter("isLeaf"));
	String url = request.getParameter("from");
	Connection conn = null;
	boolean autoCommit = true;
	ResultSet rs = null;
	Statement stmt = null;
	try {
		conn = DB.getConn();
		autoCommit = conn.getAutoCommit();
		conn.setAutoCommit(false);

		delete(id, conn, isLeaf);

		stmt = DB.createStmt(conn);
		rs = DB.executeQuery(stmt, "select count(*) from article where pid = " + pid);

		rs.next();
		int count = rs.getInt(1);
		if (count <= 0) {
			DB.executeUpdate(conn, "update article set isleaf = 0 where id = " + pid);
		}
		conn.commit();
	} finally {
		conn.setAutoCommit(autoCommit);
		DB.close(rs);
		DB.close(stmt);
		DB.close(conn);
	}
	response.sendRedirect(url);
%>
删帖成功！
