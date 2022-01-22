<?php


use Illuminate\Support\Facades\Route;
use App\Models\words;
use App\Models\taikhoan;
use App\Models\baiviet_taikhoan;
use App\Models\trangthaidangnhap;
use App\Models\baiviet_nguoidungthich;
use Illuminate\Http\Request;
date_default_timezone_set('Asia/Ho_Chi_Minh');
use App\Http\Controllers\travelController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
Route::get('/dia_danh',function()
{
   $ls=words::all();
   echo json_encode($ls);
});

Route::get('/luutrangthai/{email}/{pass}',function($email,$pass)
{
  $taikhoan=taikhoan::where("email","$email")->where("pass","$pass")->first();
  $add=new trangthaidangnhap;
  $add->trangthai=$taikhoan->id;
  $add->save();
});

Route::get('/layten',function()
{
   $idtaikhoan= trangthaidangnhap::all()->max("id");
   
   $taikhoan=trangthaidangnhap::find($idtaikhoan);

 $ls=taikhoan::where("id","$taikhoan->trangthai")->first();
 return $ls->name;
});

Route::get('/kiemtramatkhau',function()
{
   $idtaikhoan= trangthaidangnhap::all()->max("id");
   
   $taikhoan=trangthaidangnhap::find($idtaikhoan);

 $ls=taikhoan::where("id","$taikhoan->trangthai")->first();
 return $ls->pass;
});

Route::get('/doimatkhau/{matkhau}',function($matkhau)
{
   $idtaikhoan= trangthaidangnhap::all()->max("id");
   
   $taikhoan=trangthaidangnhap::find($idtaikhoan);

 $ls=taikhoan::where("id","$taikhoan->trangthai")->first();
 $ls->pass=$matkhau;
 $ls->save();
 return "duoc";
});



Route::get('/diadiemmoinhat',function()
{
  $ls=words::where("id",">",0)->orderBy('created_at', 'desc')->get();
  echo json_encode($ls);
});

Route::get('/thoigianchiasebaiviet/{id}',function($id)
{
  $thoigian=baiviet_taikhoan::find($id);
  if($thoigian->created_at->format('d/m/Y')==date('d/m/Y'))
  {
    return  $thoigian->created_at->format('H:i:s');
  }
  return   $thoigian->created_at->format('d/m/Y');
  
});




Route::get('/layidtaikhoan',function()
{
   $idtaikhoan= trangthaidangnhap::all()->max("id");
   
   $taikhoan=trangthaidangnhap::find($idtaikhoan);

 $ls=taikhoan::where("id","$taikhoan->trangthai")->first();
 return $ls->id;
});

Route::get('/chiasebaiviet/{iddiadanh}',function($diadanh)
{
   $idtaikhoan= trangthaidangnhap::all()->max("id");
   
   $taikhoan=trangthaidangnhap::find($idtaikhoan);

 $ls=taikhoan::where("id","$taikhoan->trangthai")->first();

   $add=new baiviet_taikhoan;
   $add->baiviet_id=$diadanh;
   $add->taikhoan_id=$ls->id;
  $add->save();
  return "thanhcong";
});


Route::get('/danhsachbaiviettaikhoan',function()
{
   $idtaikhoan= trangthaidangnhap::all()->max("id");
   
   $taikhoan=trangthaidangnhap::find($idtaikhoan);

 $ls=taikhoan::where("id","$taikhoan->trangthai")->first();

 $danhsachdiadanh=[];
 
  $ds=baiviet_taikhoan::where("taikhoan_id","$ls->id")->get();
  foreach($ds as $p)
  {
   $danhsachdiadanh[]=words::find($p->baiviet_id);
  }
  
  echo json_encode($danhsachdiadanh);
});


Route::get('/like/{idbaiviet}',function($idbaiviet)
{

   $idtaikhoan= trangthaidangnhap::all()->max("id");
   
   $taikhoan=trangthaidangnhap::find($idtaikhoan);

 $ls=taikhoan::where("id","$taikhoan->trangthai")->first();
$add=new baiviet_nguoidungthich;
$add->baiviet_id=$idbaiviet;
$add->taikhoan_id=$ls->id;
$add->save();
return "thanhcong";
});

Route::get('/unlike/{idbaiviet}',function($idbaiviet)
{
   $idtaikhoan= trangthaidangnhap::all()->max("id");
   
   $taikhoan=trangthaidangnhap::find($idtaikhoan);

 $ls=taikhoan::where("id","$taikhoan->trangthai")->first();
   $xoa=baiviet_nguoidungthich::where("baiviet_id","$idbaiviet")->where("taikhoan_id","$ls->id")->first();
   $xoa->delete();
});

Route::get('/soluotthich/{idbaiviet}',function($idbaiviet)
{
  $count=baiviet_nguoidungthich::where("baiviet_id","$idbaiviet")->count();
  return $count;
});

Route::get('/layemail',function()
{
   $idtaikhoan= trangthaidangnhap::all()->max("id");
   
   $taikhoan=trangthaidangnhap::find($idtaikhoan);

 $ls=taikhoan::where("id","$taikhoan->trangthai")->first();
 return $ls->email;
});
Route::get('/layphone',function()
{
   $idtaikhoan= trangthaidangnhap::all()->max("id");
   
   $taikhoan=trangthaidangnhap::find($idtaikhoan);

 $ls=taikhoan::where("id","$taikhoan->trangthai")->first();
 return $ls->phone;
});


Route::get('/ct_diadanh/{id}',function($id)
{
   $ls=words::find($id);
   echo json_encode($ls);
});

Route::get('/timkiem/{id}',function($text)
{
   $ls=words::where('name','LIKE',"%$text%")->get();
   echo json_encode($ls);
});
Route::get('/dang_ki_tai_khoan/{name}/{email}/{phone}/{pass}',function($name,$email,$phone,$pass)
{
  $add=new taikhoan;
  $add->name=$name;
  $add->email=$email;
  $add->pass=$pass;
  $add->phone=$phone;
  $add->save();
   echo json_encode(
     "Đăng kí thành công"
   );
});



Route::get('/tai_khoan/{email}/{pass}',function($email,$pass)
{
   $ls=taikhoan::where('email',$email)->where('pass',"$pass")->first();
   echo json_encode($ls);
});

Route::get('/dang_nhap_tai_khoan/{email}/{pass}',function($email,$pass)
{
 if(taikhoan::where('email',$email)->where('pass',"$pass")->count()>0)
 {
  return "duoc";
 }
 else{
  return "khong";
 }
});