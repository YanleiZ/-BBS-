<%@page pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String username = "";
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("login")) {
		username = request.getParameter("username");
		//检查
		String password = request.getParameter("password");
		if (username == null || !username.trim().equals("admin")) {
			out.println("无此用户！");
		} else if (password == null || !password.trim().equals("admin")) {
			out.println("密码错误！");
		} else {
			session.setAttribute("adminLogined", "true");
			response.sendRedirect("articleFlat.jsp");
		}
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>后台管理</title>

</head>
<body>

	<form action="login.jsp" method="post">
		<input type="hidden" name="action" value="login" /> 用户名： <input
			type="text" name="username" value="<%=username%>" /> <br> 密码： <input
			type="password" name="password" /> <br> <input type="submit"
			value="login" />
	</form>


</body>
</html>