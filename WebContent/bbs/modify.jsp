<%@page import="com.yanlei.bbs.Article"%>
<%@page import="com.yanlei.bbs.DB"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
	String action = request.getParameter("action");
	int id = Integer.parseInt(request.getParameter("id"));

	if (action != null && action.trim().equals("modify")) {
		Connection conn = DB.getConn();
		String title = request.getParameter("title");
		String cont = request.getParameter("cont");

		/* DB.executeUpdate(conn,
				"update article set title = '" + title + "',cont='" + cont + "'where id = " + id); */
		PreparedStatement pstmt = DB.preparedStmt(conn, "update article set title = ?,cont=? where id = ?");
		pstmt.setString(1, title);
		pstmt.setString(2, cont);
		pstmt.setInt(3, id);
		pstmt.executeUpdate();
		DB.close(pstmt);
		DB.close(conn);
		response.sendRedirect("article.jsp");
		return;
	}
%>
<%
	Connection conn = DB.getConn();
	Statement stmt = DB.createStmt(conn);
	ResultSet rs = DB.executeQuery(stmt, "select * from article where id = " + id);
	if (!rs.next())
		return;
	Article a = new Article();
	a.initFromRs(rs);
	DB.close(rs);
	DB.close(stmt);
	DB.close(conn);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>修改帖子~</title>
<meta http-equiv="content-type" content="text/html; charset=GBK">
<link rel="stylesheet" type="text/css" href="images/style.css"
	title="Integrated Styles">
<script language="JavaScript" type="text/javascript"
	src="images/global.js"></script>

<link rel="stylesheet" type="text/css" href="images/style.css"
	title="Integrated Styles">
<script language="JavaScript" type="text/javascript"
	src="images/global.js"></script>
<!-- fckeditor -->
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<!-- end of fckeditor -->

</head>
<body>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tbody>
			<tr>
				<td width="40%"><img src="images/header-stretch.gif" alt=""
					border="0" height="57" width="100%"></td>
				<td width="1%"><img src="images/header-right.gif" alt=""
					height="57" border="0"></td>
			</tr>
		</tbody>
	</table>
	<br>
	<div id="jive-flatpage">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tbody>
				<tr valign="top">
					<td width="99%"><p class="jive-breadcrumbs">
							<a href="http://bbs.chinajavaworld.com/index.jspa">首页</a> &#187;
							<a
								href="http://bbs.chinajavaworld.com/forumindex.jspa?categoryID=1">ChinaJavaWorld技术论坛|Java世界_中文论坛</a>
							&#187; <a
								href="http://bbs.chinajavaworld.com/category.jspa?categoryID=2">Java
								2 Platform, Standard Edition (J2SE)</a> &#187; <a
								href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=0">Java语言*初级版</a>
						</p>
						<p class="jive-page-title">修改帖子</p></td>
					<td width="1%"><div class="jive-accountbox"></div></td>
				</tr>
			</tbody>
		</table>

		<br>
		<table border="0" cellpadding="0" cellspacing="0" width="930"
			height="61">
			<tbody>
				<tr valign="top">
					<td width="99%"><div id="jive-message-holder">
							<div class="jive-message-list">
								<div class="jive-table">
									<div class="jive-messagebox">

										<form action="modify.jsp" method="post">
											<input type="hidden" name="action" value="modify"> <input
												type="hidden" name="id" value="<%=id%>"> 标题：<input
												type="text" name="title" value="<%=a.getTitle()%>"><br>
											内容：
											<textarea name="cont" rows="15" cols="80"><%=a.getCont()%></textarea>
											<!--替换textarea要在要替换的textarea后边写-->
											<script type="text/javascript">
												CKEDITOR.replace('cont');
											</script>
											<br> <br> <input type="submit" value="确认修改" />
										</form>

									</div>
								</div>
							</div>
							<div class="jive-message-list-footer">
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tbody>
										<tr>
											<td nowrap="nowrap" width="1%"><br> <br></td>
											<td align="center" width="98%"><table border="0"
													cellpadding="0" cellspacing="0">
													<tbody>
														<tr>
															<td><a
																href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20"><img
																	src="images/arrow-left-16x16.gif" alt="返回到主题列表"
																	border="0" height="16" hspace="6" width="16"></a></td>
															<td><a
																href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20">返回到主题列表</a>
															</td>
														</tr>
													</tbody>
												</table></td>
											<td nowrap="nowrap" width="1%">&nbsp;</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div></td>
					<td width="1%">&nbsp;</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>
