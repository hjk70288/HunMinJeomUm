package com.example.hunminjungum;
import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.content.ContentUris;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.media.ExifInterface;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.DocumentsContract;
import android.provider.MediaStore;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.core.content.FileProvider;

import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.toolbox.Volley;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.InetAddress;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.Date;

import in.gauriinfotech.commons.Commons;

public class SecondActivity extends AppCompatActivity{
    private File file;
    TextView sessionid;
    String session_id;

    /*ocr을 위한 변수*/
    private final int CAMERA_CODE = 0;
    private final int GALLERY_CODE=1;
    private final int FILE_CODE=2;
    private Uri photoUri;
    private String currentPhotoPath;//실제 사진 파일 경로
    String mImageCaptureName;//이미지 이름

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        getSupportActionBar().hide();
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        Button loadfile = (Button)findViewById(R.id.loadfile);
        Button loadpicture = (Button)findViewById(R.id.loadpicture);
        Button takecamera = (Button)findViewById(R.id.takecamera);

        File sdcard = Environment.getExternalStorageDirectory();
        String imageFileName = "capture.jpg";
        file = new File(sdcard, imageFileName);

        Button camera = (Button)findViewById(R.id.takecamera);
        camera.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                capture();
            }
        });
        sessionid = (TextView)findViewById(R.id.session_id);

        SharedPreferences sharedPreferences = getSharedPreferences("login",MODE_PRIVATE);
        session_id = sharedPreferences.getString("id","");
        if(!session_id.equals("")){
            sessionid.setText(session_id+"님, 환영합니다.");
            getSupportActionBar().show();
            getSupportActionBar().setTitle("훈민점음");
            getSupportActionBar().setDisplayShowHomeEnabled(true);
            getSupportActionBar().setIcon(R.drawable.icon);
        }

        loadfile.setOnClickListener(new View.OnClickListener(){
            public void onClick(View v){
                Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
                intent.setType("*/*");
                intent.addCategory(Intent.CATEGORY_OPENABLE);
                startActivityForResult(intent,FILE_CODE);
            }
        });

        loadpicture.setOnClickListener(new View.OnClickListener(){
            public void onClick(View v){
                Intent intent = new Intent(Intent.ACTION_PICK);
                intent.setData(android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                intent.setType("image/*");
                startActivityForResult(intent,GALLERY_CODE);
            }
        });


        takecamera.setOnClickListener(new View.OnClickListener(){
            public void onClick(View v){
                String state = Environment.getExternalStorageState();
                if (Environment.MEDIA_MOUNTED.equals(state)) {
                    Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                    if (intent.resolveActivity(getPackageManager()) != null) {
                        File photoFile = null;
                        try {
                            photoFile = createImageFile();
                        } catch (IOException ex) {
                            StringWriter sw = new StringWriter();
                            ex.printStackTrace(new PrintWriter(sw));
                            String exceptionAsString = sw.toString();
                            Log.e("StackTrace", exceptionAsString);
                        }
                        if (photoFile != null) {
                            photoUri = FileProvider.getUriForFile(getApplicationContext(), getPackageName(), photoFile);
                            intent.putExtra(MediaStore.EXTRA_OUTPUT, photoUri);
                            startActivityForResult(intent, CAMERA_CODE);
                        }
                    }

                }
            }
        });

        Button community = (Button)findViewById(R.id.community);
        community.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(SecondActivity.this, CommunityActivity.class);
                intent.putExtra("id", session_id);
                startActivity(intent);
            }
        });

    }

    private File createImageFile() throws IOException {
        File dir = new File(Environment.getExternalStorageDirectory() + "/path/");
        if (!dir.exists()) {
            dir.mkdirs();
        }
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        mImageCaptureName = timeStamp + ".png";

        File storageDir = new File(Environment.getExternalStorageDirectory().getAbsoluteFile() + "/path/"
                + mImageCaptureName);
        currentPhotoPath = storageDir.getAbsolutePath();

        return storageDir;

    }

    private void getPictureForPhoto() {
        Bitmap bitmap = BitmapFactory.decodeFile(currentPhotoPath);
        ExifInterface exif = null;
        try {
            exif = new ExifInterface(currentPhotoPath);
        } catch (IOException e) {
            e.printStackTrace();
        }
        /*
        int exifOrientation;
        int exifDegree;

        if (exif != null) {
            exifOrientation = exif.getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL);
            exifDegree = exifOrientationToDegrees(exifOrientation);
        } else {
            exifDegree = 0;
        }
        ivImage.setImageBitmap(rotate(bitmap, exifDegree));//이미지 뷰에 비트맵 넣기
        */
    }

    private String getRealPathFromURI(Uri contentUri) {
        int column_index=0;
        String[] proj = {MediaStore.Images.Media.DATA};
        Cursor cursor = getContentResolver().query(contentUri, proj, null, null, null);
        if(cursor.moveToFirst()){
            column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
        }

        return cursor.getString(column_index);
    }

    private void sendPicture(Uri imgUri) {

        String imagePath = getRealPathFromURI(imgUri); // path 경로
        /*
        ExifInterface exif = null;
        try {
            exif = new ExifInterface(imagePath);
        } catch (IOException e) {
            e.printStackTrace();
        }
        int exifOrientation = exif.getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL);
        int exifDegree = exifOrientationToDegrees(exifOrientation);

        Bitmap bitmap = BitmapFactory.decodeFile(imagePath);//경로를 통해 비트맵으로 전환
        ivImage.setImageBitmap(rotate(bitmap, exifDegree));//이미지 뷰에 비트맵 넣기
*/
    }

    @SuppressLint("NewApi")
    public static String getRealPathFromURI(final Context context, final Uri uri) {
        // DocumentProvider
        if (DocumentsContract.isDocumentUri(context, uri)) {

            // ExternalStorageProvider
            if (isExternalStorageDocument(uri)) {
                final String docId = DocumentsContract.getDocumentId(uri);
                final String[] split = docId.split(":");
                final String type = split[0];

                if ("primary".equalsIgnoreCase(type)) {
                    return Environment.getExternalStorageDirectory() + "/" + split[1];
                }

                // TODO handle non-primary volumes
            }
            // DownloadsProvider
            else if (isDownloadsDocument(uri)) {
                Log.e("print", uri.getPath());
                Log.e("print", uri.getAuthority());
                String id = DocumentsContract.getDocumentId(uri);

                if (id != null && id.length() > 0) {
                    Log.e("print", id);
                    id = id.split(":")[1];
                    Log.e("print", id);
                    if (id.startsWith("raw:")) {
                        return id.replaceFirst("raw:", "");
                    }
                    try {
                        final Uri contentUri = ContentUris.withAppendedId(
                                Uri.parse("content://downloads/public_downloads"), Long.valueOf(id));

                        Log.e("print", contentUri.getPath());
                        Log.e("print", contentUri.getAuthority());
                        return getDataColumn(context, contentUri, null, null);
                    } catch (NumberFormatException e) {
                        return null;
                    }
                } else {
                    return null;
                }
            }
            // MediaProvider
            else if (isMediaDocument(uri)) {
                final String docId = DocumentsContract.getDocumentId(uri);
                final String[] split = docId.split(":");
                final String type = split[0];

                Uri contentUri = null;
                if ("image".equals(type)) {
                    contentUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI;
                } else if ("video".equals(type)) {
                    contentUri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI;
                } else if ("audio".equals(type)) {
                    contentUri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI;
                }

                final String selection = "_id=?";
                final String[] selectionArgs = new String[] {
                        split[1]
                };

                return getDataColumn(context, contentUri, selection, selectionArgs);
            }
        }
        // MediaStore (and general)
        else if ("content".equalsIgnoreCase(uri.getScheme())) {

            // Return the remote address
            if (isGooglePhotosUri(uri))
                return uri.getLastPathSegment();

            return getDataColumn(context, uri, null, null);
        }
        // File
        else if ("file".equalsIgnoreCase(uri.getScheme())) {
            return uri.getPath();
        }

        return null;
    }

    public static String getDataColumn(Context context, Uri uri, String selection,
                                       String[] selectionArgs) {

        Cursor cursor = null;
        final String column = "_data";
        final String[] projection = {
                MediaStore.Images.Media.DATA
        };

        try {
            cursor = context.getContentResolver().query(uri, projection, selection, selectionArgs,
                    null);
            if (cursor != null && cursor.moveToFirst()) {

                final int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
                cursor.moveToFirst();
                return cursor.getString(column_index);
            }
        } catch (Exception e) {
            return null;
        } finally {
            if (cursor != null)
                cursor.close();
        }
        return null;
    }

    public static boolean isExternalStorageDocument(Uri uri) {
        return "com.android.externalstorage.documents".equals(uri.getAuthority());
    }

    /**
     * @param uri The Uri to check.
     * @return Whether the Uri authority is DownloadsProvider.
     * @author paulburke
     */
    public static boolean isDownloadsDocument(Uri uri) {
        return "com.android.providers.downloads.documents".equals(uri.getAuthority());
    }

    /**
     * @param uri The Uri to check.
     * @return Whether the Uri authority is MediaProvider.
     * @author paulburke
     */
    public static boolean isMediaDocument(Uri uri) {
        return "com.android.providers.media.documents".equals(uri.getAuthority());
    }

    /**
     * @param uri The Uri to check.
     * @return Whether the Uri authority is Google Photos.
     */
    public static boolean isGooglePhotosUri(Uri uri) {
        return "com.google.android.apps.photos.content".equals(uri.getAuthority());
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        final LoadingActivity loading = new LoadingActivity(SecondActivity.this);
        loading.setCancelable(false);

        if(resultCode==RESULT_OK)
        {
            switch (requestCode){
                case GALLERY_CODE:
                    final String imgUri = getRealPathFromURI(data.getData());
                    loading.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
                    loading.show();

                    new Thread(new Runnable() {
                        @Override
                        public void run() {
                            final String result = SecondActivity.this.run(imgUri);
                            runOnUiThread(new Runnable() {
                                @Override
                                public void run() {
                                    loading.dismiss();
                                    Intent intent = new Intent(SecondActivity.this,OcrResultActivity.class);
                                    intent.putExtra("ocr_result",result);
                                    startActivity(intent);
                                }
                            });
                        }
                    }).start();
                    break;
                case CAMERA_CODE:
                    loading.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
                    loading.show();

                    new Thread(new Runnable() {
                        @Override
                        public void run() {
                            final String result = SecondActivity.this.run(currentPhotoPath);
                            runOnUiThread(new Runnable() {
                                @Override
                                public void run() {
                                    loading.dismiss();
                                    Intent intent = new Intent(SecondActivity.this,OcrResultActivity.class);
                                    intent.putExtra("ocr_result",result);
                                    startActivity(intent);
                                }
                            });
                        }
                    }).start();
                    break;

                case FILE_CODE:
                    final String filePath = getRealPathFromURI( getApplicationContext(), data.getData());
                   // Log.e("path", filePath);
//                    final String filePath = Commons.getPath(data.getData(), this);
                    loading.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
                    loading.show();
                    new Thread(new Runnable() {
                        @Override
                        public void run() {
                            final String result = SecondActivity.this.run(filePath);
                            runOnUiThread(new Runnable() {
                                @Override
                                public void run() {
                                    loading.dismiss();
                                    Intent intent = new Intent(SecondActivity.this,OcrResultActivity.class);
                                    intent.putExtra("ocr_result",result);
                                    startActivity(intent);
                                }
                            });
                        }
                    }).start();
                    break;

                default:
                    break;
            }
        }

    }

    public String run(String imgPath) {
        try {
            Log.e("print", imgPath);
            String [] splitArr = imgPath.split("\\.");
            String fileType = splitArr[splitArr.length - 1] + ":type";
            InetAddress serverAddr = InetAddress.getByName("52.78.166.34");
            Socket socket = new Socket(serverAddr, 4041);
            try {
                DataOutputStream dataOutput = new DataOutputStream(socket.getOutputStream());
                DataInputStream dataInput = new DataInputStream(new FileInputStream(new File(imgPath)));

                byte[] buf = new byte[1024];
                int dataLen;
                dataOutput.write(fileType.getBytes(), 0, fileType.getBytes().length);
                dataOutput.flush();
                while ((dataLen = dataInput.read(buf)) != -1) {
                    dataOutput.write(buf, 0, dataLen);
                    dataOutput.flush();
                }
                String data;
                String tmp;
                //byte[] byteArr = new byte[1024];
                InputStream is = socket.getInputStream();
                BufferedReader reader = new BufferedReader(new InputStreamReader(is));
                data=reader.readLine()+"\n";
                while (true)
                {
                    tmp=reader.readLine();
                    if(tmp==null)
                        break;
                    data+=tmp+"\n";
                }
               /* int readByteCount = is.read(byteArr);
                data = new String(byteArr, 0, readByteCount, "UTF-8");
                while (true)
                {
                    readByteCount = is.read(byteArr);
                    Log.e("length",String.valueOf(readByteCount));
                    if(readByteCount==-1)
                        break;
                    data += new String(byteArr, 0, readByteCount, "UTF-8");
                }
                */
                is.close();
                dataInput.close();
                dataOutput.close();
                socket.close();
                return data;
            } catch (Exception e) {
                StringWriter sw = new StringWriter();
                e.printStackTrace(new PrintWriter(sw));
                String exceptionAsString = sw.toString();
                Log.e("StackTrace", exceptionAsString);
            }
        } catch (IOException e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsString = sw.toString();
            Log.e("StackTrace", exceptionAsString);
        }
        return "";
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater = getMenuInflater();
        menuInflater.inflate(R.menu.menuformember, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        switch (item.getItemId()){
            case R.id.logout:
                DialogInterface.OnClickListener yesButtonClickListener1= new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        SharedPreferences pref = getSharedPreferences("login", MODE_PRIVATE);
                        SharedPreferences.Editor editor = pref.edit();
                        editor.remove("id");
                        editor.commit();
                        sessionid.setText("");
                        getSupportActionBar().hide();
                    }
                };
                AlertDialog.Builder builder1=new AlertDialog.Builder( SecondActivity.this );
                builder1.setMessage("로그아웃 하시겠습니까?")
                        .setPositiveButton("확인",yesButtonClickListener1)
                        .create()
                        .show();
                break;
            case R.id.withdraw:
                DialogInterface.OnClickListener yesButtonClickListener2 = new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        Response.Listener<String> responseListener = new Response.Listener<String>(){
                            @Override
                            public void onResponse(String response) {
                                try{
                                    JSONObject jsonResponse = new JSONObject(response);
                                    boolean success = jsonResponse.getBoolean("success");
                                    if(success){
                                        SharedPreferences pref = getSharedPreferences("login", MODE_PRIVATE);
                                        SharedPreferences.Editor editor = pref.edit();
                                        editor.remove("id");
                                        editor.commit();
                                        sessionid.setText("");
                                        getSupportActionBar().hide();
                                    }
                                }
                                catch(Exception e){
                                    e.printStackTrace();
                                }
                            }
                        };
                        DeleteRequest deleteRequest = new DeleteRequest(session_id, responseListener);
                        RequestQueue queue = Volley.newRequestQueue(SecondActivity.this);
                        queue.add(deleteRequest);
                    }
                };
                AlertDialog.Builder builder2 = new AlertDialog.Builder(SecondActivity.this);
                builder2.setMessage("회원 탈퇴를 하시겠습니까?" +
                        "(정보는 영구적으로 삭제됩니다.)")
                        .setPositiveButton("확인", yesButtonClickListener2)
                        .create()
                        .show();
                break;
            case R.id.modifyinfo:
                Intent intent = new Intent(getApplicationContext(),ModifyActivity.class);
                startActivity(intent);
                break;
            case R.id.ocrlist:
                Intent mintent = new Intent(SecondActivity.this, OcrActivity.class);
                startActivity(mintent);
                return true;
        }
        return super.onOptionsItemSelected(item);
    }

    public void capture(){
        Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        Uri uri = FileProvider.getUriForFile(getBaseContext(), "com.onedelay.chap7.fileprovider", file);
        intent.putExtra(MediaStore.EXTRA_OUTPUT, uri);
        startActivityForResult(intent, 101);
    }
}
