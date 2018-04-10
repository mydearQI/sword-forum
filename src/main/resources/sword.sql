/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.12-log : Database - sword
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sword` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `sword`;

/*Table structure for table `addfriend` */

DROP TABLE IF EXISTS `addfriend`;

CREATE TABLE `addfriend` (
  `aid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `fromuid` bigint(20) NOT NULL COMMENT '发出请求方',
  `touid` bigint(20) NOT NULL COMMENT '接受请求方',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间',
  `staus` varchar(20) NOT NULL COMMENT '‘接受’，‘拒绝’，等待',
  `flag` int(11) DEFAULT '0' COMMENT '0未改变1改变状态',
  PRIMARY KEY (`aid`),
  KEY `fromuid` (`fromuid`),
  KEY `touid` (`touid`),
  CONSTRAINT `addfriend_ibfk_1` FOREIGN KEY (`fromuid`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `addfriend_ibfk_2` FOREIGN KEY (`touid`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='申请添加好友持久化记录';

/*Data for the table `addfriend` */

insert  into `addfriend`(`aid`,`fromuid`,`touid`,`time`,`staus`,`flag`) values (1,4,1,'2017-06-06 03:31:26','接受',1);

/*Table structure for table `comment` */

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `cid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论自增id',
  `ctid` bigint(20) NOT NULL COMMENT '所属帖子',
  `cuid` bigint(20) NOT NULL COMMENT '回帖人',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '时间',
  `content` varchar(50) NOT NULL COMMENT '内容',
  `rootcid` bigint(20) DEFAULT '0' COMMENT '对于的根评论cid',
  `parentuid` bigint(20) DEFAULT '0' COMMENT '根评论下对谁说用户id',
  `czan` bigint(20) DEFAULT '0' COMMENT '点赞',
  `isread` int(11) DEFAULT '0' COMMENT '0未读1已读',
  `parentcid` bigint(20) DEFAULT '0' COMMENT '直接评论下的间接评论',
  PRIMARY KEY (`cid`),
  KEY `ctid` (`ctid`),
  KEY `cuid` (`cuid`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`ctid`) REFERENCES `topic` (`tid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`cuid`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

/*Data for the table `comment` */

insert  into `comment`(`cid`,`ctid`,`cuid`,`ctime`,`content`,`rootcid`,`parentuid`,`czan`,`isread`,`parentcid`) values (26,32,1,'2017-06-04 15:09:01','112213412423',0,0,0,1,0),(31,32,1,'2017-06-04 16:08:24','阿斯达所',0,0,0,1,0),(32,32,1,'2017-06-04 16:08:28','多少分公司的根深蒂固',26,0,0,1,0),(33,32,1,'2017-06-04 16:08:34','成本持续宣传v',26,0,0,1,0),(34,32,1,'2017-06-04 16:08:38','2额外企鹅全文',26,1,0,1,32),(35,25,1,'2017-06-04 16:38:09','根评论1',0,0,0,1,0),(36,25,1,'2017-06-04 16:38:14','根评论2',0,0,0,1,0),(37,25,1,'2017-06-04 16:38:21','直接评论1',35,0,0,1,0),(38,16727,4,'2017-06-06 03:14:51','很棒很Nice',0,0,0,1,0);

/*Table structure for table `concern` */

DROP TABLE IF EXISTS `concern`;

CREATE TABLE `concern` (
  `conid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '关注自增id',
  `confromuid` bigint(20) NOT NULL COMMENT '关注方',
  `contouid` bigint(20) NOT NULL COMMENT '被关注方',
  PRIMARY KEY (`conid`),
  KEY `confromuid` (`confromuid`),
  KEY `contouid` (`contouid`),
  CONSTRAINT `concern_ibfk_1` FOREIGN KEY (`confromuid`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `concern_ibfk_2` FOREIGN KEY (`contouid`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `concern` */

insert  into `concern`(`conid`,`confromuid`,`contouid`) values (1,1,2),(2,2,1),(3,4,1);

/*Table structure for table `dz` */

DROP TABLE IF EXISTS `dz`;

CREATE TABLE `dz` (
  `dzid` bigint(20) NOT NULL AUTO_INCREMENT,
  `dzfromuid` bigint(20) NOT NULL,
  `dztopicid` bigint(20) NOT NULL COMMENT '点赞的文章，只能赞一次',
  `dztime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`dzid`),
  KEY `dzfromuid` (`dzfromuid`),
  KEY `dz_ibfk_3` (`dztopicid`),
  CONSTRAINT `dz_ibfk_1` FOREIGN KEY (`dzfromuid`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dz_ibfk_3` FOREIGN KEY (`dztopicid`) REFERENCES `topic` (`tid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `dz` */

/*Table structure for table `friend` */

DROP TABLE IF EXISTS `friend`;

CREATE TABLE `friend` (
  `fid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `fromuid` bigint(20) NOT NULL COMMENT '用户a，发出申请方',
  `touid` bigint(20) NOT NULL COMMENT '用户b，接受申请方',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间',
  PRIMARY KEY (`fid`),
  KEY `touid` (`touid`),
  CONSTRAINT `friend_ibfk_1` FOREIGN KEY (`touid`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='好友列表';

/*Data for the table `friend` */

insert  into `friend`(`fid`,`fromuid`,`touid`,`time`) values (9,-1,1,'2017-05-15 21:54:13'),(10,-1,2,'2017-05-16 09:30:06'),(11,-1,3,'2017-05-16 09:34:38'),(12,2,1,'2017-05-16 14:16:35'),(13,-1,4,'2017-06-06 03:10:55'),(14,4,1,'2017-06-06 03:31:26');

/*Table structure for table `logtable` */

DROP TABLE IF EXISTS `logtable`;

CREATE TABLE `logtable` (
  `lid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `uid` bigint(20) NOT NULL COMMENT '用户Id',
  `ip` varchar(32) DEFAULT NULL COMMENT '用户ip',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `type` int(11) NOT NULL COMMENT '1登录2退出3修改密码4忘记密码再修改5发表文章6删除文章7发表评论8删除评论',
  PRIMARY KEY (`lid`),
  KEY `uid` (`uid`),
  CONSTRAINT `logtable_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;

/*Data for the table `logtable` */

insert  into `logtable`(`lid`,`uid`,`ip`,`time`,`type`) values (1,2,'127.0.0.1','2017-05-16 09:30:16',1),(2,2,'127.0.0.1','2017-05-16 09:33:15',1),(3,2,'127.0.0.1','2017-05-16 09:33:58',2),(4,3,'127.0.0.1','2017-05-16 09:34:48',1),(5,1,'127.0.0.1','2017-05-16 09:53:49',1),(6,1,'127.0.0.1','2017-05-16 14:04:55',1),(7,1,'127.0.0.1','2017-05-17 11:08:30',1),(8,1,'127.0.0.1','2017-05-22 11:27:18',1),(9,1,'127.0.0.1','2017-05-22 13:35:16',1),(10,1,'127.0.0.1','2017-05-22 13:35:52',7),(11,1,'127.0.0.1','2017-05-23 16:39:27',1),(12,1,'127.0.0.1','2017-05-23 16:40:14',2),(13,2,'127.0.0.1','2017-05-23 16:40:49',1),(14,2,'127.0.0.1','2017-05-23 16:42:24',7),(15,2,'127.0.0.1','2017-05-23 16:46:21',5),(16,2,'127.0.0.1','2017-05-23 16:48:51',7),(17,2,'127.0.0.1','2017-05-23 16:48:58',7),(18,2,'127.0.0.1','2017-05-23 16:49:11',7),(19,2,'127.0.0.1','2017-05-23 16:49:18',7),(20,2,'127.0.0.1','2017-05-23 16:49:48',7),(21,2,'127.0.0.1','2017-05-23 16:49:55',7),(22,2,'127.0.0.1','2017-05-23 16:50:03',7),(23,2,'127.0.0.1','2017-05-23 16:50:13',7),(24,2,'127.0.0.1','2017-05-23 16:55:55',2),(25,1,'127.0.0.1','2017-05-23 17:20:58',1),(26,1,'127.0.0.1','2017-05-23 17:22:17',2),(27,1,'127.0.0.1','2017-05-27 06:33:44',1),(28,1,'127.0.0.1','2017-05-27 16:58:06',1),(29,1,'127.0.0.1','2017-05-27 18:38:05',1),(30,1,'127.0.0.1','2017-05-27 19:11:16',1),(31,1,'127.0.0.1','2017-05-27 19:12:10',5),(32,1,'127.0.0.1','2017-05-27 19:17:58',5),(33,1,'127.0.0.1','2017-05-29 13:21:35',1),(34,1,'127.0.0.1','2017-05-31 20:11:46',1),(35,1,'127.0.0.1','2017-06-03 15:23:34',1),(36,1,'127.0.0.1','2017-06-03 15:39:07',1),(37,1,'127.0.0.1','2017-06-03 15:39:36',1),(38,1,'127.0.0.1','2017-06-03 15:53:04',1),(39,1,'127.0.0.1','2017-06-03 15:54:25',1),(40,1,'127.0.0.1','2017-06-03 16:04:43',1),(41,2,'127.0.0.1','2017-06-03 16:05:52',1),(42,2,'127.0.0.1','2017-06-03 16:06:33',2),(43,1,'127.0.0.1','2017-06-03 16:06:52',2),(44,1,'127.0.0.1','2017-06-03 18:54:17',1),(45,1,'127.0.0.1','2017-06-03 18:55:38',7),(46,1,'127.0.0.1','2017-06-03 18:55:45',7),(47,1,'127.0.0.1','2017-06-03 18:55:56',7),(48,1,'127.0.0.1','2017-06-03 18:57:17',7),(49,1,'127.0.0.1','2017-06-03 18:57:25',7),(50,1,'127.0.0.1','2017-06-03 18:57:33',7),(51,1,'127.0.0.1','2017-06-03 18:57:40',7),(52,1,'127.0.0.1','2017-06-03 18:57:55',7),(53,1,'127.0.0.1','2017-06-03 19:02:28',2),(54,2,'127.0.0.1','2017-06-03 19:06:54',1),(55,2,'127.0.0.1','2017-06-03 19:07:19',7),(56,1,'127.0.0.1','2017-06-03 23:05:56',1),(57,1,'127.0.0.1','2017-06-03 23:06:12',7),(58,1,'127.0.0.1','2017-06-03 23:10:43',7),(59,1,'127.0.0.1','2017-06-03 23:29:57',7),(60,1,'127.0.0.1','2017-06-03 23:49:05',7),(61,1,'127.0.0.1','2017-06-03 23:53:35',7),(62,1,'127.0.0.1','2017-06-04 00:11:00',7),(63,1,'127.0.0.1','2017-06-04 15:01:33',1),(64,1,'127.0.0.1','2017-06-04 15:09:01',7),(65,1,'127.0.0.1','2017-06-04 15:13:39',7),(66,1,'127.0.0.1','2017-06-04 15:13:44',7),(67,1,'127.0.0.1','2017-06-04 15:13:50',7),(68,1,'127.0.0.1','2017-06-04 15:13:55',7),(69,1,'127.0.0.1','2017-06-04 15:18:01',8),(70,1,'127.0.0.1','2017-06-04 15:20:08',8),(71,1,'127.0.0.1','2017-06-04 15:20:09',8),(72,1,'127.0.0.1','2017-06-04 15:20:10',8),(73,1,'127.0.0.1','2017-06-04 15:58:18',1),(74,1,'127.0.0.1','2017-06-04 16:08:24',7),(75,1,'127.0.0.1','2017-06-04 16:08:28',7),(76,1,'127.0.0.1','2017-06-04 16:08:34',7),(77,1,'127.0.0.1','2017-06-04 16:08:38',7),(78,1,'127.0.0.1','2017-06-04 16:37:46',1),(79,1,'127.0.0.1','2017-06-04 16:38:09',7),(80,1,'127.0.0.1','2017-06-04 16:38:14',7),(81,1,'127.0.0.1','2017-06-04 16:38:21',7),(82,1,'127.0.0.1','2017-06-04 19:58:18',1),(83,1,'127.0.0.1','2017-06-04 20:08:24',2),(84,2,'127.0.0.1','2017-06-04 20:08:37',1),(85,2,'127.0.0.1','2017-06-04 20:09:48',2),(86,1,'127.0.0.1','2017-06-04 20:09:56',1),(87,1,'127.0.0.1','2017-06-04 22:32:32',1),(88,1,'127.0.0.1','2017-06-04 22:47:44',5),(89,1,'127.0.0.1','2017-06-04 22:47:51',2),(90,2,'127.0.0.1','2017-06-04 22:48:25',1),(91,1,'127.0.0.1','2017-06-05 16:48:11',1),(92,1,'127.0.0.1','2017-06-06 03:09:37',1),(93,1,'127.0.0.1','2017-06-06 03:10:08',2),(94,4,'127.0.0.1','2017-06-06 03:11:14',1),(95,4,'127.0.0.1','2017-06-06 03:14:51',7),(96,4,'127.0.0.1','2017-06-06 03:15:02',2),(97,1,'127.0.0.1','2017-06-06 03:15:09',1);

/*Table structure for table `manage` */

DROP TABLE IF EXISTS `manage`;

CREATE TABLE `manage` (
  `mid` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员自增id',
  `mname` varchar(20) NOT NULL COMMENT '名字',
  `mpassword` varchar(30) NOT NULL COMMENT '密码',
  `msex` int(11) DEFAULT '0' COMMENT '性别',
  `mrole` int(11) DEFAULT '1' COMMENT '0超管1普管',
  `memail` varchar(30) NOT NULL COMMENT 'E-mail',
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `manage` */

insert  into `manage`(`mid`,`mname`,`mpassword`,`msex`,`mrole`,`memail`) values (1,'admin','admin',0,0,'530735771@qq.com');

/*Table structure for table `section` */

DROP TABLE IF EXISTS `section`;

CREATE TABLE `section` (
  `sid` int(11) NOT NULL AUTO_INCREMENT COMMENT '板块自增Id',
  `sname` varchar(20) NOT NULL COMMENT '板块名字',
  `smasterid` bigint(20) NOT NULL COMMENT '对于user表的用户id',
  `sstatement` varchar(300) NOT NULL COMMENT '详细描述',
  `sshortsm` varchar(30) DEFAULT NULL COMMENT '简要描述',
  `sclickcount` bigint(20) DEFAULT '0' COMMENT '访问量',
  `stopiccount` bigint(20) DEFAULT '0' COMMENT '帖子量',
  `sparentname` varchar(20) NOT NULL DEFAULT '0' COMMENT '父级菜单名称',
  PRIMARY KEY (`sid`),
  KEY `smasterid` (`smasterid`),
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`smasterid`) REFERENCES `user` (`uid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

/*Data for the table `section` */

insert  into `section`(`sid`,`sname`,`smasterid`,`sstatement`,`sshortsm`,`sclickcount`,`stopiccount`,`sparentname`) values (1,'技术问答',1,'把你的问题提出来，给大神解答吧！','有什么问题来这里提吧',24,2,'0'),(2,'java',1,'Java是一门面向对象编程语言，不仅吸收了C++语言的各种优点，还摒弃了C++里难以理解的多继承、指针等概念，因此Java语言具有功能强大和简单易用两个特征。Java语言作为静态面向对象编程语言的代表，极好地实现了面向对象理论，允许程序员以优雅的思维方式进行复杂的编程','java编程',46,6,'技术分享'),(3,'c/c++ ',1,'C语言是在70年代初问世的。一九七八年由美国电话电报公司(AT&T)贝尔实验室正式发表了C语言。同时由B.W.Kernighan和D.M.Ritchit合著了著名的“THE C PROGRAMMING LANGUAGE”一书。通常简称为《K&R》，也有人称之为《K&R》标准。但是，在《K&R》中并没有定义一个完整的标准C语言，后来由美国国家标准学会在此基础上制定了一个C 语言标准，于一九八三年发表。通常称之为ANSI C','c/c++编程',61,0,'技术分享'),(4,'python',1,'Python具有丰富和强大的库。它常被昵称为胶水语言，能够把用其他语言制作的各种模块（尤其是C/C++）很轻松地联结在一起。常见的一种应用情形是，使用Python快速生成程序的原型（有时甚至是程序的最终界面），然后对其中[3]  有特别要求的部分，用更合适的语言改写，比如3D游戏中的图形渲染模块，性能要求特别高，就可以用C/C++重写，而后封装为Python可以调用的扩展类库。需要注意的是在您使用扩展类库时可能需要考虑平台问题，某些可能不提供跨平台的实现。','python编程',38,0,'技术分享'),(5,'情感部落',1,'在这里你可以宣泄一切情感遭遇，可以深情表白，还可以晒情侣幸福合照。情感','感情的碰撞',25,0,'情感'),(6,'真情天下',1,'深夜，安静的角落，听听心里的声音','天下有真情',22,0,'情感'),(7,'婆媳关系',1,'复杂的婆媳关系','婆媳关系',10,0,'情感'),(8,'仗剑杂谈',1,'本论坛的杂谈','本论坛的杂谈',16,1,'杂谈'),(9,'医疗曝光',1,'医疗曝光','医疗的曝光',15,0,'杂谈'),(10,'大话教育',1,'教育对于一个人的成长很重要','说说学校与家庭的教育',15,1,'杂谈'),(11,'娱乐八卦',1,'看看身边乃至娱乐圈的八卦','我们一起来八卦',10,0,'娱乐'),(12,'体育沙龙',1,'体育最近状况咱们来聊聊','体育体育',7,0,'娱乐'),(13,'星座论坛',1,'你是什么座，我们般配吗','你是什么座，我们般配吗',7,0,'娱乐'),(14,'保健养生',1,'保健养生','保健养生',36,0,'生活'),(15,'文化漫谈',1,'各路各国文化杂谈','探究文化',13,0,'生活'),(16,'手机综艺',1,'手机的各种资料','手机综艺',6,0,'生活'),(19,'英雄联盟',1,'《英雄联盟》(简称LOL)是由美国拳头游戏(Riot Games)开发、中国大陆地区腾讯游戏代理运营的英雄对战MOBA竞技网游。\n游戏里拥有数百个个性英雄，并拥有排位系统、天赋系统、符文系统等特色养成系统。\n《英雄联盟》还致力于推动全球电子竞技的发展，除了联动各赛区发展职业联赛、打造电竞体系之外，每年还会举办“季中冠军赛”“全球总决赛”“All Star全明星赛”三大世界级赛事，获得了亿万玩家的喜爱，形成了自己独有的电子竞技文化。','一起战斗吧',29,1,'网络游戏'),(100,'箐箐校园',1,'箐箐校园','箐箐校园',58,702,'南昌航空大学');

/*Table structure for table `sixin` */

DROP TABLE IF EXISTS `sixin`;

CREATE TABLE `sixin` (
  `siid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增私信id',
  `sifromuid` bigint(20) NOT NULL COMMENT '为了让系统发消息，-1代表系统，不用外键',
  `sitouid` bigint(20) NOT NULL COMMENT '接受方',
  `content` text NOT NULL COMMENT '为了丰富以后内容是由text',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  `isread` int(11) DEFAULT '0' COMMENT '0默认未读，1已读',
  PRIMARY KEY (`siid`),
  KEY `sifromuid` (`sifromuid`),
  KEY `sitouid` (`sitouid`),
  CONSTRAINT `sixin_ibfk_2` FOREIGN KEY (`sitouid`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `sixin` */

insert  into `sixin`(`siid`,`sifromuid`,`sitouid`,`content`,`time`,`isread`) values (1,-1,2,'<p style=\'color:grern\'>欢迎使用仗剑论坛，有你的世界更精彩!<br/>  <small> 站长：李胜助</small></p>','2017-05-16 09:30:05',1),(2,-1,3,'<p style=\'color:grern\'>欢迎使用仗剑论坛，有你的世界更精彩!<br/>  <small> 站长：李胜助</small></p>','2017-05-16 09:34:38',1),(3,1,2,'sfsdfsdf','2017-05-16 14:47:06',1),(4,1,2,'dasdasf','2017-05-16 14:47:11',1),(5,1,2,'855','2017-05-16 15:19:13',1),(6,-1,4,'<p style=\'color:grern\'>欢迎使用仗剑论坛，有你的世界更精彩!<br/>  <small> 站长：李胜助</small></p>','2017-06-06 03:10:54',1);

/*Table structure for table `topic` */

DROP TABLE IF EXISTS `topic`;

CREATE TABLE `topic` (
  `tid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '帖子自增id',
  `tsid` int(11) NOT NULL COMMENT '所属板块',
  `tuid` bigint(20) NOT NULL COMMENT '发帖人',
  `ttopic` varchar(50) NOT NULL COMMENT '主题',
  `tcontent` longtext NOT NULL COMMENT '内容',
  `ttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `treplaycount` bigint(20) DEFAULT '0' COMMENT '回帖量',
  `tclickcount` bigint(20) DEFAULT '0' COMMENT '点击量',
  `tlastclicktime` datetime DEFAULT NULL COMMENT '上次访问时间',
  `tstaus` int(11) DEFAULT '0' COMMENT '0不置顶1置顶',
  `tzan` bigint(20) DEFAULT '0' COMMENT '点赞量',
  PRIMARY KEY (`tid`),
  KEY `tsid` (`tsid`),
  KEY `tuid` (`tuid`),
  KEY `ttopic` (`ttopic`),
  CONSTRAINT `topic_ibfk_1` FOREIGN KEY (`tsid`) REFERENCES `section` (`sid`) ON DELETE CASCADE,
  CONSTRAINT `topic_ibfk_2` FOREIGN KEY (`tuid`) REFERENCES `user` (`uid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16728 DEFAULT CHARSET=utf8;

/*Data for the table `topic` */


/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增用户id',
  `uemail` varchar(20) NOT NULL COMMENT 'email账号',
  `upassword` varchar(30) NOT NULL COMMENT '密码',
  `unickname` varchar(20) NOT NULL COMMENT '昵称',
  `usex` int(11) DEFAULT '0' COMMENT '性别',
  `ubirthday` date DEFAULT NULL COMMENT '生日',
  `ulevel` int(11) DEFAULT '1' COMMENT '等级',
  `headimg` varchar(30) DEFAULT 'defaulthead.jpg' COMMENT '头像',
  `ustatement` varchar(30) DEFAULT '此人很懒，没什么个人说明' COMMENT '个人描述',
  `uregtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `ustate` int(11) DEFAULT '0' COMMENT '被封状态',
  `upoint` int(11) DEFAULT '0' COMMENT '积分',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uemail` (`uemail`,`unickname`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`uid`,`uemail`,`upassword`,`unickname`,`usex`,`ubirthday`,`ulevel`,`headimg`,`ustatement`,`uregtime`,`ustate`,`upoint`) values (1,'530735771@qq.com','123456','李胜助',0,'1994-10-16',3,'120170531201216.png','仗剑论坛创始人！','2017-03-06 17:04:24',0,302),(2,'111111@qq.com','123456','测试2',1,NULL,1,'defaulthead.jpg','此人很懒，没什么个人说明','2017-05-16 09:30:05',0,48),(3,'222222@qq.com','123456','测试3',0,NULL,1,'defaulthead.jpg','此人很懒，没什么个人说明','2017-05-16 09:34:38',0,10),(4,'2512634475@qq.com','123456','帅哥不是罪',0,NULL,1,'defaulthead.jpg','此人很懒，没什么个人说明','2017-06-06 03:10:54',0,10);

/*Table structure for table `yqlj` */

DROP TABLE IF EXISTS `yqlj`;

CREATE TABLE `yqlj` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ljname` varchar(255) DEFAULT NULL,
  `ljurl` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `yqlj` */

insert  into `yqlj`(`id`,`ljname`,`ljurl`,`filename`) values (1,'百度','http://www.baidu.com','201207021739570007.bmp'),(2,'google','http://www.google.com','201207021424190002.gif'),(3,'优酷','http://www.youku.com','201207021726330001.png'),(4,'淘宝','http://www.taobao.com','201207021729150002.png'),(5,'支付宝','https://www.alipay.com/','201207021731270003.png'),(6,'淘宝联盟','http://www.alimama.com/','201207021733380005.bmp'),(7,'一淘网','http://www.etao.com/?tbpm=t','201207021735520006.png');

/* Trigger structure for table `comment` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `addTopicCommentCount` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `addTopicCommentCount` AFTER INSERT ON `comment` FOR EACH ROW BEGIN
	update topic set treplaycount=treplaycount+1 where tid=new.ctid;
    END */$$


DELIMITER ;

/* Trigger structure for table `comment` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `deleteTopicCommentCount` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `deleteTopicCommentCount` AFTER DELETE ON `comment` FOR EACH ROW BEGIN
	UPDATE topic SET treplaycount=treplaycount-1 WHERE tid=old.ctid;
    END */$$


DELIMITER ;

/* Trigger structure for table `topic` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `addStopicCount` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `addStopicCount` AFTER INSERT ON `topic` FOR EACH ROW BEGIN
	update section set stopiccount=stopiccount+1 where sid=new.tsid;
    END */$$


DELIMITER ;

/* Trigger structure for table `topic` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `deleteStopicCount` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `deleteStopicCount` AFTER DELETE ON `topic` FOR EACH ROW BEGIN
	UPDATE section SET stopiccount=stopiccount-1 WHERE sid=old.tsid;
    END */$$


DELIMITER ;

/*!50106 set global event_scheduler = 1*/;

/* Event structure for event `DeleteUstate` */

/*!50106 DROP EVENT IF EXISTS `DeleteUstate`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`root`@`localhost` EVENT `DeleteUstate` ON SCHEDULE EVERY 1 DAY STARTS '2017-04-20 16:38:08' ON COMPLETION PRESERVE ENABLE DO BEGIN
	    UPDATE USER SET ustate=ustate-1 WHERE ustate>0;
	END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;