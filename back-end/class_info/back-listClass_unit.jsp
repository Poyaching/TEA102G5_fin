<%@page import="com.class_info.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.allClass_info.model.*"%>
<%@ page import="com.class_chapter.model.*"%>
<%@ page import="com.class_unit.model.*"%>
<!DOCTYPE html>
<%
	AllClass_infoVO AllClass_infoVO = (AllClass_infoVO) session.getAttribute("AllClass_infoVO");
	Map<Class_chapterVO, List<Class_unitVO>> chapterAndUnit = AllClass_infoVO.getChapterAndUnit();
	Set<Class_chapterVO> keys = (Set<Class_chapterVO>)chapterAndUnit.keySet();
	List<Class_chapterVO> list = (List<Class_chapterVO>)new ArrayList();
	pageContext.setAttribute("chapterAndUnit", chapterAndUnit);
	pageContext.setAttribute("keys", keys);
%>


<html>
<head>
<meta charset="BIG5">
<title>TOMATO��x�޲z���x</title>


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
				<li class="breadcrumb-item active" aria-current="page">�ҵ{�޲z</li>
				<li class="breadcrumb-item active" aria-current="page">�ҵ{�C��</li>
				<li class="breadcrumb-item active" aria-current="page">���`�γ椸</li>
			</ol>
		</nav>
		<br>
		<div class="container">
			<h1>�Ҧ��椸���O</h1>
			<c:if test="${empty chapterAndUnit}">
				<img src="<%=request.getContextPath()%>/img/NoResult/NoResult.jpg">
			</c:if>
			<!--�ҵ{���` -->
			<div id="accordion">
				<!--���`�j��     Start-->
				<c:forEach var="Class_chapterVO_list" items="${keys}"
					varStatus="loop">
					<div class="card">
						<div class="card-header" id="heading_${loop.index}">
							<h5 class="mb-0">
								<button class="btn btn-link collapsed" data-toggle="collapse"
									data-target="#collapse_${loop.index}" aria-expanded="false"
									aria-controls="collapse_${loop.index}"
									data-chapterID="${Class_chapterVO_list.chapter_id}">
									${Class_chapterVO_list.chapter_id} : ${Class_chapterVO_list.chapter_name}</button>
							</h5>
						</div>
						<!--�椸�j�� Start-->
						

							
							<div id="collapse_${loop.index}" class="collapse"
								aria-labelledby="heading_${loop.index}" data-parent="#accordion">
								<div class="card-body" style="padding: 0%;">
									<table class="table table-striped">
										<tr>
											<th scope="col">#</th>
											<th scope="col">�椸�s��</th>
											<th scope="col">�椸�W��</th>
											<th scope="col">���ݳ��`</th>
											<th scope="col">�v���ɶ�</th>
											<th scope="col">�v���[��</th>
											<th scope="col">�v�����A</th>
											<th scope="col">��s�ɶ�</th>
											<th scope="col">�d�ݸԱ�</th>
											<th scope="col">�ק�</th>
										</tr>
										<!--�j����X�Ҧ����� -->
							<c:forEach var="Class_unit" items="${chapterAndUnit[Class_chapterVO_list]}" >

											<tr>
												<th scope="row">${ status.index + 1}</th>
												<td>${Class_unit.unit_id}</td>
												<td>${Class_unit.unit_name}</td>
												<td>${Class_unit.chapter_id}</td>
												<td>${Class_unit.video_long}</td>
												<td>
													<!-- Modal -->
													<div class="modal fade" id="exampleModal" tabindex="-1"
														role="dialog" aria-labelledby="exampleModalLabel"
														aria-hidden="true">
														<div class="modal-dialog" role="document">
															<div class="modal-content">
																<div class="modal-header">
																	<h5 class="modal-title" id="exampleModalLabel">${Class_unit.unit_id}
																		�G ${Class_unit.unit_name}</h5>
																	<button type="button" class="close btn_modal_close"
																		data-dismiss="modal" aria-label="Close">
																		<span aria-hidden="true">&times;</span>
																	</button>
																</div>
																<div class="modal-body">
																	<video width="320" height="240" id="video" data-id="${Class_unit.unit_id}"
																		class="video-js vjs-fluid " controls preload="auto"
																		data-setup="{}">
																		<source id="video_url"
																			src="<%=request.getContextPath()%>/Class_unit/Class_unitServlet?unit_id=${Class_unit.unit_id}&action=many_video"
																			type="video/mp4" />
																	</video>
																</div>
															</div>
														</div>
													</div> <c:if test="${  empty Class_unit.video}">
														<button type="button" disabled
															class="btn_modal btn btn-danger ">�L�v��</button>
													</c:if> <c:if test="${not empty Class_unit.video}">
														<!-- Button trigger modal -->
														<button type="button" class="btn btn-danger btn_modal"
															data-toggle="modal" data-target="#exampleModal">
															�[�ݼv��</button>
													</c:if>


												</td>
												<td><c:if
														test="${fn:contains(Class_unit.video_status, '0')}">
														<button type="button" data-id="${class_unitsVO.unit_id}"
															class="btn btn-danger btn_status btn_status_0"
															value="${Class_unit.video_status}">�U�[</button>
													</c:if> <c:if test="${fn:contains(Class_unit.video_status, '1')}">
														<button type="button" data-id="${Class_unit.unit_id}"
															class="btn btn-danger btn_status"
															value="${Class_unit.video_status}">�W�[</button>
													</c:if></td>
												<td><fmt:formatDate
														value="${Class_unit.video_updatetime}"
														pattern="yyyy-MM-dd HH:mm:ss" /></td>


												<td>
													<FORM METHOD="post"
														ACTION="<%=request.getContextPath()%>/Class_unit/Class_unitServlet"
														style="margin-bottom: 0px;">
														<input class="btn btn-danger " type="submit" value="�ק�">
														<input type="hidden" name="unit_id"
															value="${class_unitsVO.unit_id}"> <input
															type="hidden" name="action" value="update_unit_id">
													</FORM>
												</td>
												<td>
													<FORM METHOD="post"
														ACTION="<%=request.getContextPath()%>/Class_unit/Class_unitServlet"
														style="margin-bottom: 0px;">
														<input class="btn btn-danger " type="submit" value="�R��">
														<input type="hidden" name="unit_id"
															value="${class_unitsVO.unit_id}	"> <input
															type="hidden" name="action" value="delete">
													</FORM>
												</td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</div>
						<!--�椸�j��END-->
					</div>
				</c:forEach>
				<!--���`�j��     END-->
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
				step : 1, //step: 60 (�o�Otimepicker���w�]���j60����)
				format : 'Y-m-d H:i:s', //format:'Y-m-d H:i:s',
				// 		value : new Date(), // value:   new Date(),
			//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
			//startDate:	            '2017/07/10',  // �_�l��
			//minDate:               '-1970-01-01', // �h������(���t)���e
			//maxDate:               '+1970-01-01'  // �h������(���t)����
			});

			$.datetimepicker.setLocale('zh');
			$('#f_date2').datetimepicker({
				theme : '', //theme: 'dark',
				timepicker : false, //timepicker:true,
				step : 1, //step: 60 (�o�Otimepicker���w�]���j60����)
				format : 'Y-m-d H:i:s', //format:'Y-m-d H:i:s',
				// 		value : new Date(), // value:   new Date(),
			//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
			//startDate:	            '2017/07/10',  // �_�l��
			//minDate:               '-1970-01-01', // �h������(���t)���e
			//maxDate:               '+1970-01-01'  // �h������(���t)����
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
					url: "<%=request.getContextPath()%>/Class_unit/Class_unitServlet", // ��ƽШD�����}
												type : "GET", // GET | POST | PUT | DELETE | PATCH
												data : data_updata, // �ǰe��ƨ���w�� url
												success : function(data) { // request ���\���o�^�������
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
																.text("�W�[")
													} else {
														that
																.closest("td")
																.find("button")
																.addClass(
																		"btn_status_0")
														that.closest("td")
																.find("button")
																.text("�U�[")
													}
												}
											});
								});

				// �}�� Modal �u������
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

				// ���� Modal
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