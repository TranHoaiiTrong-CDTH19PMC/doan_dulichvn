<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\words;
use App\Models\trangthaidangnhap;
use App\Http\Requests\themdiadanh;
class travelController extends Controller
{
    public function them_dia_danh()
    {
        return view('them_dia_danh');
    }
    public function xl_them_dia_danh(themdiadanh $a)
    {
        $table=new words;
        $table->name=$a->name;
        $table->tagLine=$a->tagLine;
        $table->image=$a->image;
        $table->images=$a->images;
        $table->description=$a->description;
        
      
        $table->save();
        return redirect()->route("them_dia_danh");
    }

    public function sua_dia_danh($id)
    {
        $ds=words::find($id);
       
        return view('sua_dia_danh',compact('ds'));
    }

    public function xl_sua_dia_danh($id,Request $a) 
    {
        $table==words::find($id);
        $table->name=$a->name;
        $table->tagLine=$a->tagLine;
        $table->image=$a->image;
        $table->images=$a->images;
        $table->description=$a->description;
        
      
        $table->save();
        return redirect()->route("them_dia_danh");
    }
    public function luutrangthai($email,$pass)
    {
       
    //    $request-> session()->put('pass', $pass);
    //    $request-> session()->put('email', $email);
    $taikhoan=taikhoan::where("email","$email")->where("pass","$pass")->first();
    $add= new trangthaidangnhap;
    $add->trangthai=$taikhoan->id;
    $add->save();
      
    }
    public function getemail(Request $request)
    {
        return   $request->session()->get('email');
    }
    public function getpass(Request $request)
    {
        return   $request->session()->get('pass');
    }
}
