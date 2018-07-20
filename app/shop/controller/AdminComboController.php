<?php
/**
 * Created by PhpStorm.
 * User: zhuyi
 * Date: 2018/3/13
 * Time: 10:29
 */
namespace app\shop\controller;

use cmf\controller\AdminBaseController;
use think\Db;

class AdminComboController extends AdminBaseController
{
    public function index(){
        echo '套餐列表';
    }
}