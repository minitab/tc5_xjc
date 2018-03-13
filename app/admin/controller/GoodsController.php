<?php
/**
 * Created by PhpStorm.
 * User: Goodboy
 * Date: 2018-3-7
 * Time: 19:31
 */
namespace app\admin\controller;

use cmf\controller\AdminBaseController;
use think\Db;

class GoodsController extends AdminBaseController
{
    public function index(){


        $this->assign('articles', []);
        return $this->fetch();
    }
}