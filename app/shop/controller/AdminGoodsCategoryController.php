<?php
/**
 * Created by PhpStorm.
 * User: Goodboy
 * Date: 2018-7-19
 * Time: 8:04
 */
namespace app\shop\controller;

use cmf\controller\AdminBaseController;
use think\Db;
use app\shop\model\GoodsCategoryModel;

class AdminGoodsCategoryController extends AdminBaseController
{
    public function index()
    {
        $this->assign('category_tree');
        return $this->fetch();
    }

    public function add()
    {
        $this->assign('categories_tree');
        $this->assign('list_theme_files');
        $this->assign('article_theme_files');
        return $this->fetch();
    }

    public function addPost()
    {
        $goodsCategoryModel = new GoodsCategoryModel();

        $data = $this->request->param();
        var_dump($data);
        $result = $this->validate($data, 'PortalCategory');

        if ($result !== true) {
            $this->error($result);
        }

        $result = $goodsCategoryModel->addGoodsCategory($data);

        if ($result === false) {
            $this->error('添加失败!');
        }

        $this->success('添加成功!', url('AdminGoodsCategory/index'));

    }
}