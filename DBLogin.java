package com.example.finalproject;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import androidx.annotation.Nullable;

// 로그인 정보(회원가입 정보)를 저장하기 위한 DB(LoginActivity, LoginNewActivity)
public class DBLogin extends SQLiteOpenHelper {

    // 생성자에서 데이터베이스 이름(LoginDB.db)과 버전을 설정
    public DBLogin(@Nullable Context context) {
        super(context, "LoginDB.db", null, 1);  // 데이터베이스 이름: LoginDB.db, 버전: 1
    }

    // 데이터베이스를 최초로 생성할 때 호출되는 메서드
    @Override
    public void onCreate(SQLiteDatabase db) {
        // 회원 정보를 저장할 테이블(tbInfo) 생성
        db.execSQL("create table tbInfo (sID char(20), sPass char(20))");  // 테이블 구조: 사용자 ID, 비밀번호
    }

    // 데이터베이스의 버전이 업그레이드될 때 호출되는 메서드
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // 기존 테이블이 존재하면 삭제 후 새로 생성
        db.execSQL("drop table if exists tbInfo");  // 기존 테이블 삭제
        onCreate(db);  // 새로운 테이블 생성
    }
}

