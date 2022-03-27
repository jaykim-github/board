<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<head>
<link rel="stylesheet" type="text/css" href="/css/style.css" />
<link rel="stylesheet" type="text/css" href="/css/main.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<meta charset="EUC-KR">
<title>��й�ȣ ã��</title>

<script type="text/javascript">
$(document).ready(function(){
	$("#findinfo").click(function(){
		$.ajax({
		    url: "/findpwinput",
		    type: "POST",
		    cache:false,
		    async:true, 
		    data:$("#findfrm").serialize(),
		    dataType:"json",
		    success: function(result) {
		    	if(result.value == 1){
		    		localStorage.setItem("ID",document.findfrm.id.value);
					location.replace("/changepw");
		    	}else{
		    		alert("ID�� ��ȭ��ȣ�� Ȯ���� �ּ���.");
					document.findfrm.phonenumber.value;
					return false;
		    	}
		    	
			},
			beforeSend:function(){
			if(document.findfrm.id.value == ""){
					alert("ID�� �Է��� �ּ���.");
					document.findfrm.id.value.focus();
					xhr.abort();
				}else if(document.findfrm.phonenumber.value == ""){
					alert("��ȭ��ȣ�� �Է��� �ּ���.");
					document.findfrm.phonenumber.value;
					xhr.abort();
				}
			},
		    
	 	});
	});

	
});

</script>
</head>
<body>
<div id="wrap" style="width:500px; padding : 50px;">
<h2>��й�ȣ ã��</h2>
	 <form id = "findfrm" name ="findfrm">
	 <table class="datatable" style="width:200;">
	 <tr>
	 	<th>���̵� : </th>
	 	<td><input type="text" name="id" id ="id"/></td>
	 </tr>
	 <tr>
        <th>��ȭ��ȣ : </th>
        <td><input type="text" name="phonenumber" id ="phonenumber"/></td>
       </tr>
     </table>
	</form>
	<br>
	<div style="float:right">
	<button type="button" class="findpwclass" value="findinfo" id="findinfo">�˻�</button>
	</div>
	<br>
	<br>
	 <div style="float:right">
	<button type="button" class="registerclass" value="register" id="register" onclick="location.href='/register'">ȸ������</button> | <button type="button" onclick="location.href='/findid'">���̵� ã��</button> | <button type="button" onclick="location.href='/'">�ڷΰ���</button> 
    </div>
    <br>
</div>
</body>
</html>