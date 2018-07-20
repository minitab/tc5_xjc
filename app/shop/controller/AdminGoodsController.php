<?php
/**
 * Created by PhpStorm.
 * User: Goodboy
 * Date: 2018-3-7
 * Time: 19:31
 */
namespace app\shop\controller;

use cmf\controller\AdminBaseController;
use think\Db;

class AdminGoodsController extends AdminBaseController
{
    /**
     * 商品列表
     *
     * @return mixed
     */
    public function index(){


        $this->assign('articles', []);
        return $this->fetch();
    }

    /**
     * 添加商品
     *
     * @return mixed
     */
    public function add()
    {
        $this->assign('article_theme_files', []);
        return $this->fetch();
    }


}