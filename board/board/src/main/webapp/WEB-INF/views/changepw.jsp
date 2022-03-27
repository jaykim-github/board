<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<head>
<meta charset="EUC-KR">
<title>���ο� ��й�ȣ �Է�</title>

<script type="text/javascript">
console.log(localStorage.getItem("ID"));
$(document).ready(function(){
	$("#changepw").click(function(){
		$.ajax({
		    url: "/changepwinput",
		    type: "POST",
		    cache:false,
		    async:true, 
		    data:{"id" :localStorage.getItem("ID"),
		    	"password" : document.changefrm.password.value},
		    dataType:"json",
		    success: function(result) {
		    	if(result.value == 1){
		    		alert("����Ǿ����ϴ�.");
					location.replace("/");
		    	}else if(result.value == 2){
		    		alert("������ ����ϴ� ��й�ȣ �Դϴ�. �ٸ� ��й�ȣ�� �Է����ּ���.");
					return false;
		    	}else {
		    		alert("���濡 �����Ͽ����ϴ�. �����ڿ��� �����Ͽ��ּ���.");
					return false;
		    	}
		    	
			},
			beforeSend:function(){
				if(document.changefrm.password.value == ""){
					alert("��й�ȣ�� �Է��� �ּ���.");
					document.changefrm.password.value.focus();
					xhr.abort();
				}else if(document.changefrm.password2.value == ""){
					alert("��й�ȣ�� �ٽ� �Է��� �ּ���.");
					document.changefrm.password2.value;
					xhr.abort();
				}else if(document.changefrm.password.value != document.changefrm.password2.value){
					alert("������ ��й�ȣ��  �Է��� �ּ���.");
					document.changefrm.password2.value;
					xhr.abort();
				}
			},
		    
	 	});
	});

	
});

</script>
</head>
<body>
<h2>��й�ȣ ã��</h2>
	 <form id = "changefrm" name ="changefrm">
	 	<br>
 		��й�ȣ : <input type="text" name="password" id ="password"/>
		<br>
              ��й�ȣ Ȯ�� : <input type="text" name="password2" id ="password2"/>
        <br>
	</form>
	<br>
	<button type="button" class="changepwclass" value="changepw" id="changepw">��й�ȣ ����</button> 
    <br>

</body>
</html>