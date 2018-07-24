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
use app\shop\model\ShopGoodsCategoryModel;

class AdminGoodsCategoryController extends AdminBaseController
{
    /**
     * 商品分类列表页
     * @return mixed
     */
    public function index()
    {
        $shopGoodsCategoryModel = new ShopGoodsCategoryModel();
        $goodsCategoryTree        = $shopGoodsCategoryModel->adminGoodsCategoryTableTree();

        $this->assign('goods_category_tree', $goodsCategoryTree);
        return $this->fetch();
    }

    /**
     * 添加商品分类
     * @return mixed
     */
    public function add()
    {
        $parentId            = $this->request->param('parent', 0, 'intval');
        $shopGoodsCategoryModel = new ShopGoodsCategoryModel();
        $goodsCategoriesTree      = $shopGoodsCategoryModel->adminGoodsCategoryTree($parentId);

        $this->assign('goods_categories_tree', $goodsCategoriesTree);
        return $this->fetch();
    }

    /**
     * 添加商品分类确认
     */
    public function addPost()
    {
        $data = $this->request->param();
        $result = $this->validate($data, 'AdminGoodsCategory.addPost');
        if ($result !== true) {
            $this->error($result);
        }

        $goodsCategoryModel = new ShopGoodsCategoryModel();
        $result = $goodsCategoryModel->addGoodsCategory($data);
        if ($result === false) {
            $this->error('添加失败!');
        }

        $this->success('添加成功!', url('AdminGoodsCategory/index'));
    }

    /**
     * 编辑文章分类
     */
    public function edit()
    {
        $id = $this->request->param('id', 0, 'intval');
        if ($id > 0) {
            $goodsCategory = ShopGoodsCategoryModel::get($id)->toArray();

            $shopGoodsCategoryModel = new ShopGoodsCategoryModel();
            $goodsCategoriesTree      = $shopGoodsCategoryModel->adminGoodsCategoryTree($goodsCategory['parent_id'], $id);

            $this->assign($goodsCategory);
            $this->assign('goods_categories_tree', $goodsCategoriesTree);
            return $this->fetch();
        } else {
            $this->error('操作错误!');
        }
    }

    /**
     * 编辑文章分类提交
     */
    public function editPost()
    {
        $data = $this->request->param();
        $result = $this->validate($data, 'AdminGoodsCategory.editPost');
        if ($result !== true) {
            $this->error($result);
        }

        $shopGoodsCategoryModel = new ShopGoodsCategoryModel();
        $result = $shopGoodsCategoryModel->editGoodsCategory($data);
        if ($result === false) {
            $this->error('保存失败!');
        }

        $this->success('保存成功!');
    }

    /**
     * 文章分类选择对话框
     */
    public function select()
    {
        $ids                 = $this->request->param('ids');
        $selectedIds         = explode(',', $ids);
        $portalCategoryModel = new PortalCategoryModel();

        $tpl = <<<tpl
<tr class='data-item-tr'>
    <td>
        <input type='checkbox' class='js-check' data-yid='js-check-y' data-xid='js-check-x' name='ids[]'
               value='\$id' data-name='\$name' \$checked>
    </td>
    <td>\$id</td>
    <td>\$spacer <a href='\$url' target='_blank'>\$name</a></td>
</tr>
tpl;

        $categoryTree = $portalCategoryModel->adminCategoryTableTree($selectedIds, $tpl);

        $where      = ['delete_time' => 0];
        $categories = $portalCategoryModel->where($where)->select();

        $this->assign('categories', $categories);
        $this->assign('selectedIds', $selectedIds);
        $this->assign('categories_tree', $categoryTree);
        return $this->fetch();
    }

    /**
     * 文章分类排序
     */
    public function listOrder()
    {
        parent::listOrders(model('shop_goods_category'));
        $this->success("排序更新成功！", '');
    }

    /**
     * 删除文章分类
     */
    public function delete()
    {
        $shopGoodsCategoryModel = new ShopGoodsCategoryModel();
        $id                  = $this->request->param('id');
        //获取删除的内容
        $findGoodsCategory = $shopGoodsCategoryModel->where('id', $id)->find();

        if (empty($findGoodsCategory)) {
            $this->error('分类不存在!');
        }
        //判断此分类有无子分类（不算被删除的子分类）
        $goodsCategoryChildrenCount = $shopGoodsCategoryModel->where(['parent_id' => $id,'delete_time' => 0])->count();

        if ($goodsCategoryChildrenCount > 0) {
            $this->error('此分类有子类无法删除!');
        }

        $categoryGoodsCount = model('shop_goods')->where('category_id', $id)->count();

        if ($categoryGoodsCount > 0) {
            $this->error('此分类有商品无法删除!');
        }

        $data   = [
            'object_id'   => $findGoodsCategory['id'],
            'create_time' => time(),
            'table_name'  => 'shop_goods_category',
            'name'        => $findGoodsCategory['name']
        ];
        $result = $shopGoodsCategoryModel
            ->where('id', $id)
            ->update(['delete_time' => time()]);
        if ($result) {
            Db::name('recycleBin')->insert($data);
            $this->success('删除成功!');
        } else {
            $this->error('删除失败');
        }
    }
}