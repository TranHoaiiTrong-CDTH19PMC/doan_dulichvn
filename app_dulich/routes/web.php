<?php

use Illuminate\Support\Facades\Route;
use App\Models\words;
use App\Http\Controllers\travelController;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


Route::get('/them_dia_danh',[travelController::class,'them_dia_danh'])->name('them_dia_danh');
Route::post('/them_dia_danh',[travelController::class,'xl_them_dia_danh'])->name('xl_them_dia_danh');



Route::get('/sua_dia_danh/{id}',[travelController::class,'sua_dia_danh'])->name('sua_dia_danh');
Route::post('/sua_dia_danh/{id}',[travelController::class,'xl_sua_dia_danh'])->name('xl_sua_dia_danh');

