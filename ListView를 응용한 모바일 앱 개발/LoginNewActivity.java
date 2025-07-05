package com.example.finalproject;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;
// 회원가입을 선택하면 이동되는 액티비티로, 회원정보를 입력받아 DB에 저장하는 클래스
// (LoginActivity, DBLogin)
public class LoginNewActivity extends AppCompatActivity {
    EditText et1, et2;  // 사용자가 ID와 비밀번호를 입력하는 EditText 객체
    DBLogin Logindb;    // DBLogin 클래스의 인스턴스 (DB 관리)
    SQLiteDatabase sqldb;   // SQLite 데이터베이스 객체 (DB에 데이터를 쓸 때 사용)
    String sql; // SQL 쿼리 문자열 변수 (회원가입 정보를 DB에 삽입하는 데 사용)

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login_update);  // 레이아웃 설정

        et1 = findViewById(R.id.editTextNewID);  // ID 입력창 초기화
        et2 = findViewById(R.id.editTextNewPass);   // Password 입력창 초기화
        Logindb = new DBLogin(this);  // DBLogin 객체 생성
    }

    public void onButtonNew1(View view) {  // 회원가입 버튼 클릭 시
        // 사용자가 입력한 ID와 Password 값을 가져오기
        String enteredID = et1.getText().toString();        // 입력된 ID
        String enteredPassword = et2.getText().toString();  // 입력된 Password

        // ID나 Password가 비어 있는지 확인
        if (enteredID.equals("") || enteredPassword.equals("")) {
            // ID나 Password 중 하나라도 비어 있으면 토스트 메시지 표시하고 종료
            Toast.makeText(LoginNewActivity.this, "ID와 Password를 모두 입력하세요.", Toast.LENGTH_SHORT).show();
            return;  // 함수 종료
        }

        // 데이터베이스에 사용자 정보를 추가
        sqldb = Logindb.getWritableDatabase();  // 데이터베이스를 쓰기 전용으로 열기
        sql = "INSERT INTO tbInfo (sID, sPass) VALUES ('" + enteredID + "', '" + enteredPassword + "')";
        sqldb.execSQL(sql);  // SQL 쿼리를 실행하여 사용자 정보 삽입

        // 회원가입 완료 메시지 토스트 표시
        Toast.makeText(LoginNewActivity.this, "회원가입 되었습니다.", Toast.LENGTH_SHORT).show();

        // 로그인 화면으로 돌아가기
        Intent intent = new Intent(LoginNewActivity.this, LoginActivity.class);
        startActivity(intent);  // LoginActivity로 이동
    }
}