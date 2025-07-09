<%-- JSP 페이지 설정: 언어는 Java, 출력 콘텐츠는 HTML, 문자 인코딩은 UTF-8로 설정 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%-- java.sql 패키지를 포함하여 데이터베이스 연결 및 쿼리 실행에 필요한 클래스를 가져옴 --%>
<%@ page import="java.sql.*"%>
<%-- 외부 JSP 파일을 포함하여 공통적으로 사용되는 코드를 재사용 (color.jsp 파일 포함) --%>
<%@include file="color.jsp" %>

<!DOCTYPE html>
<%-- HTML5 문서의 시작 --%>
<html>
<head>
 <%-- HTML 문서의 문자 인코딩을 UTF-8로 설정 --%>
 <meta charset="UTF-8">
 <%-- 뷰포트 설정: 화면 크기와 초기 확대 비율 지정 --%>
 <meta name="viewport" content="width=device-width, initial-scale=0.47">
 <%-- 웹 페이지 제목 설정 --%>
 <title>NamecardCheck</title>
 <%-- 외부 CSS 파일을 링크하여 스타일 지정 --%>
 <link href="style.css?e" rel="stylesheet" type="text/css">
 <%-- 외부 JavaScript 파일을 포함하여 동작 구현 --%>
 <script language="JavaScript" src="script.js"></script>
</head>

<body style="background-image: url('image/bg_3.svg'); background-size: cover; background-repeat: no-repeat;">
<%-- 명함 조회 폼을 감싸는 컨테이너 --%>
 <div id="div_form">
 <%-- 명함 조회 폼 시작 --%>
  <form name="NamecardCheck" method="post" action="NamecardProc.jsp" onsubmit="return checkSearchInput();">
	<%-- 테이블로 구성된 명함 조회 결과 출력 --%>
	<table width="500" border="0" cellspacing="0" cellpadding="2"  align="center" id="table_1"><tr>
	<%-- 테이블 헤더 행 시작 --%>
	<tr height="39" align="center"> 
      <%-- 제목을 표시하는 셀, 6개의 열을 병합 --%>
         <td colspan="6" style="font-family: Arial, sans-serif; font-size:20px;"><b>명함 조회</b></td>
         </tr>
         <%-- 테이블 열 제목 --%>
		<tr align="center" id="tr_form">
		<td><b> 이름 </b></td> <%-- 열 제목: 이름 --%>
		<td><b> 소속</b></td> <%-- 열 제목: 소속 --%>
		<td><b> 직책 </b></td> <%-- 열 제목: 직책 --%>
		<td><b> 연락처 </b></td> <%-- 열 제목: 연락처 --%>
		<td><b> 이메일 </b></td> <%-- 열 제목: 이메일 --%>
		<td><b> 주소</b></td> <%-- 열 제목: 주소 --%>
		</tr>

		<%-- 데이터베이스 연결 및 조회 처리 --%>
		<%
		Connection conn = null; // 데이터베이스 연결을 관리하는 Connection 객체
		PreparedStatement pstmt = null; // SQL 실행을 위한 PreparedStatement 객체
		ResultSet rs = null; // 쿼리 실행 결과를 저장하는 ResultSet 객체
		
		//데이터베이스 연결 및 데이터 삽입 작업
		try {
		// JDBC URL, 데이터베이스 사용자 ID, 비밀번호 설정
		String jdbcUrl = "jdbc:mysql://localhost:3306/basicjsp?serverTimezone=Asia/Seoul"; // 데이터베이스 경로
		String dbId = "jspid"; // 데이터베이스 접속 ID
		String dbPass = "jsppass"; // 데이터베이스 접속 비밀번호
		
		// JDBC 드라이버 로드: MySQL 드라이버를 메모리에 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);//DriverManager를 사용하여 DB에 연결
		
		// SQL 쿼리 실행
		String sql = "select * from memberTBL";//실행할 SQL 쿼리 작성, memberTBL에서 모든 열을 선택함
		pstmt = conn.prepareStatement(sql);//SQL 쿼리를 실행할  PreparedStatement를 생성
		rs = pstmt.executeQuery();//SQL 쿼리를 실행하고 결과를 저장함
		
		// 조회된 결과를 출력
		boolean hasRecords = false; // 결과가 하나 이상 있는지 여부를 나타내는 플래그
		
		//다음 레코드로 이동하여 레코드가 있을시 hasRecords를 true로 설정, 각 필드의 값을 변수에 저장한다.
		while (rs.next()) {
		hasRecords = true; //결과 존재 플래그 설정
		String name = rs.getString("name"); // 이름 데이터 가져오기
		String major = rs.getString("major"); // 소속 데이터 가져오기
		String position = rs.getString("position"); // 직책 데이터 가져오기
		String tel = rs.getString("tel"); // 연락처 데이터 가져오기
		String email = rs.getString("email"); // 이메일 데이터 가져오기
		String address = rs.getString("address"); %> <!-- 주소 데이터 가져오기 -->

	<%-- 조회된 결과를 테이블에 출력 --%>
	<tr align="center" id="tr_form">
	<td width="10%"><%=name%></td> <%-- 이름 표시 --%>
	<td width="20%"><%=major%></td> <%-- 소속 표시 --%>
	<td width="10%"><%=position%></td> <%-- 직책 표시 --%>
	<td width="20%"><%=tel%></td> <%-- 연락처 표시 --%>
	<td width="20%"><%=email%></td> <%-- 이메일 표시 --%>
	<td width="20%"><%=address%></td> <%-- 주소 표시 --%>
	</tr>

	<%
	}
		// 조회된 결과가 없는 경우 출력
		if (!hasRecords) {
	%>

	<%-- 조회 가능한 명함이 없을 때 표시할 내용 --%>
	<tr>
	<%-- 조회 결과 없음 표시 --%>
	<td colspan="7" style="text-align: center; vertical-align: middle; font-size: 24px;">조회 가능한 명함이 없습니다.</td>
	</tr>
	
	<% //예외 처리 및 리소스 해제하기
		}
		 } catch (Exception e) {
		// 예외 출력
		e.printStackTrace();
		} finally {
		// 자원 해제
		if (rs != null)
		try {
		rs.close();
		} catch (SQLException sqle) {
		}
		// 결과 집합 닫기
		if (pstmt != null)
		try {
		pstmt.close();
		} catch (SQLException sqle) {
		}
		// SQL 실행 객체 닫기
		if (conn != null)
		try {
		conn.close();
		} catch (SQLException sqle) {
		}// 연결 닫기
		}
	%>
	</table>
	<div id="div_check">
	<%-- 검색 폼 영역 --%>
	<table align="center">
	<%-- 검색 및 뒤로가기 버튼 포함 --%>
		<tr>
		<%-- 검색 입력 필드 --%>
		<td><input class="serch" type="text" name="searchNUM" size="40" placeholder="찾으실 명함의 전화번호를 입력해주세요."></td>
		<%-- 조회 버튼 --%>
		<td>&nbsp;&nbsp;<input class="sub" type="submit" value="조회하기"> &nbsp;&nbsp;</td>
		<%-- 뒤로가기 버튼 --%>
		<td><input class="button" type="button" value="뒤로가기" onclick="goBack()"></td>
		</tr>
	</table>
	</div>
	</form>
	</div>
	</body>
	</html>

	<script>
	<%-- 뒤로가기 함수 정의 --%>
	function goBack() {
	<%-- 브라우저의 히스토리에서 이전 페이지로 이동 --%>
	window.history.back();
	}
	<%-- 입력 값 유효성 검사 함수 --%>
	  function checkSearchInput() {
		  <%-- 전화번호 입력 필드 값 가져오기 --%>
	            var searchNUM = document.forms["SelectForm"]["searchNUM"].value.trim();
	
	        <%-- 입력값이 없는 경우 경고 메시지 출력 --%>
	        if (searchNUM === "") {
	            alert("찾을 명함의 전화번호를 입력해주세요.");
	            return false; <%-- 폼 전송 중단 --%>
	        }
	        <%-- 입력값이 있으면 폼 전송 허용 --%>
	        return true;
	        }
	</script>