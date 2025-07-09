<%-- 페이지의 콘텐츠 타입을 HTML로 설정하고 문자 인코딩을 UTF-8로 지정 --%>
<%@ page contentType="text/html; charset=utf-8" %>

<%-- 요청(request) 데이터를 UTF-8로 인코딩하여 한글이 제대로 처리되도록 설정 --%>
<% 
  request.setCharacterEncoding("utf-8");
%>

<!--JDBC를 사용하기 위한 선언-->
<%@ page import="java.sql.*, java.sql.SQLException, java.sql.DriverManager"%>

<%-- HTML 문서의 시작 --%>
<html>
<%-- HTML 문서의 head 영역 시작 --%>
<head>
<%-- 웹 페이지의 문자 인코딩을 UTF-8로 설정 --%>
<meta charset="UTF-8">
<%-- 뷰포트를 설정하여 화면의 크기 및 초기 확대 비율 지정 --%>
<meta name="viewport" content="width=device-width, initial-scale=0.47">
<%-- 페이지 제목을 "success"로 설정 --%>
<title>success</title>
<%-- 외부 CSS 파일(style.css)을 링크하여 스타일을 적용 --%>
<link href="style.css?e" rel="stylesheet" type="text/css">
<%-- 외부 JavaScript 파일(script.js)을 포함 --%>
<script language="JavaScript" src="script.js"></script>
<%-- HTML 문서의 head 영역 끝 --%>
</head>

<%-- JSP 스크립틀릿: 데이터베이스 연결 및 조회 수행 --%>
<%
// 데이터베이스 연결을 위한 변수 선언
Connection conn = null;
PreparedStatement pstmt = null;	// SQL 실행을 위한 변수
ResultSet rs = null;			// 쿼리 결과를 저장할 변수

// 사용자로부터 전달된 전화번호를 사용하여 정보를 조회
String searchNUM = request.getParameter("searchNUM");

//데이터베이스에서 조회할 변수들 초기화
String name = "";
String major = "";
String position = "";
String tel = "";
String email = "";
String address = "";

// 데이터베이스 연결 정보 설정
try {
	// JDBC URL, 데이터베이스 사용자 아이디, 비밀번호 설정
	String jdbcUrl = "jdbc:mysql://localhost:3306/basicjsp?serverTimezone=Asia/Seoul"; // 데이터베이스 경로
	String dbId = "jspid"; // 데이터베이스 접속 ID
	String dbPass = "jsppass"; // 데이터베이스 접속 비밀번호
	
	// JDBC 드라이버 로드하기, MySQL 데이터베이스에 연결할 때 필요한 드라이버 연결하기
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);	// DriverManager를 사용하여 DB에 연결

	String sql = "select * from memberTBL where tel=?";			// 실행할 SQL 쿼리 작성, tel이 일치하는 레코드를 선택함
	pstmt = conn.prepareStatement(sql);		// SQL 쿼리를 실행할  PreparedStatement를 생성
	pstmt.setString(1, searchNUM);			// SQL 쿼리의 매개변수에 값 설정, 인덱스1인 매개변수에 num 값 설정
	rs = pstmt.executeQuery();				// SQL 쿼리를 실행하고 결과를 저장함

	boolean hasRecords = false;		//조회된 결과가 있는지 확인하기

	// 쿼리 결과가 있다면 데이터를 변수에 저장
	while (rs.next()) {
		hasRecords = true;
		name = rs.getString("name");
		major = rs.getString("major");
		position = rs.getString("position");
		tel = rs.getString("tel");
		email = rs.getString("email");
		address = rs.getString("address");
%>
<%-- 데이터 조회가 완료된 후 출력할 부분을 JSP 코드로 작성 --%>
<%
//while문 끝
} //조회된 결과가 없는 경우
if (!hasRecords) {
%>
<%-- 데이터가 존재하지 않을 때 출력할 메시지 --%>
<%
} //예외 처리 및 리소스 해제하기
} catch (Exception e) {
e.printStackTrace(); // 예외가 발생하면 스택 트레이스를 출력
} finally {
	// 자원 해제: ResultSet, PreparedStatement, Connection 순으로 닫기
if (rs != null)
try {
	rs.close();
} catch (SQLException sqle) {
}
if (pstmt != null)
try {
	pstmt.close();
} catch (SQLException sqle) {
}
if (conn != null)
try {
	conn.close();
} catch (SQLException sqle) {
}
}
%>

<%-- 배경 이미지를 설정하고 크기를 맞춤 --%>
<body style="background-image: url('image/bg_2.svg'); background-size: cover; background-repeat: no-repeat;">
<%-- 결과를 표시하는 div 요소 시작 --%>
    <div id="div_proc">
    <%-- 테이블 시작: 너비 370, 테두리 없음, 셀 간격 및 여백 설정 --%>
    <table width="370" border="0" cellspacing="0" cellpadding="2"  align="center">
    <%-- 첫 번째 행 시작: 높이 39, 왼쪽 정렬 --%>
      <tr height="39" align="left"> 
      <%-- 2개의 열을 병합하여 "KYUNGSUNG UNIVERESITY" 텍스트를 굵게 표시 --%>
        <td colspan="2" style="font-size:15px;"><b>KYUNGSUNG UNIVERESITY</b></td>
      </tr>
      <tr> 
        <td colspan="2" width="370" style="font-size:13px;">
		  <%=name%></td> <%-- 이름 출력 --%>
      </tr>
      <tr>
		<td colspan="2" width="370">
		<%=major%><b> | </b><%=position%></td> <%-- 소속과 직책 출력 --%>
      </tr>
      <tr> 
      <%-- "M" 레이블을 굵게 표시 --%>
        <td width="20"><b>M</b></td>
        <td width="360"> 
		  <a href="tel:<%=tel%>" target="_blank"><%=tel%></a></td> <%-- 전화번호 출력 (전화 걸기 링크) --%>
      </tr>
      <tr> 
      <%-- "E" 레이블을 굵게 표시 --%>
        <td width="20"><b>E</b></td>
        <td width="360"> 
        <a href="mailto:<%=email%>"><%=email%></a></td> <%-- 이메일 출력 (메일 보내기 링크) --%>
      </tr>
      <tr> 
      <%-- "A" 레이블을 굵게 표시 --%>
        <td width="20"><b>A</b></td>
        <td width="360">
        <a href="http://maps.google.com/maps?q=<%=address%>"><%=address%></a></td> <%-- 주소 출력 (구글 맵 링크) --%>
      </tr>
  <!-- 테이블 끝 -->    
  </table>
  <%-- 버튼 생성: 뒤로 가기 버튼 --%>
<div id="button-container">
<input type="button" value="뒤로가기" onclick="goBack()"></div>
<%-- 뒤로 가기 버튼 동작 정의 --%>
 
<script>
		function goBack() {
			window.history.back();
		}
	</script>
  <%-- 결과를 출력하는 div 끝 --%>
  </div>
</body>
<!-- HTML 문서 끝 -->
</html>
