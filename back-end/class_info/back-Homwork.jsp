
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.allClass_info.model.*"%>
<%@page import="com.student_homework.model.*"%>
<%@page import="com.teacher_homework.model.*"%>
<%@page import="com.class_info.model.*"%>
<!DOCTYPE html>
<%
	AllClass_infoVO AllClass_infoVO = (AllClass_infoVO) session.getAttribute("AllClass_infoVO");
	Map<Teacher_homeworkVO, List<Student_homeworkVO>> getHomework = AllClass_infoVO.getHomework();
	Set<Teacher_homeworkVO> getHomeworkKeys = (Set<Teacher_homeworkVO>)getHomework.keySet();
	pageContext.setAttribute("getHomework", getHomework);
	pageContext.setAttribute("getHomeworkKeys", getHomeworkKeys);
%>


<html>
<head>
<meta charset="BIG5">
<title>TOMATO後台管理平台</title>


<!---------------------------------------- css ---------------------------------------->

<!-- jquery.datetimepicker -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/back-end/datetimepicker/jquery.datetimepicker.css" />


<!-- jquery.datetimepicker -->
<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>
<!---------------------------------------- css ---------------------------------------->



</head>
<body>
	<%@ include file="header-back.jsp"%>

	<div style="margin-left: 250px; margin-right: 20px; margin-top: 50px" >
		<nav aria-label="breadcrumb" style="margin-top: 30px;">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">Home</a></li>
				<li class="breadcrumb-item active" aria-current="page">課程管理</li>
				<li class="breadcrumb-item active" aria-current="page">課程列表</li>
				<li class="breadcrumb-item active" aria-current="page">作業</li>
			</ol>
		</nav>
		<br>
		<div class="container">
			<h1>課程作業</h1>
			<c:if test="${empty getHomework}">
				<img src="<%=request.getContextPath()%>/img/NoResult/NoResult.jpg">
			</c:if>
			<!--課程章節 -->
			<div id="accordion">
				<!--章節迴圈     Start-->
				<c:forEach var="trhwVO" items="${getHomeworkKeys}"
					varStatus="loop">
					<div class="card">
						<div class="card-header" id="heading_${loop.index}">
							<h5 class="mb-0">
								<table class="table table-striped" style="border-style:dotted; border-width:0.5px">
									<tr>
											<th scope="col">#</th>
											<th scope="col">作業編號</th>
											<th scope="col">單元編號</th>
											<th scope="col">作業標題</th>
											<th scope="col">更新時間</th>
											<th scope="col">修改</th>
											<th scope="col">刪除</th>
											<th scope="col">展開</th>
									</tr>
									<tr>
											<th scope="row">${ status.index + 1}</th>
											<td>${trhwVO.teacherhw_id}</td>
											<td>${trhwVO.unit_id}</td>
											<td>${trhwVO.hw_name}</td>
											<td><fmt:formatDate value="${trhwVO.hw_updatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
											<td>
												<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/TeacherhwServlet" style="margin-bottom: 0px;">
													<input type="hidden" name="teacherhw_id"  value="${trhwVO.teacherhw_id}">
													<input type="hidden" name="action" value="getOne_For_Update">
													<input class="btn btn-danger collapsed"  type="submit" value="修改">
												</FORM>
											</td>
											<td>
												<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/TeacherhwServlet" style="margin-bottom: 0px;">
													<input type="hidden" name="teacherhw_id" value="${trhwVO.teacherhw_id}">
													<input type="hidden" name="action" value="delete">
													<input class="btn btn-danger collapsed"  type="submit" value="刪除">
												</FORM>
											</td>
											<td>
												<button  class="btn btn-danger collapsed" data-toggle="collapse"
															data-target="#collapse_${loop.index}" aria-expanded="false"
															aria-controls="collapse_${loop.index}" style="display: inline-block;"
															data-chapterID="${Class_chapterVO_list.chapter_id}">展開</button>
											</td>
										</tr>	
									</table>
								
							</h5>
						</div>
						
						<!--單元迴圈 Start-->
						
							<div id="collapse_${loop.index}" class="collapse"
								aria-labelledby="heading_${loop.index}" data-parent="#accordion">
								<div class="card-body" style="padding: 0%;">
									<table class="table table-striped">
										<tr>
											<th scope="col">#</th>
										    <th scope="col">作業編號</th>
											<th scope="col">題目編號</th>
											<th scope="col">會員編號</th>
											<th scope="col">上傳時間</th>
											<th scope="col">更新時間</th>
											<th scope="col">頁面</th>
										</tr>
										<!--迴圈取出所有物件 -->
										<c:forEach var="HWVO" items="${getHomework[trhwVO]}" >
											<tr>
												<th scope="row">${ status.index + 1}</th>
												<td>${HWVO.studenthw_id}</td> 
												<td>${HWVO.teacherhw_id}</td>
												<td>${HWVO.member_id}</td>
												<td><fmt:formatDate value="${HWVO.hw_uploadtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td><fmt:formatDate value="${HWVO.hw_updatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
											<td>
												<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/TeacherhwServlet" style="margin-bottom: 0px;">
													<input type="hidden" name="teacherhw_id" value="${trhwVO.teacherhw_id}">
													<input type="hidden" name="action" value="delete">
													<input class="btn btn-danger collapsed"  type="submit" value="查看">
												</FORM>
											</td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</div>
						<!--單元迴圈END-->
					</div>
						<br>
				</c:forEach>
				<!--章節迴圈     END-->
			</div>
					
			
			
			
		</div>

		<!---------------------------------------- script ---------------------------------------->

		<!-- jquery-->
		<script
			src="<%=request.getContextPath()%>/vendors/jquery/jquery-3.5.1.min.js"></script>

		<!-- popper-->
		<script
			src="<%=request.getContextPath()%>/vendors/popper/popper.min.js"></script>

		<!-- bootstrap -->
		<script
			src="<%=request.getContextPath()%>/vendors/bootstrap/js/bootstrap.min.js"></script>

		<!-- public.js-->
		<script src="<%=request.getContextPath()%>/js/back-end/public.js"></script>

		<!-- jquery.datetimepicker -->
		<script
			src="<%=request.getContextPath()%>/back-end/datetimepicker/jquery.datetimepicker.full.js"></script>

		<!---------------------------------------- script ---------------------------------------->

		<script>
			$.datetimepicker.setLocale('zh');
			$('#f_date1').datetimepicker({
				theme : '', //theme: 'dark',
				timepicker : false, //timepicker:true,
				step : 1, //step: 60 (這是timepicker的預設間隔60分鐘)
				format : 'Y-m-d H:i:s', //format:'Y-m-d H:i:s',
				// 		value : new Date(), // value:   new Date(),
			//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
			//startDate:	            '2017/07/10',  // 起始日
			//minDate:               '-1970-01-01', // 去除今日(不含)之前
			//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
			});

			$.datetimepicker.setLocale('zh');
			$('#f_date2').datetimepicker({
				theme : '', //theme: 'dark',
				timepicker : false, //timepicker:true,
				step : 1, //step: 60 (這是timepicker的預設間隔60分鐘)
				format : 'Y-m-d H:i:s', //format:'Y-m-d H:i:s',
				// 		value : new Date(), // value:   new Date(),
			//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
			//startDate:	            '2017/07/10',  // 起始日
			//minDate:               '-1970-01-01', // 去除今日(不含)之前
			//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
			});

			var somedate1 = new Date();
			$('#f_date1')
					.datetimepicker(
							{
								beforeShowDay : function(date) {
									if (date.getYear() < somedate1.getYear()
											|| (date.getYear() == somedate1
													.getYear() && date
													.getMonth() < somedate1
													.getMonth())
											|| (date.getYear() == somedate1
													.getYear()
													&& date.getMonth() == somedate1
															.getMonth() && date
													.getDate() < somedate1
													.getDate())) {
										return [ false, "" ]
									}
									return [ true, "" ];
								}
							});

			var somedate1 = new Date('2017-06-15');
			$('#f_date2')
					.datetimepicker(
							{
								beforeShowDay : function(date) {
									if (date.getYear() < somedate1.getYear()
											|| (date.getYear() == somedate1
													.getYear() && date
													.getMonth() < somedate1
													.getMonth())
											|| (date.getYear() == somedate1
													.getYear()
													&& date.getMonth() == somedate1
															.getMonth() && date
													.getDate() < somedate1
													.getDate())) {
										return [ false, "" ]
									}
									return [ true, "" ];
								}
							});
		</script>


		<script>



		$(function () {

			
			$("table").on("click", "button.btn_status", function () {
				var data_updata;
				var that = $(this);
				if ($(this).closest("td").find("button").hasClass("btn_status_0")) {
					data_updata={
						"action" : "video_status_update",
						"unit_id" : $(this).closest("td").find("button").attr("data-id"),
						"video_status" :"1"
					}
				} else {
					data_updata={
						"action" : "video_status_update",
						"unit_id" : $(this).closest("td").find("button").attr("data-id"),
						"video_status" :"0"
					}
				}
				$.ajax({
					url: "<%=request.getContextPath()%>/Class_unit/Class_unitServlet", // 資料請求的網址
												type : "GET", // GET | POST | PUT | DELETE | PATCH
												data : data_updata, // 傳送資料到指定的 url
												success : function(data) { // request 成功取得回應後執行
													var btn_html = "<button type=\"button\"class=\"btn btn-primary btn_status\"value=\"${class_unitsVO.video_status}\">XXX</button>"
													if (that
															.closest("td")
															.find("button")
															.hasClass(
																	"btn_status_0")) {
														that
																.closest("td")
																.find("button")
																.removeClass(
																		"btn_status_0")
														that.closest("td")
																.find("button")
																.text("上架")
													} else {
														that
																.closest("td")
																.find("button")
																.addClass(
																		"btn_status_0")
														that.closest("td")
																.find("button")
																.text("下架")
													}
												}
											});
								});

				// 開啟 Modal 彈跳視窗
				$("table")
						.on(
								"click",
								"button.btn_modal",
								function() {
									$(this).closest("td").find(
											"div#exampleModal")
											.addClass("show");
									$(this)
											.closest("td")
											.find("div#exampleModal")
											.attr("style",
													"display:block;padding-right: 15px");
									$(this).closest("td").find(
											"div#exampleModal").attr(
											"aria-modal", "true");
									$(this).closest("td").find(
											"div#exampleModal").attr("role",
											"diolog");
								});

				// 關閉 Modal
				$("table").on(
						"click",
						"button.btn_modal_close",
						function() {
							$(this).closest("td").find("div#exampleModal")
									.removeClass("show");
							$(this).closest("td").find("div#exampleModal")
									.attr("style", "display:none");
							$(this).closest("td").find("div#exampleModal")
									.removeattr("role");
						});

				$("button.btn_modal_close").on("click", function() {
					$(".vjs-playing").click();
				});
			});
		</script>
</body>

</html>