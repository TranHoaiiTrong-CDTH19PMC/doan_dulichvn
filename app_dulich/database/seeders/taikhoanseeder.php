<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\taikhoan;
class taikhoanseeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $add=new taikhoan;
        $add-> name ="Trần Hoài Trọng";
        $add-> email="trong@gmail.com";
        $add-> phone ="0397715678";
        $add-> pass ="123@123";
        $add->save();
    }
}
