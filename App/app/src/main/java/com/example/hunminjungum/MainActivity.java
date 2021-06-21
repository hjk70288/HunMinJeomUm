package com.example.hunminjungum;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import android.Manifest;
import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;


public class MainActivity extends AppCompatActivity {
    int PERMISSION_ALL = 1;
    String[] PERMISSIONS = {
            Manifest.permission.READ_EXTERNAL_STORAGE,
            Manifest.permission.WRITE_EXTERNAL_STORAGE,
            Manifest.permission.CAMERA
    };

    public boolean hasPermissions(Context context, String[] permissions) {
        if (context != null && permissions != null) {
            for (String permission : permissions) {
                if (ActivityCompat.checkSelfPermission(context, permission) != PackageManager.PERMISSION_GRANTED) {
                    return false;
                }
            }
        }
        return true;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        setTitle("훈민점음");

        getSupportActionBar().setDisplayShowHomeEnabled(true);
        getSupportActionBar().setIcon(R.drawable.icon);




        Button login = (Button)findViewById(R.id.login);
        login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // 권한이 허용되어있지않다면 권한요청
                if(!hasPermissions(getApplicationContext(), PERMISSIONS)){
                    ActivityCompat.requestPermissions(MainActivity.this, PERMISSIONS, PERMISSION_ALL);
                }else {
                    Intent intent = new Intent(getApplicationContext(), LoginActivity.class);
                    startActivity(intent);
                }
            }
        });

        Button join = (Button)findViewById(R.id.join);
        join.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // 권한이 허용되어있지않다면 권한요청
                if(!hasPermissions(getApplicationContext(), PERMISSIONS)){
                    ActivityCompat.requestPermissions(MainActivity.this, PERMISSIONS, PERMISSION_ALL);
                }else {
                    Intent intent = new Intent(getApplicationContext(), JoinActivity.class);
                    startActivity(intent);
                }
            }
        });

        Button nonmember = (Button)findViewById(R.id.nonmember);
        nonmember.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // 권한이 허용되어있지않다면 권한요청
                if(!hasPermissions(getApplicationContext(), PERMISSIONS)){
                    ActivityCompat.requestPermissions(MainActivity.this, PERMISSIONS, PERMISSION_ALL);
                }else {
                    Intent intent = new Intent(getApplicationContext(), SecondActivity.class);
                    startActivity(intent);
                }
            }
        });



    }
}
