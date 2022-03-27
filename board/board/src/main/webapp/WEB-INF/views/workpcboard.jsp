<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/style.css" />
<link rel="stylesheet" type="text/css" href="/css/main.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<meta charset="EUC-KR">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>업무용 PC 리스트</title>
<script  type="text/javascript">

$(document).ready(function(){
	$("#location2, #location1").click(function(){
		$.ajax({
			url: "/location3",	
		    type: "POST",
		    cache:false,
		    async:true, 
		    data:{"location" : $(this).attr('value')},
		    dataType:"json",
		    success: function(list) {
		    	console.log(list);
		    	resultHtml(list);
			},
		})
	})
	
	$("#serbtn").click(function(){
		searching();
	})
	
	$("#searchText").keypress(function(e){
		if(e.keyCode == 13){
			searching();
			return false;
		}
	})		
		
	function searching(){
		var searchid = document.getElementById('searchField').value;
		var searchtxt = document.getElementById('searchText').value;
		console.log(searchid);
		console.log(searchtxt);
		$.ajax({
			url: "/searchlist2",
		    type: "POST",
		    cache:false,
		    async:true, 
		    data:{ searchid : searchid,
		    	  searchtxt : searchtxt},
		    dataType:"json",
		    success: function(list) {
		    	console.log(list);
		    	resultHtml(list);
			},
			beforeSend:function(){
				if(document.getElementById('searchText').value == ""){
					alert("검색어를 입력해 주세요.");
					focus(document.getElementById('searchText').value);
					xhr.abort();
				}
				if(document.getElementById('searchField').value == "0"){
					alert("검색할 컬럼을 선택해주세요.");
					xhr.abort();
				}
			}
		})
	}
	
	

	

});

function pagelist(num){
	var location = document.getElementById('location').value
	console.log(location);
	console.log(num);
	$.ajax({
		url: "/pagelist2",
	    type: "POST",
	    cache:false,
	    async:true, 
	    data:{ "location" :location,
	    	  "page" : num},
	    dataType:"json",
	    success: function(list) {
	    	console.log(list);
	    	resultHtml(list);
		},

	})
}


function resultHtml(list){
	var html = "<table class='datatable'>";
	html += "<thead>";
	html += "<tr>";
	html += "<th align='center' scope='col'>No</th>";
	html += "<th align='center' scope='col'>위치 구분</th>";
	html += "<th align='center' scope='col'>세부위치</th>";
	html += "<th align='center' scope='col'>부서</th>";
	html += "<th align='center' scope='col'>직급</th>";
	html += "<th align='center' scope='col'>사용자</th>";
	html += "<tr>";
	html += "</thead>";
	html += "<tbody>";
	
	
	
	if(list.length>1){
		for(var key=0; key<list.length-1; key++){
			html += "<tr align='center' onClick='location=`/detail?seq=" + list[key].SEQ +"`;' style='cursor:pointer;'>"
			if(list[key].SEQ != null){
				html += "<td>" +list[key].SEQ+ "</td>";
			}
			if(list[key].LOCATION_DIVISION == null){
				html += "<td> - </td>" ;
			}else{
				html += "<td>" +list[key].LOCATION_DIVISION+ "</td>";
			}
			
			if(list[key].LOCATION_DETAIL == null){
				html += "<td> - </td>" ;
			}else{
				html += "<td>" +list[key].LOCATION_DETAIL+ "</td>";
			}
			
			//html += "<td> <a href='/detail?seq=" + list[key].SEQ+"'>";
			//html += list[key].SERVER_DETAIL;
			
			//html += "</a>";
			//html += "</td>";
			
			if(list[key].DEPARTMENT == null){
				html += "<td> - </td>" ;
			}else{
				html += "<td>" +list[key].DEPARTMENT+ "</td>";
			}
			
			if(list[key].POSITION == null){
				html += "<td> - </td>" ;
			}else{
				html += "<td>" +list[key].POSITION+ "</td>";
			}

			if(list[key].EMPLOYEE == null){
				html += "<td> - </td>" ;
			}else{
				html += "<td>" +list[key].EMPLOYEE+ "</td>";
			}
			
			html += "</tr>";
		}	
	}else {
		html += "<tr><td align='center' colspan='20'>조회된 내역이 없습니다.</td></tr>";
	}
	html += "</table>";
	html += "<br>"
	html += "<br>"
	html += "<center>";
	for(var i = list[list.length-1].startpage; i<=list[list.length-1].endpage;i++ ){
			html += "<a href='javascript:pagelist(" + i + ")' id ='pagenum' >" + i + "</a>&nbsp;";
			html += "<div style='display:none'><input type='text' id ='location' name='location' value='" + list[0].LOCATION + "'/></div>";
	}

	html += "</center>";
	html += "</tbody>";
	
	
	$("#display").empty();
	$("#display").append(html);
}

</script>
<style>
li{float : left;}
li a {text-align : center; padding : 8px 10px;  }
li a.current{font-weight : bold; border-bottom: 2px solid #23262d;}

</style>
</head>

<body>
<div style="padding:15px; ">
	<ul class="l_menu">
		<li><a href="/board">서버 현황 </a></li>
		<li><a class="current" href="/workpcboard">업무용 PC</a></li>
	</ul>
</div>

	<div id="wrap" style="width:1000px; padding:50px;">
		<h4>위치 선택</h4>
		<div style="padding:10px;"> 
		<button type="button" id="location1" value="location1" > 본사 </button>
		&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" id="location2" value="location2"> 석포 </button> 
		<br>
		<br>
		</div>
		<form id = "search" method="post" >
		<h4>검색</h4>
		<table id="searchtable" class="datatable">
			<tr>
			<td><select class="selectfield" id="searchField">
			<option value="0">선택</option>
			<option value="LOCATION_DIVISION">위치 구분</option>
			<option value="DEPARTMENT">부서</option>
			<option value="POSITION">직급</option>
			<option value="EMPLOYEE">사용자</option>
			</select></td>
			<td>
			<input type="text" name="searchText" id ="searchText"/> 
			&nbsp;&nbsp;&nbsp;<button type="button" id="serbtn" value="serbtn">검색</button>
			</td>
			</tr>
		</table>
		</form>
		<br>
		
		<br>
		<br>
		
		<h4>업무용 PC 리스트</h4>
		<br>
		<div id = "display">
		<table class="datatable">
			<thead>
				<tr>
					<th align="center" scope="col">No</th>
					<th align="center" scope="col">위치 구분</th>
					<th align="center" scope="col">세부위치</th>
					<th align="center" scope="col">부서</th>
					<th align="center" scope="col">직급</th>
					<th align="center" scope="col">사용자</th>
				</tr>
			</thead>
			<tbody>
		<c:if test="${fn:length(list) > 0}">

		<c:forEach var="list" items="${list}" varStatus="i" end="${fn:length(list)-1}">
		<c:if test="${list.SEQ ne null}">
		<tr align="center" onClick="location='/detailpc?seq=${list.SEQ}';" style="cursor:pointer;">		
		</c:if>
		<c:if test="${list.SEQ eq null}">
			<tr style="display:none;">	
		</c:if>
				<td align="center">${list.SEQ}</td>
				
				<c:if test="${list.LOCATION_DIVISION eq null}">
				<td align="center"> - </td>
				</c:if>
				<c:if test="${list.LOCATION_DIVISION ne null}">
				<td align="center">${list.LOCATION_DIVISION}</td>
				</c:if>
				
				<c:if test="${list.LOCATION_DETAIL eq null}">
				<td align="center"> - </td>
				</c:if>
				<c:if test="${list.LOCATION_DETAIL ne null}">
				<td align="center">${list.LOCATION_DETAIL}</td>
				</c:if>
				
				<c:if test="${list.DEPARTMENT eq null}">
				<td align="center"> - </td>
				</c:if>
				<c:if test="${list.DEPARTMENT ne null}">
				<td align="center">${list.DEPARTMENT}</td>
				</c:if>
				
				<c:if test="${list.POSITION eq null}">
				<td align="center"> - </td>
				</c:if>
				<c:if test="${list.POSITION ne null}">
				<td align="center">${list.POSITION}</td>
				</c:if>

				<c:if test="${list.EMPLOYEE eq null}">
				<td align="center"> - </td>
				</c:if>
				<c:if test="${list.EMPLOYEE ne null}">
				<td align="center">${list.EMPLOYEE}</td>
				</c:if>
				
		</tr>
		
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(list) == 0}">
			<tr><td align="center" colspan="20">조회된 내역이 없습니다.</td></tr>
		</c:if>
		
			</tbody>
		</table>
		
		<br>
		<br>
		<center>
		<c:forEach var="i" begin="${list[fn:length(list)-1].startpage}" end="${list[fn:length(list)-1].endpage}">
			<a href="javascript:pagelist(${i})" id ="pagenum" > ${i} </a>&nbsp;
			<div style="display:none"><input type="text" id ="location" name="location" value="${list[0].LOCATION}"/></div>
		</c:forEach>
		</center>
	</div>
	
		<div style="padding:10px;">
			<button type="button" id="write" onclick="location.href='writeworkpc'">추가하기</button>
		</div>
</body>
</html>