<?php
/**
 * Created by PhpStorm.
 * User: Goodboy
 * Date: 2018-7-20
 * Time: 8:03
 */
namespace app\shop\model;

use app\admin\model\RouteModel;
use think\Model;
use tree\Tree;

class GoodsCategoryModel extends Model
{
    protected $connection = [
        'prefix'      => 'shop_',
    ];

    /**
     * 添加商品分类
     * @param $data
     * @return bool
     */
    public function addGoodsCategory($data)
    {
        $result = true;
        self::startTrans();
        try {
            if (!empty($data['more']['thumbnail'])) {
                $data['more']['thumbnail'] = cmf_asset_relative_url($data['more']['thumbnail']);
            }
            $this->allowField(true)->save($data);
            $id = $this->id;
            if (empty($data['parent_id'])) {

                $this->where( ['id' => $id])->update(['path' => '0-' . $id]);
            } else {
                $parentPath = $this->where('id', intval($data['parent_id']))->value('path');
                $this->where( ['id' => $id])->update(['path' => "$parentPath-$id"]);

            }
            self::commit();
        } catch (\Exception $e) {
            self::rollback();
            $result = false;
        }

        if ($result != false) {
            //设置别名
            $routeModel = new RouteModel();
            if (!empty($data['alias']) && !empty($id)) {
                $routeModel->setRoute($data['alias'], 'portal/List/index', ['id' => $id], 2, 5000);
                $routeModel->setRoute($data['alias'] . '/:id', 'portal/Article/index', ['cid' => $id], 2, 4999);
            }
            $routeModel->getRoutes(true);
        }

        return $result;
    }

}