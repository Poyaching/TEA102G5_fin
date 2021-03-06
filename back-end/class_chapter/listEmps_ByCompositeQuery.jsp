<!-- 設定JSP編碼 -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<!-- 設定標籤庫 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- 設定import資料 -->
<%@ page import="java.util.*"%>
<%@ page import="com.main_class.model.*"%>


<%
	List<Main_classVO> list = (List) request.getAttribute("listEmps_ByCompositeQuery");
	pageContext.setAttribute("list", list);
%>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=yes">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/vendors/bootstrap/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<link href="<%=request.getContextPath()%>/vendors/video-js/css/video-js.css"
	rel="stylesheet" />
<style>
/* 套用全部 */
* {
	box-sizing: border-box;
}
</style>

<title>主課程類別資料 - listOneMain_class.jsp</title>

</head>
<body bgcolor='white'>
	<div class="container">
		<h1>MainClass: listOneMain_class</h1>
	<a href="<%=request.getContextPath()%>/back-end/class_chapter/select_page.jsp">class_chapter: Home</a>
		<br>
		<table class="table table-striped">
			<tr>
				<th scope="col">#</th>
				<th scope="col">主課程編號</th>
				<th scope="col">主課程名稱</th>
				<th scope="col">主課程狀態</th>
				<th scope="col">查看詳情</th>
				<th scope="col">修改</th>
				<th scope="col">刪除</th>
			</tr>
			<!--分頁 -->
<%-- 			<%@ include file="page1.file"%> --%>

			<!--迴圈取出所有物件 -->
			<c:forEach var="main_classVO" items="${list}" >

				<tr>
					<th scope="row">${ status.index + 1}</th>
					<td>${main_classVO.mainClass_id}</td>
					<td>${main_classVO.mainClass_name}</td>
					<!--顯示取代 -->
					<c:if test="${fn:contains(main_classVO.mainClass_status, '1')}">
						<td>顯示</td>
					</c:if>
					<c:if test="${fn:contains(main_classVO.mainClass_status, '0')}">
						<td>隱藏</td>
					</c:if>
					<td>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/Main_class/Main_classServlet"
							"
							style="margin-bottom: 0px;">
							<input class="btn btn-primary " type="submit" value="查看詳情">
							<input type="hidden" name="mainClass_name"
								value="${main_classVO.mainClass_name}"> <input
								type="hidden" name="mainClass_id"
								value="${main_classVO.mainClass_id}"> <input
								type="hidden" name="action" value="mainclass_id_sub_class">
						</FORM>
					</td>
					<td>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/Main_class/Main_classServlet"
							style="margin-bottom: 0px;">
							<input class="btn btn-primary " type="submit" value="修改">
							<input type="hidden" name="mainClass_id"
								value="${main_classVO.mainClass_id}"> <input
								type="hidden" name="action" value="update_mainClass_id">
						</FORM>
					</td>
					<td>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/Main_class/Main_classServlet"
							"
							style="margin-bottom: 0px;">
							<input class="btn btn-primary " type="submit" value="刪除">
							<input type="hidden" name="mainClass_id"
								value="${main_classVO.mainClass_id}"> <input
								type="hidden" name="action" value="delete">
						</FORM>
					</td>
				</tr>
			</c:forEach>
		</table>
<%-- 		<%@ include file="page2.file"%> --%>
	</div>
</body>
</html>