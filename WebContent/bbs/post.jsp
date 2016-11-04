<%@page import="com.yanlei.bbs.DB"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("post")) {
		String title = request.getParameter("title");
		String cont = request.getParameter("cont");
		Connection conn = DB.getConn();
		boolean autoCommit = conn.getAutoCommit();
		conn.setAutoCommit(false);
		int rootId = -1;
		String sql = "insert into article values (null,?,?,?,?,now(),?)";
		PreparedStatement pstmt = DB.preparedStmt(conn, sql, Statement.RETURN_GENERATED_KEYS);//最后一个参数的指定是为了能拿到自动生成的一个key，用于作为文章的id
		pstmt.setInt(1, 0);
		pstmt.setInt(2, rootId);
		pstmt.setString(3, title);
		pstmt.setString(4, cont);
		pstmt.setInt(5, 0);
		pstmt.executeUpdate();
		ResultSet rsKey = pstmt.getGeneratedKeys();
		rsKey.next();
		rootId = rsKey.getInt(1);
		Statement stmt = DB.createStmt(conn);
		stmt.executeUpdate("update article set rootid = " + rootId + " where id = " + rootId);
		conn.commit();
		conn.setAutoCommit(autoCommit);
		DB.close(stmt);
		DB.close(pstmt);
		DB.close(conn);
		response.sendRedirect("article.jsp");
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>发表新帖~</title>
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
						<p class="jive-page-title">发新帖</p></td>
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

										<form action="post.jsp" method="post">
											<input type="hidden" name="action" value="post"> 标题：<input
												type="text" name="title"><br> 内容：
											<textarea name="cont" rows="15" cols="80"></textarea>
											<!--替换textarea要在要替换的textarea后边写-->
											<script type="text/javascript">
												CKEDITOR.replace('cont');
											</script>
											<br> <br> <input type="submit" value="确认回复" />
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
