<?php
/**
 * Created by PhpStorm.
 * User: zhuyi
 * Date: 2018/3/13
 * Time: 10:35
 */
namespace app\shop\controller;

use cmf\controller\AdminBaseController;
use think\Db;

class AdminFinanceController extends AdminBaseController
{
    public function index(){
        echo '财务报表';
    }
}