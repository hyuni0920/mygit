package com.example.finalproject;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Log;
import android.view.View;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class MainActivity extends AppCompatActivity {
    EditText et1;  // 검색어 입력창을 위한 EditText 객체
    ArrayList<SSadaShop> items = new ArrayList<>();  // 쇼핑 아이템을 담는 ArrayList
    BaseAdapter adapter;  // ListView에 연결될 어댑터

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);  // activity_main 레이아웃을 설정
        et1 = findViewById(R.id.editTextSearch);  // 검색어 입력창을 EditText로 초기화

        // SSadaShopAdapter에서 정의한 adapter를 생성하고 ListView에 연결
        adapter = new SSadaShopAdapter(this, R.layout.item_layout, items);
        ListView lv = findViewById(R.id.ListView);  // ListView 객체 초기화
        lv.setAdapter(adapter);  // ListView에 어댑터 연결
    }

    public void onYoutubeClick(View view) {  // 동영상 클릭 시 해당 유튜브 영상으로 이동
        Intent myIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://youtu.be/4kmTHqzx9ZI?si=XEpJ99Qo8sOt5WvY"));  // 유튜브 링크
        startActivity(myIntent);  // 유튜브로 이동하는 Intent 실행
    }

    public void ImgBtnCart(View view) {  // 장바구니 버튼 클릭 시 CartActivity로 이동
        Intent cartintent = new Intent(this, CartActivity.class);  // CartActivity로 이동하는 Intent 생성
        startActivity(cartintent);  // CartActivity 실행
    }


    public void onTextTel(View view) {  // 전화번호 클릭 시 해당 전화번호로 전화걸기
        Uri uri = Uri.parse("tel:010-1234-5678");  // 전화번호 URI 생성
        Intent intent = new Intent(Intent.ACTION_DIAL, uri);  // 다이얼러를 호출하는 Intent 생성
        startActivity(intent);  // 전화 걸기 화면 실행
    }

    public void onTextAdd(View view) {  // 회사 주소 클릭 시 해당 주소의 회사 지도 보기
        Uri uri = Uri.parse("geo:35.1640, 129.1634");  // GPS 좌표를 이용한 지도 URI 생성
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);  // 지도 앱을 실행하는 Intent 생성
        startActivity(intent);  // 지도 앱 실행
    }

    public void onImgBtnSearch(View view) {  // 검색 버튼 클릭 시 검색 수행
        items.clear();  // 기존에 검색된 아이템들을 초기화하여 새로 시작
        // 네트워크 연결 상태 확인을 위한 ConnectivityManager 객체 생성
        ConnectivityManager manager = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        // 네트워크 정보를 담은 객체를 가져옴
        NetworkInfo info = manager.getActiveNetworkInfo();
        // 네트워크 연결이 있을 경우
        if (info != null) {
            // EditText에 입력된 검색어 가져와 keyword에 저장
            String keyword = et1.getText().toString();
            new Thread(new Runnable() {
                @Override
                public void run() {
                    Log.d("Thread", "before calling api.");
                    searchShop(keyword);  // keyword를 이용하여 쇼핑 API 호출
                }
            }).start();  // 새로운 스레드에서 쇼핑 검색 수행
        } else {
            // 네트워크가 연결되지 않은 경우, 사용자에게 알림
            Toast.makeText(this, "네트워크를 먼저 연결하세요", Toast.LENGTH_SHORT).show();
        }
    }

    private void searchShop(String keyword) {  // 특정 키워드로 상품 검색하는 메소드
        String clientId = "zJE3GmOMoj8tfM4_kVmE"; // 애플리케이션 클라이언트 아이디
        String clientSecret = "rEH4uqYXow"; // 애플리케이션 클라이언트 시크릿
        String text = null;
        try {
            // 검색어를 URL 인코딩하여 전달
            text = URLEncoder.encode(keyword, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패", e);  // 인코딩 실패 시 예외 발생
        }
        // API 호출을 위한 URL 생성
        String apiURL = "https://openapi.naver.com/v1/search/shop.json?query=" + text + "&display=20";  // JSON 결과
        Map<String, String> requestHeaders = new HashMap<>();  // API 요청 헤더 생성
        requestHeaders.put("X-Naver-Client-Id", clientId);  // 클라이언트 아이디 추가
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);  // 클라이언트 시크릿 추가
        String responseBody = get(apiURL, requestHeaders);  // API 요청 및 응답 받기
        System.out.println(responseBody);  // 응답 결과 출력

        try {
            // JSON 응답을 파싱하여 상품 목록 추출
            JSONObject obj = new JSONObject(responseBody);
            JSONArray array = obj.getJSONArray("items");
            // 반복문을 통해 상품 목록(JSON 배열)을 순회하면서 각 상품 정보 추출
            for (int i = 0; i < array.length(); i++) {
                // 현재 인덱스에 해당하는 JSON 객체 가져오기
                JSONObject objBook = (JSONObject) array.get(i);
                // JSON 객체에서 각각의 상품 정보 추출
                String title = objBook.getString("title");
                String image = objBook.getString("image");
                String maker = objBook.getString("maker");
                String brand = objBook.getString("brand");
                String category1 = objBook.getString("category1");
                // 추출된 정보를 이용하여 SSadaShop 객체를 생성
                SSadaShop shop = new SSadaShop(title, null, maker, brand, category1);
                // 상품 이미지를 가져오기 위해 다음 메서드 호출
                getShopImage(shop, image);  // 이미지 URL을 이용해 이미지를 가져옴
            }
        } catch (Exception e) {
            System.out.println(e);  // 예외 발생 시 로그 출력
        }
    }

    // SSadaShop 객체에 이미지를 설정하는 메서드
    private void getShopImage(SSadaShop shop, String imageUrl) {
        Bitmap shImage = null;  // 이미지를 담을 Bitmap 변수 초기화
        try {
            // 이미지 URL을 이용하여 URL 객체 생성
            URL url = new URL(imageUrl);
            InputStream is = url.openStream();  // URL에서 InputStream 열기
            // InputStream을 이용하여 Bitmap으로 이미지 디코딩
            shImage = BitmapFactory.decodeStream(is);
        } catch (Exception e) {
            e.printStackTrace();  // 예외 발생 시 스택 트레이스 출력
        }
        // SSadaShop 객체에 이미지 설정
        shop.setImage(shImage);
        // 설정된 SSadaShop 객체를 리스트에 추가
        items.add(shop);
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                adapter.notifyDataSetChanged();  // 어댑터에 변경 사항 알리기
            }
        });
    }

    // API URL과 헤더 정보를 이용하여 GET 요청을 수행하는 메서드
    private static String get(String apiUrl, Map<String, String> requestHeaders) {
        HttpURLConnection con = connect(apiUrl);  // URL과 연결된 HttpURLConnection 객체 생성
        try {
            con.setRequestMethod("GET");  // GET 요청 방식 설정
            // 요청 헤더 설정
            for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }
            int responseCode = con.getResponseCode();  // 응답 코드 받기
            if (responseCode == HttpURLConnection.HTTP_OK) {  // 정상 호출
                return readBody(con.getInputStream());  // 응답 바디 읽기
            } else {  // 오류 발생
                return readBody(con.getErrorStream());  // 오류 응답 바디 읽기
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);  // 요청 또는 응답 실패 시 예외 발생
        } finally {
            con.disconnect();  // 연결 종료
        }
    }

    private static HttpURLConnection connect(String apiUrl) {
        try {
            URL url = new URL(apiUrl);  // URL 객체 생성
            return (HttpURLConnection) url.openConnection();  // HttpURLConnection 객체 반환
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);  // URL이 잘못된 경우 예외 발생
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);  // 연결 실패 시 예외 발생
        }
    }

    private static String readBody(InputStream body) {
        InputStreamReader streamReader = new InputStreamReader(body);  // InputStreamReader로 변환
        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();  // 응답 결과를 담을 StringBuilder
            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);  // 한 줄씩 읽어서 응답 결과에 추가
            }
            return responseBody.toString();  // 전체 응답 결과 반환
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);  // 응답 읽기 실패 시 예외 발생
        }
    }
}