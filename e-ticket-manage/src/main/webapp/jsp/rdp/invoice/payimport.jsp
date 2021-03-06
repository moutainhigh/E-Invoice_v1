<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/jsp/rdp/commons/tag_libs.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>导入开票（.xls）</title>
	<script type="text/javascript" src="${ctx}/jsp/resources/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="${ctx}/webresources/script/wabacus_api.js"></script>
	<script type="text/javascript" src="${ctx}/webresources/component/artDialog/artDialog.js"></script>
	<script type="text/javascript" src="${ctx}/webresources/component/artDialog/plugins/iframeTools.js"></script>
	<link rel="stylesheet" href="${ctx}/resource/css/invoice.css" type="text/css" />
</head>
<body>
	<div style="margin-left:40px; margin-top:40px; ">
		<form method="post" action="<%=path %>/FapiaoDataImp/insertData.htm" enctype="multipart/form-data">
			<input type="file" id="fiscal" name="file" style=" font-size:18px; height:30px;"/><br/><br/>
			(导入xls/xlsx格式的文件)
			<div style="margin:40px; ">
				<textarea id="resultinfo" style="width:400px; height:200px;font-size:20px; color:#F00" disabled="disabled">${resultinfo}</textarea>
				<input type="hidden" id="flag" value="${flag}">
				<input type="hidden" id="error" value="${error}">
				<input type="hidden" id="wrong" value="${wrong}">
				<input type="hidden" id="file" value="${file}">
			</div>
			<input type="submit" name="submit" value="校验导入数据" style=" font-size:16px; width:140px; height:30px;"/>
			<input type="button" value="申请开票" onclick="insertPay();" id="yes" style=" font-size:16px; margin-left:20px; width:125px; height:30px;">
		</form>
		
	</div>
	 <script >
		 function insertPay(){
			var error =$("#error").val();
			var wrong =$("#wrong").val();
			var file =$("#file").val();
			if(error||wrong){
				alert("导入文件异常，请修改后重新导入！");
				aoRefresh();
			}else{
				$.ajax({
						url: "${ctx}/FapiaoDataImp/fapiaoDataSubmit.htm",
					 	type: "POST",
					 	async:false,
						dataType:"JSON",
						data:{fileName:file},
						success:function(data){
							if(data == "success"){
								alert("导入成功");
								aoRefresh();
							}
						}
					});
			}
		}
	
		function aoRefresh(){		
			setTimeout(
				function(){
					//刷新报表
					parent.refreshComponentDisplay("FapiaoDataImport","report1",false);
					art.dialog.close();
				},1*1000);
		 }
	 </script>
</body>
</html>
