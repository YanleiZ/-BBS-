<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.yanlei.bbs.Article"%>
<%@page import="com.yanlei.bbs.DB"%>
<%@page import="java.io.Writer"%>
<%@page pageEncoding="utf-8"%>

<%
	List<Article> article = new ArrayList<Article>();
	Connection conn = DB.getConn();
	Statement stmt = DB.createStmt(conn);
	ResultSet rs = DB.executeQuery(stmt, "select * from article where pid = 0");
	while (rs.next()) {
		Article a = new Article();
		a.initFromRs(rs);
		article.add(a);
	}
	DB.close(conn);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Java|Java世界_中文论坛|ChinaJavaWorld技术论坛 : Java语言*初级版</title>
<meta http-equiv="content-type" content="text/html; charset=GBK">
<link rel="stylesheet" type="text/css" href="images/style.css"
	title="Integrated Styles">
<script language="JavaScript" type="text/javascript"
	src="images/global.js"></script>
<link rel="alternate" type="application/rss+xml" title="RSS"
	href="http://bbs.chinajavaworld.com/rss/rssmessages.jspa?forumID=20">
<script language="JavaScript" type="text/javascript"
	src="images/common.js"></script>
</head>
<body>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tbody>
			<tr>
				<td width="140"><a
					href="http://bbs.chinajavaworld.com/index.jspa"><img
						src="images/header-left.gif"
						alt="Java|Java世界_中文论坛|ChinaJavaWorld技术论坛" border="0"></a></td>
				<td><img src="images/header-stretch.gif" alt="" border="0"
					height="57" width="100%"></td>
				<td width="1%"><img src="images/header-right.gif" alt=""
					border="0"></td>
			</tr>
		</tbody>
	</table>
	<br>
	<div id="jive-forumpage">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tbody>
				<tr valign="top">
					<td width="98%"><p class="jive-breadcrumbs">论坛: Java语言*初级版
							(模仿)</p>
						<p class="jive-description">探讨Java语言基础知识,基本语法等 大家一起交流
							共同提高！谢绝任何形式的广告</p></td>
				</tr>
			</tbody>
		</table>
		<div class="jive-buttons">
			<table summary="Buttons" border="0" cellpadding="0" cellspacing="0">
				<tbody>
					<tr>
						<td class="jive-icon"><a href="post.jsp"><img
								src="images/post-16x16.gif" alt="发表新主题" border="0" height="16"
								width="16"></a></td>
						<td class="jive-icon-label"><a id="jive-post-thread"
							href="post.jsp">发表新主题</a> <a
							href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;isBest=1"></a></td>
					</tr>
				</tbody>
			</table>
		</div>
		<br>
		<table border="0" cellpadding="3" cellspacing="0" width="100%">
			<tbody>

				<tr valign="top">
					<td><span class="nobreak"> 页: 1,316 - <span
							class="jive-paginator"> [ <a
								href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=0&amp;isBest=0">上一页</a>
								| <a
								href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=0&amp;isBest=0"
								class="">1</a> <a
								href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=25&amp;isBest=0"
								class="jive-current">2</a> <a
								href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=50&amp;isBest=0"
								class="">3</a> <a
								href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=75&amp;isBest=0"
								class="">4</a> <a
								href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=100&amp;isBest=0"
								class="">5</a> <a
								href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=125&amp;isBest=0"
								class="">6</a> | <a
								href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=50&amp;isBest=0">下一页</a>
								]
						</span>
					</span></td>
				</tr>

			</tbody>
		</table>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tbody>

				<tr valign="top">
					<td width="99%"><div class="jive-thread-list">
							<div class="jive-table">
								<table summary="List of threads" cellpadding="0" cellspacing="0"
									width="100%">
									<thead>
										<tr>
											<th class="jive-first" colspan="3">主题</th>
											<th class="jive-author"><nobr> 作者 &nbsp; </nobr></th>
											<th class="jive-view-count"><nobr> 浏览 &nbsp; </nobr></th>
											<th class="jive-msg-count" nowrap="nowrap">回复</th>
											<th class="jive-last" nowrap="nowrap">最新帖子</th>
										</tr>
									</thead>
									<tbody>
										<%
											int s = 0;
											for (Iterator<Article> iterator = article.iterator(); iterator.hasNext();) {
												Article a = iterator.next();
												s++;
												String preStr = "";
												for (int i = 0; i < a.getGrade(); i++) {
													preStr += "----";
												}
												String classStr = s % 2 == 0 ? "jive-even" : "jive-odd";
										%>
										<tr class="<%=classStr%>">
											<td class="jive-first" nowrap="nowrap" width="1%"><div
													class="jive-bullet">
													<img src="images/read-16x16.gif" alt="已读" border="0"
														height="16" width="16">
													<!-- div-->
												</div></td>
											<td nowrap="nowrap" width="1%">&nbsp; &nbsp;</td>
											<td class="jive-thread-name" width="95%"><a
												id="jive-thread-1"
												href="articleDetailFlat.jsp?id=<%=a.getId()%>"><%=a.getTitle()%></a></td>
											<td class="jive-author" nowrap="nowrap" width="1%"><span
												class=""> <a
													href="http://bbs.chinajavaworld.com/profile.jspa?userID=226030">ZhangYanlei</a>
											</span></td>
											<td class="jive-view-count" width="1%">8888</td>
											<td class="jive-msg-count" width="1%">8</td>
											<td class="jive-last" nowrap="nowrap" width="1%"><div
													class="jive-last-post">
													<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(a.getPdate())%>
													<br> by: <a
														href="http://bbs.chinajavaworld.com/thread.jspa?messageID=780182#780182"
														title="jingjiangjun" style="">zyl &#187;</a>
												</div></td>
										</tr>

										<%
											}
										%>
									</tbody>

								</table>
							</div>
						</div>
						<div class="jive-legend"></div></td>
				</tr>

			</tbody>
		</table>
		<br> <br>
	</div>
</body>
</html>
