package com.example.finalproject;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.ArrayList;
//CartPayment 객체의 리스트를 받아와 항목을 표시하는 클래스(CartActivity_sub,CartActivity,CartPayment)
// CartPayment 객체의 리스트를 받아와 항목을 표시하는 클래스(CartActivity_sub, CartActivity, CartPayment)
public class CartAdapter extends BaseAdapter {

    private Context context;  // 어댑터를 사용하는 컨텍스트 (액티비티 등)
    private ArrayList<CartPayment> items;  // CartPayment 객체의 리스트
    private int item_layout = R.layout.item_layout_cart;  // 리스트에 각 항목을 표시할 item_layout_cart

    // 생성자 생성, 어댑터를 초기화하고 필요한 데이터를 받아옴
    public CartAdapter(Context context, ArrayList<CartPayment> itmes) {
        this.context = context;  // 컨텍스트 초기화
        this.items = itmes;  // 전달받은 CartPayment 리스트 초기화
    }

    // 리스트의 항목 개수를 반환
    @Override
    public int getCount() {
        return items.size();  // 리스트 크기 반환
    }

    // position에 해당하는 데이터 항목 반환
    @Override
    public Object getItem(int position) {
        return items.get(position);  // 해당 위치의 항목 반환
    }

    // position에 해당하는 데이터 항목의 ID 반환
    @Override
    public long getItemId(int position) {
        return position;  // 항목의 ID는 position으로 반환
    }

    // 각 항목을 표시하는 View 반환
    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        if (convertView == null) {
            // convertView가 없으면 새로운 뷰를 생성
            LayoutInflater inflater = (LayoutInflater)
                    context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            convertView = inflater.inflate(item_layout, null);  // item_layout을 기반으로 뷰 생성
        }

        // 각 항목에 대한 뷰 요소 찾기
        TextView tv1 = convertView.findViewById(R.id.textViewcartItem1);  // 상품명(title)
        TextView tv2 = convertView.findViewById(R.id.textViewCartItem2);  // 금액, 결제일자(cash, date)

        // 현재 위치에 해당하는 데이터로 TextView 설정
        tv1.setText(items.get(position).getTitle());  // 상품명 설정
        tv2.setText(items.get(position).getCash() + "원 / " + items.get(position).getDate());  // 금액과 결제일자 설정

        return convertView;  // 완성된 View 반환
    }
}