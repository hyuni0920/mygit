package com.example.finalproject;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;
// 회원가입을 통해 DB에 저장된 id, pwd를 사용자가 입력한 정보와 일치하는지 확인하여 로그인하는 클래스
// (LoginNewActivity, DBLogin)
public class LoginActivity extends AppCompatActivity {
    EditText et1, et2;       // ID와 비밀번호를 입력받을 EditText 객체
    DBLogin Logindb;         // DBLogin 객체 (로그인 DB를 관리)
    SQLiteDatabase sqldb;    // SQLiteDatabase 객체 (DB 읽기/쓰기)
    String sql;              // SQL 쿼리 문자열

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        et1 = findViewById(R.id.editTextID);        // ID 입력창 초기화
        et2 = findViewById(R.id.editTextPass);      // Password 입력창 초기화
        Logindb = new DBLogin(this);                // DBLogin 객체 생성
    }

    public void onButtonLogin(View view) {  // 로그인 버튼 클릭 시
        // 사용자가 입력한 ID와 password 가져오기
        String enteredID = et1.getText().toString();        // 입력된 ID
        String enteredPassword = et2.getText().toString();  // 입력된 비밀번호

        // 읽기 전용 데이터베이스 열기
        sqldb = Logindb.getReadableDatabase();

        // 데이터베이스에서 ID와 일치하는 레코드를 tbInfo 테이블에서 가져오기
        String query = "SELECT * FROM tbInfo WHERE sID = '" + enteredID + "'";

        // rawQuery 메서드는 SQL 쿼리를 실행하고 결과를 Cursor로 반환
        Cursor cursor = sqldb.rawQuery(query, null);

        if (cursor.moveToFirst()) {  // 커서가 결과를 가져왔다면 (ID에 해당하는 레코드가 존재하는 경우)
            // 커서에서 "sPass" 컬럼의 인덱스를 가져옴
            int passIndex = cursor.getColumnIndexOrThrow("sPass");
            // 커서에서 "sPass" 컬럼의 값을 가져와 저장된 비밀번호와 비교
            String storedPassword = cursor.getString(passIndex);

            if (enteredPassword.equals(storedPassword)) {  // 비밀번호 일치
                // 비밀번호가 일치하면 MainActivity 이동
                Intent intent = new Intent(LoginActivity.this, MainActivity.class);
                startActivity(intent);
            } else {
                // 비밀번호 불일치 시 토스트 메시지 표시
                Toast.makeText(LoginActivity.this, "비밀번호가 일치하지 않습니다.", Toast.LENGTH_SHORT).show();
            }
        } else {  // ID가 존재하지 않는 경우
            // 해당하는 ID가 없으면 토스트 메시지 표시
            Toast.makeText(LoginActivity.this, "해당하는 ID가 존재하지 않습니다.", Toast.LENGTH_SHORT).show();
        }

        // 커서 닫기 (자원 해제)
        cursor.close();
    }

    public void onButtonNew(View view) {  // 회원가입 화면으로 이동
        Intent intent = new Intent(LoginActivity.this, LoginNewActivity.class);
        startActivity(intent);
    }
}