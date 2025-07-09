<%-- JSP 페이지의 설정: 언어는 Java, 콘텐츠 타입은 HTML, 문자 인코딩은 UTF-8로 설정 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- java.sql 패키지를 가져와 데이터베이스 관련 클래스와 인터페이스를 사용 가능하게 함 --%>
<%@ page import="java.sql.*"%>
<% 
  //클라이언트로부터 전달된 요청(request)의 문자 인코딩을 UTF-8로 설정하여 한글 처리를 지원
  request.setCharacterEncoding("utf-8");
%>

<% 
  //요청(request) 객체에서 전달된 폼 데이터의 파라미터를 가져와 변수에 저장
  String name = request.getParameter("name"); // 사용자의 이름 입력값
  String major = request.getParameter("major"); // 사용자의 소속(학과) 입력값
  String position = request.getParameter("position"); // 사용자의 직책 입력값
  String tel = request.getParameter("tel"); // 사용자의 연락처 입력값
  String email = request.getParameter("email"); // 사용자의 이메일 입력값
  String address = request.getParameter("address"); // 사용자의 주소 입력값
  
//데이터베이스 연결 및 SQL 실행에 필요한 객체 변수 선언
Connection conn = null; // 데이터베이스 연결을 관리하는 Connection 객체
PreparedStatement pstmt = null; // SQL 실행을 위한 PreparedStatement 객체
String str = ""; // SQL 실행 결과를 저장할 문자열 변수

//데이터베이스 연결 및 데이터 삽입 작업
try {
	// JDBC URL, 사용자 ID, 비밀번호 정의
	String jdbcUrl = "jdbc:mysql://localhost:3306/basicjsp?serverTimezone=Asia/Seoul"; // 데이터베이스 경로
	String dbId = "jspid"; // 데이터베이스 접속 ID
	String dbPass = "jsppass"; // 데이터베이스 접속 비밀번호
	
	// JDBC 드라이버 로드: MySQL 드라이버를 메모리에 로드하여 사용 가능하게 만듦
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	// 데이터베이스 연결을 생성하여 Connection 객체에 저장
	conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
	
	// 데이터 삽입을 위한 SQL 쿼리 작성 (memberTBL 테이블에 값 삽입)
	String sql = "insert into memberTBL values (?,?,?,?,?,?)";
	
	// PreparedStatement 객체 생성 및 쿼리에 파라미터 값 설정
	pstmt = conn.prepareStatement(sql); // SQL 문장을 준비
	pstmt.setString(1, name); // 1번 물음표에 name 값을 설정
	pstmt.setString(2, major); // 2번 물음표에 major 값을 설정
	pstmt.setString(3, position); // 3번 물음표에 position 값을 설정
	pstmt.setString(4, tel); // 4번 물음표에 tel 값을 설정
	pstmt.setString(5, email); // 5번 물음표에 email 값을 설정
	pstmt.setString(6, address); // 6번 물음표에 address 값을 설정
	pstmt.executeUpdate(); // SQL 쿼리를 실행하여 데이터를 데이터베이스에 삽입

	//예외 처리 및 리소스 해제하기
	} catch (Exception e) {
		// 예외 발생 시 오류 메시지를 콘솔에 출력
	  e.printStackTrace(); // 예외 발생 시 스택 트레이스를 출력하여 디버깅에 도움
	} finally { // PreparedStatement, Connection 등의 자원을 안전하게 해제하기 위한 부분
		if (pstmt != null) // PreparedStatement가 null이 아니라면
			try {
				pstmt.close(); // PreparedStatement 자원 해제
		} catch (SQLException sqle) { 
			sqle.printStackTrace(); // 예외 발생 시 오류 메시지 출력
		} 
	
		// Connection 객체를 닫아 자원을 해제
		if (conn != null) // Connection이 null이 아니라면
			try {
				conn.close(); // Connection 자원 해제 
			} catch (SQLException sqle) { 
			  sqle.printStackTrace(); // 예외 발생 시 오류 메시지 출력
			}
		}
%>

<%-- NamecardForm.jsp 페이지로 리다이렉트: 데이터 삽입 후 입력 폼 화면으로 이동 --%>
<%response.sendRedirect("NamecardForm.jsp");%>

<!DOCTYPE html>
<%-- HTML5 문서의 시작 --%>
<html>
<head>
<%-- 뷰포트 설정: 화면의 크기와 초기 확대 비율 지정 --%>
<meta name="viewport" content="width=1960, height=2796, initial-scale=0.5">
<%-- HTML 문서의 문자 인코딩을 UTF-8로 설정 --%>
<meta charset="UTF-8">
</head>
</html>
