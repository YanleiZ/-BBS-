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
	boolean autoCommit = conn.getAutoCommit();
	conn.setAutoCommit(false);

	String sql = "insert into article values (null,?,?,?,?,now(),?)";
	PreparedStatement pstmt = DB.preparedStmt(conn, sql);
	pstmt.setInt(1, pid);
	pstmt.setInt(2, rootId);
	pstmt.setString(3, title);
	pstmt.setString(4, cont);
	pstmt.setInt(5, 0);
	pstmt.executeUpdate();
	Statement stmt = DB.createStmt(conn);
	stmt.executeUpdate("update article set isleaf = 1 where id = " + pid);
	conn.commit();
	conn.setAutoCommit(autoCommit);
	DB.close(stmt);
	DB.close(pstmt);
	DB.close(conn);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	回复成功！
	<br>
	<span id="timeS" style="background: green">3</span>秒后跳转会主页面
	<br>
	<a href="article.jsp">立即跳转</a>
	<script type="text/javascript">
		function delayURL(url) {
			var delay = document.getElementById("timeS").innerHTML;
			if (delay > 0) {
				delay--;
				document.getElementById("timeS").innerHTML = delay;
			} else {
				window.top.location.href = url;
			}
			setTimeout("delayURL('" + url + "')", 1000);
			//delayURL("article.jsp", 3000);
		}
	</script>
	<script type="text/javascript">
		delayURL("article.jsp");
	</script>
</body>
</html>