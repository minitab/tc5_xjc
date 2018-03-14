-- ----------------------------
-- Table structure for `cmf_user`
-- ----------------------------
CREATE TABLE `cmf_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型;1:admin;2:会员',
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '性别;0:保密,1:男,2:女',
  `birthday` int(11) NOT NULL DEFAULT '0' COMMENT '生日',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `coin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `user_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态;0:禁用,1:正常,2:未验证',
  `user_login` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pass` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码;cmf_password加密',
  `user_nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `user_email` varchar(100) NOT NULL DEFAULT '' COMMENT '用户登录邮箱',
  `user_url` varchar(100) NOT NULL DEFAULT '' COMMENT '用户个人网址',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT '个性签名',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '用户手机号',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `user_login` (`user_login`),
  KEY `user_nickname` (`user_nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';



-- ----------------------------
-- Table structure for `cmf_goods_category`
-- ----------------------------
CREATE TABLE `cmf_goods_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类父id',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '分类描述',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '分类层级关系路径',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序：值越小排越前面',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态：-1删除；0无效；1有效',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';

-- ----------------------------
-- Table structure for `cmf_goods`
-- ----------------------------
CREATE TABLE `cmf_goods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `sn`
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商品名称',
  `cate_id` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '产品分类id',
  `img` varchar(255) NOT NULL DEFAULT '' COMMENT '商品详情图',
  `thumb` varchar(500) NOT NULL DEFAULT '' COMMENT '商品缩略图',
  `brief` varchar(500) NOT NULL DEFAULT '' COMMENT '商品简介',
  `description` text COMMENT '商品详情',
  `description_filtered` text COMMENT '处理过的商品详情',
  `keywords` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `price`
  `preferential_price`
  `brand` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '品牌',
  `model` varchar(255) NOT NULL DEFAULT '' COMMENT '型号',
  `unit_id`
  `stock`
  `selled_num`
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '商品创建用户id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `up_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上架时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `is_selling` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否上架:0下架;1上架',
  `is_new` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否新品:0非新品;1新品',
  `is_hot` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否热销:0非热销;1热销',
  `is_top` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶:0不置顶;1置顶',
  `is_recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐:0不推荐;1推荐',
  `post_hits` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '查看数',
  `post_like` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  `comment_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '评论状态;1:允许;0:不允许',
  `comment_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态：-1删除；0未审核；1已审核',
  `more` text COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`),
  KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`),
  KEY `parent_id` (`parent_id`),
  KEY `user_id` (`user_id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';


4. 套餐表combo（套餐不能修改或删除，只能下架）

字段 | 类型（长度） | NULL/默认 | 特殊 | 备注
:---:|:---:|:---:|:---:|:---:
id | int(11) unsigned| | PRIMARY KEY | 主键
combo_name | varchar(32) | | | 套餐名
combo_price | float(11,2) | 0.00 | | 套餐价格
combo_unit | varchar(8) | 套 | | 套餐单位：套
create_time | varchar(16) | | | 创建时间
create_author_id | int(11) | | | 创建者id
modify_time | varchar(11) | NULL | | 最近修改时间
modify_author_id | int(11) | NULL | | 最近修改者id
type | tinyint(1) | | | 类型：1系统创建；2用户创建
is_selling | tinyint(1) | 1 | | 是否上架：0下架；1上架
status | tinyint(1) | 0 | | 状态：-1删除；0未启用；1启用
5. 套餐商品信息combo_info

字段 | 类型（长度） | NULL/默认 | 特殊 | 备注
:---:|:---:|:---:|:---:|:---:
id | int(11) unsigned | | PRIMARY KEY | 主键
combo_id | int(11) | | | 套餐id
goods_id | int(11) | | | 商品id
goods_num | int(11) | | | 商品数量
goods_price | float(11,2) | | | 商品单价
add_time | varchar(16) | | | 添加时间
add_author_id | int(11) | | | 添加者
type | tinyint(1) | | | 类型：1一红；2二举；3三红；4四进；5对堂；6状元
sort | tinyint(2) | | | 排序：值越大排越后面
status | tinyint(1) | | | 状态：-1删除 0正常
6. 订单order

字段 | 类型（长度） | NULL/默认 | 特殊 | 备注
:---:|:---:|:---:|:---:|:---:
id | int(11) unsigned| | PRIMARY KEY | 主键
order_sn | varchar(24) | | | 套餐名
create_uid | int(11) | | | 创建者id
create_time | varchar(16) | | | 创建时间
type | tinyint(1) | | | 类型：1普通订单；2积分兑换
is_invoice | tinyint(1) | 0 | | 是否需要发票（积分兑换不能开发票）：0不需要；1需要
invoice_id | int(11) | NULL | | 发票id
modify_time | varchar(16) | NULL | | 最近修改时间
modify_uid | int(11) | NULL | | 最近修改者id
payment | tinyint(1) | | | 支付方式：0线下；1微信
pay_time | varchar(16) | NULL | | 支付时间
invoice_time | varchar(16) | NULL | | 开票时间
develer_time | varchar(16) | NULL | | 发货时间
receive_time | varchar(16) | NULL | | 收货时间
check_uid | int(11) | NULL | | 结单确认人id
status | tinyint(1) | 0 | | 状态：-1删除；0退单；1正常；9结单

7. 订单商品信息order_info（需要保存下单当时商品或套餐的详细信息，避免商品或套餐被更改导致旧的订单信息错误）

字段 | 类型（长度） | NULL/默认 | 特殊 | 备注
:---:|:---:|:---:|:---:|:---:
id | int(11) unsigned| | PRIMARY KEY | 主键
order_id | int(11) | | | 订单id
goods_id | int(11) | | | 商品id或套餐id
goods_num | int(11) | | | 数量
goods_unit | varchar(8) | | | 单位
goods_price | float(11,2) | | | 商品单价或套餐单价
type | tinyint(1) | | | 类型：1普通商品；2套餐
is_special tinyint(1) | 0 | | | 是否特价：0否；1特价
add_time | varchar(16) | | | 添加时间
status | tinyint(1) | 0 | | 状态：-1删除；0正常
del_time | varchar(16) | | | 删除时间
8. 收货地址address

字段 | 类型（长度） | NULL/默认 | 特殊 | 备注
:---:|:---:|:---:|:---:|:---:
id | int(11) unsigned| | PRIMARY KEY | 主键
uid | int(11) | | | 用户id
province | int(11) | | | 省份
city | int(11) | | | 市
county | int(11) | | | 区县
address | varchar(255) | | | 详细地址
person | varchar(32) | | | 联系人
phone | varchar(16) | | | 手机号
is_default | tinyint(1) | 0 | | 是否默认地址：0否；1是
9. 发票表invoice

字段 | 类型（长度） | NULL/默认 | 特殊 | 备注
:---:|:---:|:---:|:---:|:---:
id | int(11) unsigned| | PRIMARY KEY | 主键
uid | | | | 用户id
invoice_title | varchar(255) | | | 发票抬头
invoice_no | varchar(24) | | | 税号
invoice_content_type | tinyint(1) | | | 开票内容:1详细清单；2办公用品；3其他
price | float(11,2) | | | 发票金额
tax | float(11,2) | | | 税额
drawer | varchar(32) | | | 开票人
create_time | varchar(16) | | | 开票日期
invoice_remarks | varchar(255) | NULL | | 开票备注
status | | | | 状态：-1删除；0无效；1有效
10. 发票明细表invoice_info

字段 | 类型（长度） | NULL/默认 | 特殊 | 备注
:---:|:---:|:---:|:---:|:---:
id | int(11) unsigned | | PRIMARY KEY | 主键
invoice_id | int(11) | | | 发票id
goods_id | int(11) | | | 商品id（该字段待确认是否可省略，当出现办公用品时没有对应的goods_id）
goods_name | varchar(32) | | | 商品名称
goods_price | float(11,2) | | | 商品单价
goods_num | int(11) | | | 商品数量
tax_rate | float(11,2) | | | 税率
status | tinyint(1) | 1 | | 状态：-1删除；0无效；1有效
11. 公司管理表office

字段 | 类型（长度） | NULL/默认 | 特殊 | 备注
:---:|:---:|:---:|:---:|:---:
id | int(11) unsigned | | PRIMARY KEY | 主键
office_name | varchar(32) | | | 公司名字
office_province | int(11) | | | 公司所在省份
office_city | int(11) | | | 公司所在市
office_county | int(11) | | | 公司所在区县
office_address | varchar(255) | | | 公司所在详细地址
office_phone | varchar(16) | | | 公司电话
invoice_title | varchar(32) | | | 发票抬头
invoice_no | varchar(24) | | | 税号
status | tinyint(1) | 1 | | 状态：-1删除；0不可用；1可用
12. 积分记录表points_log

字段 | 类型（长度） | NULL/默认 | 特殊 | 备注
:---:|:---:|:---:|:---:|:---:
id | int(11) unsigned| | PRIMARY KEY | 主键
uid | int(11) | | | 用户id
type | tinyint(1) | | | 类型：1增加；2减少
points | int(11) | | | 积分
remarks | varchar(255) | | | 备注

13. 充值记录表recharge_log

字段 | 类型（长度） | NULL/默认 | 特殊 | 备注
:---:|:---:|:---:|:---:|:---:
id | int(11) unsigned| | PRIMARY KEY | 主键
uid | int(11) | | | 用户id
type | tinyint(1) | | | 充值方式：0线下；1微信
money | float(11,2) | | | 积分
remarks | varchar(255) | | | 备注