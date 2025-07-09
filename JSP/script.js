function inputCheck(){
	// "NamecardForm"이라는 이름을 가진 폼 요소를 가져옴
	var userinput = eval("document.NamecardForm");
	
	// "name" 필드 값이 비어있는지 확인
	if(userinput.name.value==""){
		alert("이름을 입력하세요."); // 값이 비어있으면 경고 메시지 출력
		userinput.name.focus(); // "name" 필드로 포커스 이동
		return false; // 폼 제출을 중단하고 함수 종료
	}
	// "major" 필드 값이 비어있는지 확인
	if(userinput.major.value==""){
		alert("소속을 입력하세요."); // 값이 비어있으면 경고 메시지 출력
		userinput.major.focus(); // "major" 필드로 포커스 이동
		return false; // 폼 제출을 중단하고 함수 종료
	}
	// "position" 필드 값이 비어있는지 확인
	if(userinput.position.value==""){
		alert("직책을 입력하세요."); // 값이 비어있으면 경고 메시지 출력
		userinput.position.focus(); // "position" 필드로 포커스 이동
		return false; // 폼 제출을 중단하고 함수 종료
	}
	 // "tel" 필드 값이 비어있는지 확인
	if(userinput.tel.value==""){
		alert("연락처를 입력하세요."); // 값이 비어있으면 경고 메시지 출력	
		userinput.tel.focus();  // "tel" 필드로 포커스 이동
		return false; // 폼 제출을 중단하고 함수 종료
	}
	// "email" 필드 값이 비어있는지 확인
	if(userinput.email.value==""){
		alert("이메일을 입력하세요."); // 값이 비어있으면 경고 메시지 출력
		userinput.email.focus(); // "email" 필드로 포커스 이동
		return false; // 폼 제출을 중단하고 함수 종료
	}
	// "address" 필드 값이 비어있는지 확인
	if(userinput.address.value==""){
		alert("주소를 입력해 주세요"); // 값이 비어있으면 경고 메시지 출력
		userinput.address.focus(); // "address" 필드로 포커스 이동
		return false; // 폼 제출을 중단하고 함수 종료
	}
}