<%-- 페이지의 콘텐츠 타입을 HTML로 설정하고 문자 인코딩을 UTF-8로 지정 --%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%-- color.jsp 파일을 포함하여 변수나 설정을 가져옴 --%>
<%@include file="color.jsp" %>

<%-- HTML 문서의 시작 --%>
<html>
<%-- HTML 문서의 head 영역 시작 --%>
<head>
<%-- 웹 페이지의 문자 인코딩을 UTF-8로 설정 --%>
<meta charset="UTF-8">
<%-- 페이지 제목을 "Namecard"로 설정 --%>
<title>Namecard</title>
<%-- 뷰포트를 설정하여 화면의 크기 및 초기 확대 비율 지정 --%>
<meta name="viewport" content="width=device-width, initial-scale=0.47">
<%-- 외부 CSS 파일(style.css)을 링크하여 스타일을 적용 --%>
<link href="style.css?d" rel="stylesheet" type="text/css">
<%-- 외부 JavaScript 파일(script.js)을 포함 --%>
<script language="JavaScript" src="script.js"></script>
<%-- HTML 문서의 head 영역 끝 --%>
</head>

<%-- HTML 문서의 body 영역 시작 --%>
<%-- 배경 이미지를 설정하고 크기를 맞춤 --%>
<body style="background-image: url('image/bg_1.svg'); background-size: cover; background-repeat: no-repeat;">
<%-- 폼을 감싸는 div 요소 시작 --%>
<div id="div_form">
<%-- 폼 시작: POST 방식으로 NamecardPro.jsp로 전송, 제출 전 inputCheck 함수 실행 --%>
  <form name="NamecardForm" method="post" action="NamecardPro.jsp" onsubmit="return inputCheck()"> 
  <%-- 테이블 시작: 너비 500, 테두리 없음, 셀 간격 및 여백 설정 --%>
    <table width="500" border="0" cellspacing="0" cellpadding="2"  align="center" id="table_1">
    <%-- 첫 번째 행 시작: 높이 39, 중앙 정렬 --%>
      <tr height="39" align="center"> 
      <%-- 3개의 열을 병합하여 제목을 표시 --%>
         <td colspan="3" style="font-family: Arial, sans-serif; font-size:20px;"><b>명함 등록</b></td>
      </tr>
      <%-- 두 번째 행 시작 --%>
      <tr id="tr_form"> 
      <%-- 첫 번째 열: "이름" 레이블 --%>
        <td width="100" id="td_1_form">이름</td>
        <td width="200"> 
        <%-- 두 번째 열: 이름 입력 필드 --%>
		  <input type="text" name="name" size="20"> </td>
		  <%-- 세 번째 열: 입력 안내 메시지 --%>
        <td width="200" id="td_1_form">이름을 입력하세요.</td>
      </tr>
      <%-- 세 번째 행 시작 --%>
      <tr id="tr_form"> 
      <%-- 첫 번째 열: "소속" 레이블 --%>
        <td width="100" id="td_1_form">소속</td> 
        <td width="200">
        <%-- 두 번째 열: 소속 입력 필드 --%>
	      <input type="text" name="major" size="30"> </td>
	      <%-- 세 번째 열: 입력 안내 메시지와 "학과" 강조 --%>
      <td width="200" id="td_1_form">소속을 입력하세요.<small style="color:<%=point_c%>;">(학과)</small></td>
      </tr>
      <%-- 네 번째 행 시작 --%>
      <tr id="tr_form">
      <%-- 첫 번째 열: "직책" 레이블 --%>
        <td width="100" id="td_1_form">직책</td>
        <td width="200"> 
        <%-- 두 번째 열: 직책 입력 필드 --%>
		  <input type="text" name="position" size="20"> </td>
		  <%-- 세 번째 열: 입력 안내 메시지 --%>
        <td width="200" id="td_1_form"">직책을 입력하세요.</td>
      </tr>
      <%-- 다섯 번째 행 시작 --%>
      <tr id="tr_form">
       <%-- 첫 번째 열: "연락처" 레이블 --%>  
        <td width="100" id="td_1_form">연락처</td>
        <td width="200"> 
        <%-- 두 번째 열: 연락처 입력 필드 --%>
		  <input type="text" name="tel" size="20"> </td>
		  <%-- 세 번째 열: 입력 안내 메시지 --%>
        <td width="200" id="td_1_form">연락처를 입력하세요.</td>
      </tr>
      <%-- 여섯 번째 행 시작 --%>
      <tr id="tr_form"> 
      <%-- 첫 번째 열: "이메일" 레이블 --%>
         <td width="100" id="td_1_form"">이메일</td>
         <td width="200"> 
         <%-- 두 번째 열: 이메일 입력 필드 --%>
		   <input type="text" name="email" size="30"> </td>
		   <%-- 세 번째 열: 입력 안내 메시지 --%>
         <td width="200"id="td_1_form">이메일을 입력하세요.</td>
      </tr>
      <%-- 일곱 번째 행 시작 --%>
      <tr id="tr_form">  
      <%-- 첫 번째 열: "주소" 레이블 --%>
         <td width="100" id="td_1_form">주소</td>
         <td width="200"> 
         <%-- 두 번째 열: 주소 입력 필드 --%>
		   <input type="text" name="address" size="20"> </td>
		   <%-- 세 번째 열: 입력 안내 메시지 --%>
         <td width="200" id="td_1_form">주소를 입력하세요.</td>
      </tr>
      <%-- 여덟 번째 행 시작 --%>
      <tr id="tr_form"> 
      <%-- 3개의 열을 병합하여 중앙 정렬 --%>
         <td colspan="3" align="center"> 
         <%-- 제출 버튼, 클릭 시 showSuccessMessage() 실행 --%>
           <input type="submit" value="명함등록" onclick="showSuccessMessage();"> 
           <%-- 버튼 간 공백 삽입 --%>
              &nbsp; &nbsp; &nbsp; &nbsp;
              <%-- 입력 초기화 버튼 --%>
           <input type="reset" value="다시작성"> 
           <%-- 버튼 간 공백 삽입 --%>
           	&nbsp; &nbsp; &nbsp; &nbsp;
              <%-- 명함 조회 버튼, 클릭 시 NamecardCheck.jsp로 이동 --%>
           <input type="button" value="명함조회" onclick="location.href = 'NamecardCheck.jsp'"> 
         </td>
       </tr>
  <%-- 테이블 끝 --%>
  </table>
  <%-- 명함 등록 성공 메시지를 표시하는 함수 정의 --%>
  <script>
   function showSuccessMessage() {
       alert('명함이 성공적으로 생성되었습니다!'); }
    </script>
  <%-- 폼 끝 --%>
  </form>
 </div>
 <%-- HTML 문서의 body 영역 끝 --%>
</body>
<%-- HTML 문서 끝 --%>
</html>
