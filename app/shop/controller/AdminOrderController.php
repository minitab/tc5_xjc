<?php
/**
 * Created by PhpStorm.
 * User: zhuyi
 * Date: 2018/3/13
 * Time: 10:15
 */
namespace app\shop\controller;

use cmf\controller\AdminBaseController;
use think\Db;

class AdminOrderController extends AdminBaseController
{
    public function index(){
        echo '订单列表';
    }
}