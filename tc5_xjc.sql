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
-- Table structure for `cmf_goods`
-- ----------------------------
DROP TABLE IF EXISTS `cmf_goods`;
CREATE TABLE `cmf_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `sn` varchar(24) NOT NULL DEFAULT '' COMMENT '商品货号',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商品名称',
  `cate_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '产品分类id',
  `images` varchar(255) NOT NULL DEFAULT '' COMMENT '商品详情图',
  `thumbnail` varchar(64) NOT NULL DEFAULT '' COMMENT '商品缩略图',
  `brief` varchar(255) NOT NULL DEFAULT '' COMMENT '商品简介',
  `description` text COMMENT '商品详情',
  `description_filtered` text COMMENT '处理过的商品详情',
  `keywords` varchar(64) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品价格',
  `preferential_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品优惠价',
  `brand` varchar(32) NOT NULL DEFAULT '' COMMENT '品牌',
  `model` varchar(64) NOT NULL DEFAULT '' COMMENT '型号',
  `unit` varchar(8) NOT NULL DEFAULT '' COMMENT '单位',
  `stock` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '库存',
  `sold_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '销量',
  `create_user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品创建用户id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品最后一次更新用户id',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `up_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上架时间',
  `delete_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `is_selling` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否上架:0下架;1上架',
  `is_new` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否新品:0非新品;1新品',
  `is_hot` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否热销:0非热销;1热销',
  `is_top` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶:0不置顶;1置顶',
  `is_recommended` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐:0不推荐;1推荐',
  `post_hits` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '查看数',
  `post_like` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  `comment_status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '评论状态;1:允许;0:不允许',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '状态：-1删除；0未审核；1已审核',
  `more` text COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`),
  KEY `cate_brand_status` (`cate_id`,`brand`,`status`,`id`),
  KEY `sn` (`sn`),
  KEY `name` (`name`),
  KEY `user_id` (`user_id`),
  KEY `create_time` (`create_time`) USING BTREE,
  KEY `up_time` (`up_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- ----------------------------
-- Table structure for `cmf_goods_category`
-- ----------------------------
DROP TABLE IF EXISTS `cmf_goods_category`;
CREATE TABLE `cmf_goods_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分类父id',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '分类名称',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '分类描述',
  `path` varchar(32) NOT NULL DEFAULT '' COMMENT '分类层级关系路径',
  `list_order` int(8) NOT NULL DEFAULT '10000' COMMENT '排序：值越小排越前面',
  `delete_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '状态：-1删除；0无效；1有效',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';

-- ----------------------------
-- Table structure for `cmf_combo`
-- ----------------------------
DROP TABLE IF EXISTS `cmf_combo`;
CREATE TABLE `cmf_combo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '套餐id',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '套餐名称',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '套餐描述',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '套餐价格',
  `unit` varchar(8) NOT NULL DEFAULT '套' COMMENT '单位',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型：1系统创建；2用户创建',
  `create_user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '套餐创建用户id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '套餐最后一次更新用户id',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `is_selling` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否上架:0下架;1上架',
  `list_order` int(8) NOT NULL DEFAULT '10000' COMMENT '排序：值越小排越前面',
  `delete_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '状态：-1删除；0未审核；1已审核',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='套餐表';

-- ----------------------------
-- Table structure for `cmf_combo_info`
-- ----------------------------
DROP TABLE IF EXISTS `cmf_combo_info`;
CREATE TABLE `cmf_combo_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `combo_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '套餐id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `goods_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品数量',
  `goods_unit_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品单价',
  `unit` varchar(8) NOT NULL DEFAULT '' COMMENT '单位',
  `add_user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加用户id',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型：1一红；2二举；3三红；4四进；5对堂；6状元',
  `list_order` int(8) NOT NULL DEFAULT '10000' COMMENT '排序：值越小排越前面',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '状态：-1删除；0未审核；1已审核',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='套餐商品信息表';

-- ----------------------------
-- Table structure for `cmf_order`
-- ----------------------------
DROP TABLE IF EXISTS `cmf_order`;
CREATE TABLE `cmf_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn` varchar(24) NOT NULL DEFAULT '' COMMENT '订单号',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型：1普通订单；2积分兑换',
  `is_invoice` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否需要发票（积分兑换不能开发票）：0不需要；1需要',
  `invoice_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发票id',
  `create_user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单创建用户id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单最后一次更新用户id',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `payment_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '支付方式：0线下；1微信',
  `pay_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '支付时间',
  `invoice_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '开票时间',
  `develer_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发货时间',
  `receive_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '收货时间',
  `check_uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '结单确认人id',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '状态：-1删除；0退单；1正常；8支付成功；9结单',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- ----------------------------
-- Table structure for `cmf_order_info`
-- ----------------------------
DROP TABLE IF EXISTS `cmf_order_info`;
CREATE TABLE `cmf_order_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id或套餐id',
  `goods_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品或套餐数量',
  `goods_unit_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品或套餐单价',
  `goods_unit` varchar(8) NOT NULL DEFAULT '' COMMENT '商品或套餐单位',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型：1普通商品；2套餐',
  `is_special` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否特价：0否；1特价',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `delete_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '状态：-1删除；1正常',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单商品信息表';

-- ----------------------------
-- Table structure for `cmf_address`
-- ----------------------------
DROP TABLE IF EXISTS `cmf_address`;
CREATE TABLE `cmf_address` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `province_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '省id',
  `province_name` varchar(32) NOT NULL DEFAULT '' COMMENT '省名',
  `city_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '市id',
  `city_name` varchar(32) NOT NULL DEFAULT '' COMMENT '省名',
  `county_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '区县id',
  `county_name` varchar(32) NOT NULL DEFAULT '' COMMENT '省名',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '详细地址',
  `person` varchar(32) NOT NULL DEFAULT '' COMMENT '联系人',
  `mobile` char(16) NOT NULL DEFAULT '' COMMENT '联系电话',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否默认地址：0否；1是',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `delete_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '状态：-1删除；1正常',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `userid_status` (`user_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='收货地址表';
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