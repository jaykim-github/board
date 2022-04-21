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
<title>비밀번호 찾기</title>

<script type="text/javascript">
$(document).ready(function(){
	$("#findinfo").click(function(){
		findpw();
	});
	$("#phonenumber,#id").keypress(function(e){
		if(e.keyCode == 13){
			findpw();
			return false;
		}
	})
	
});

function findpw(){
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
	    		alert("ID와 전화번호를 확인해 주세요.");
	    		$('#phonenumber').focus();
				return false;
	    	}
	    	
		},
		beforeSend:function(){
		if(document.findfrm.id.value == ""){
				alert("ID를 입력해 주세요.");
				$('#id').focus();
				return false;
			}else if(document.findfrm.phonenumber.value == ""){
				alert("전화번호를 입력해 주세요.");
				$('#phonenumber').focus();
				return false;
			}
		},
	    
 	});
}

</script>
</head>
<body>
<div id="wrap" style="width:500px; padding : 50px;">
<h2>비밀번호 찾기</h2>
	 <form id = "findfrm" name ="findfrm">
	 <table class="datatable" style="width:200;">
	 <tr>
	 	<th>아이디 : </th>
	 	<td><input type="text" name="id" id ="id"/></td>
	 </tr>
	 <tr>
        <th>전화번호 : </th>
        <td><input type="text" name="phonenumber" id ="phonenumber"/></td>
       </tr>
     </table>
	</form>
	<br>
	<div style="float:right">
	<button type="button" class="findpwclass" value="findinfo" id="findinfo">검색</button>
	</div>
	<br>
	<br>
	 <div style="float:right">
	<button type="button" class="registerclass" value="register" id="register" onclick="location.href='/register'">회원가입</button> | <button type="button" onclick="location.href='/findid'">아이디 찾기</button> | <button type="button" onclick="location.href='/'">뒤로가기</button> 
    </div>
    <br>
</div>
</body>
</html>