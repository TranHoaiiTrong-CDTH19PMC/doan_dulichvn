<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\words;
class travelseeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $add=new words;
        $add-> name ="Nhà thờ Đức Bà";
        $add-> tagLine="Nhà thờ Đức Bà, Sài Gòn";
        $add-> image ="https://image.thanhnien.vn/w2048/Uploaded/2021/cqjwqcqdh/2020_05_23/4_xshh.jpg";
        $add-> images ="https://image.thanhnien.vn/w2048/Uploaded/2021/cqjwqcqdh/2020_05_23/4_xshh.jpg";
        $add-> description ="Theo bài viết trên báo Business Insider (Mỹ), nhà thờ Đức Bà Sài Gòn được mô phỏng theo Nhà thờ Đức Bà ở Paris, là một trong 19 thánh đường đẹp nhất trên thế giới.";
        $add->save();
    }
}
