-- --------------------------------------------------------
-- Host:                         evma.mysql.database.azure.com
-- Server version:               5.6.39-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for db_ema
CREATE DATABASE IF NOT EXISTS `db_ema` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db_ema`;

-- Dumping structure for table db_ema.admin_groups
CREATE TABLE IF NOT EXISTS `admin_groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table db_ema.admin_groups: ~4 rows (approximately)
DELETE FROM `admin_groups`;
/*!40000 ALTER TABLE `admin_groups` DISABLE KEYS */;
INSERT INTO `admin_groups` (`id`, `name`, `description`) VALUES
	(1, 'webmaster', 'Webmaster'),
	(2, 'admin', 'Administrator'),
	(3, 'manager', 'Manager'),
	(4, 'staff', 'Staff');
/*!40000 ALTER TABLE `admin_groups` ENABLE KEYS */;

-- Dumping structure for table db_ema.admin_login_attempts
CREATE TABLE IF NOT EXISTS `admin_login_attempts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table db_ema.admin_login_attempts: ~0 rows (approximately)
DELETE FROM `admin_login_attempts`;
/*!40000 ALTER TABLE `admin_login_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_login_attempts` ENABLE KEYS */;

-- Dumping structure for table db_ema.admin_users
CREATE TABLE IF NOT EXISTS `admin_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table db_ema.admin_users: ~4 rows (approximately)
DELETE FROM `admin_users`;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`) VALUES
	(1, '127.0.0.1', 'webmaster', '$2y$08$/X5gzWjesYi78GqeAv5tA.dVGBVP7C1e1PzqnYCVe5s1qhlDIPPES', NULL, NULL, NULL, NULL, NULL, NULL, 1451900190, 1505828204, 1, 'Webmaster', ''),
	(2, '127.0.0.1', 'admin', '$2y$08$7Bkco6JXtC3Hu6g9ngLZDuHsFLvT7cyAxiz1FzxlX5vwccvRT7nKW', NULL, NULL, NULL, NULL, NULL, NULL, 1451900228, 1465489580, 1, 'Admin', ''),
	(3, '127.0.0.1', 'manager', '$2y$08$snzIJdFXvg/rSHe0SndIAuvZyjktkjUxBXkrrGdkPy1K6r5r/dMLa', NULL, NULL, NULL, NULL, NULL, NULL, 1451900430, 1465489585, 1, 'Manager', ''),
	(4, '127.0.0.1', 'staff', '$2y$08$NigAXjN23CRKllqe3KmjYuWXD5iSRPY812SijlhGeKfkrMKde9da6', NULL, NULL, NULL, NULL, NULL, NULL, 1451900439, 1465489590, 1, 'Staff', '');
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;

-- Dumping structure for table db_ema.admin_users_groups
CREATE TABLE IF NOT EXISTS `admin_users_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table db_ema.admin_users_groups: ~4 rows (approximately)
DELETE FROM `admin_users_groups`;
/*!40000 ALTER TABLE `admin_users_groups` DISABLE KEYS */;
INSERT INTO `admin_users_groups` (`id`, `user_id`, `group_id`) VALUES
	(1, 1, 1),
	(2, 2, 2),
	(3, 3, 3),
	(4, 4, 4);
/*!40000 ALTER TABLE `admin_users_groups` ENABLE KEYS */;

-- Dumping structure for table db_ema.api_access
CREATE TABLE IF NOT EXISTS `api_access` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(40) NOT NULL DEFAULT '',
  `controller` varchar(50) NOT NULL DEFAULT '',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table db_ema.api_access: ~0 rows (approximately)
DELETE FROM `api_access`;
/*!40000 ALTER TABLE `api_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_access` ENABLE KEYS */;

-- Dumping structure for table db_ema.api_keys
CREATE TABLE IF NOT EXISTS `api_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `key` varchar(40) NOT NULL,
  `level` int(2) NOT NULL,
  `ignore_limits` tinyint(1) NOT NULL DEFAULT '0',
  `is_private_key` tinyint(1) NOT NULL DEFAULT '0',
  `ip_addresses` text,
  `date_created` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table db_ema.api_keys: ~0 rows (approximately)
DELETE FROM `api_keys`;
/*!40000 ALTER TABLE `api_keys` DISABLE KEYS */;
INSERT INTO `api_keys` (`id`, `user_id`, `key`, `level`, `ignore_limits`, `is_private_key`, `ip_addresses`, `date_created`) VALUES
	(1, 0, 'anonymous', 1, 1, 0, NULL, 1463388382);
/*!40000 ALTER TABLE `api_keys` ENABLE KEYS */;

-- Dumping structure for table db_ema.api_limits
CREATE TABLE IF NOT EXISTS `api_limits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) NOT NULL,
  `count` int(10) NOT NULL,
  `hour_started` int(11) NOT NULL,
  `api_key` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table db_ema.api_limits: ~0 rows (approximately)
DELETE FROM `api_limits`;
/*!40000 ALTER TABLE `api_limits` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_limits` ENABLE KEYS */;

-- Dumping structure for table db_ema.api_logs
CREATE TABLE IF NOT EXISTS `api_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) NOT NULL,
  `method` varchar(6) NOT NULL,
  `params` text,
  `api_key` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `time` int(11) NOT NULL,
  `rtime` float DEFAULT NULL,
  `authorized` varchar(1) NOT NULL,
  `response_code` smallint(3) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table db_ema.api_logs: ~0 rows (approximately)
DELETE FROM `api_logs`;
/*!40000 ALTER TABLE `api_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_logs` ENABLE KEYS */;

-- Dumping structure for table db_ema.dkm
CREATE TABLE IF NOT EXISTS `dkm` (
  `id_dkm` int(11) NOT NULL AUTO_INCREMENT,
  `uname_dkm` varchar(50) NOT NULL,
  `pass_dkm` varchar(50) NOT NULL,
  `masjid_dkm` varchar(100) NOT NULL,
  `alamat_dkm` text NOT NULL,
  `tlp_dkm` varchar(50) NOT NULL,
  `email_dkm` varchar(100) DEFAULT NULL,
  `ketua_dkm` varchar(100) DEFAULT NULL,
  `last_login` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_dkm`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- Dumping data for table db_ema.dkm: ~6 rows (approximately)
DELETE FROM `dkm`;
/*!40000 ALTER TABLE `dkm` DISABLE KEYS */;
INSERT INTO `dkm` (`id_dkm`, `uname_dkm`, `pass_dkm`, `masjid_dkm`, `alamat_dkm`, `tlp_dkm`, `email_dkm`, `ketua_dkm`, `last_login`, `create_at`, `update_at`) VALUES
	(2, 'sample_two', 'sample_two', 'Al - Aqsa', 'Jl Seokarno Hatta', '081372127135', 'masigithatta@gmail.com', 'Ustadz Firman Rahman', '2018-01-08 01:55:40', '2017-12-29 00:00:00', '2017-12-29 00:00:00'),
	(3, 'al-ikhlas', 'al-ikhlas', 'Masjid Al-Ikhlas', 'Jl. Cipadung', '0810987654321', 'al-ikhlas@masjid.id', 'Habib Maliki', '2018-01-12 02:47:36', '2018-01-06 11:08:12', NULL),
	(7, 'at-taqwa', 'at-taqwa', 'Masjid At-Taqwa', 'Jl. Cipadung', '0810987654321', 'at-taqwa@masjid.id', 'Habib Nanda', '2018-01-06 15:01:16', '2018-01-06 15:01:16', NULL),
	(8, 'an-nur', 'an-nur', 'Masjid An-Nur', 'Jl. Cipadung', '0810987654321', 'an-nur@masjid.id', 'Habib Efendi', '2018-01-07 12:06:06', '2018-01-07 12:06:06', NULL),
	(11, 'www', '123', 'bima', 'Bandung', '97699', 'adeatat@gmail.com', 'gaha', '2018-01-10 16:17:08', '2018-01-10 16:17:08', NULL),
	(12, 'aku', 'aku', '', '', '', NULL, NULL, '2018-01-11 03:38:00', '2018-01-11 03:38:00', NULL),
	(13, 'aku', 'aku', 'Aku', 'aku', 'aku', 'aku', 'aku', '2018-01-12 01:50:46', '2018-01-12 01:50:46', NULL);
/*!40000 ALTER TABLE `dkm` ENABLE KEYS */;

-- Dumping structure for table db_ema.dkm_authentication
CREATE TABLE IF NOT EXISTS `dkm_authentication` (
  `id_auth` int(4) NOT NULL,
  `id_udkm` int(4) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expired_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table db_ema.dkm_authentication: ~8 rows (approximately)
DELETE FROM `dkm_authentication`;
/*!40000 ALTER TABLE `dkm_authentication` DISABLE KEYS */;
INSERT INTO `dkm_authentication` (`id_auth`, `id_udkm`, `token`, `expired_at`, `created_at`, `updated_at`) VALUES
	(0, 1, '$1$zD53MGL0$u6WAQcGiWHGtTkUETQ/Ut.', '2017-12-31 10:40:22', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(0, 1, '$1$8h3.qT2.$xpEWnA6dDUYqfzUhTfWN1.', '2018-01-01 15:48:34', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(0, 1, '$1$270.TI0.$7iU7BNVbTLZetHiKp8DdB0', '2018-01-03 10:48:59', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(0, 1, '$1$8f0.Mx2.$nCkxLjvax.S7rbW52QRme1', '2018-01-03 14:04:11', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(0, 1, '$1$xO3.G31.$RvrOeElkX5aHQxmBz1MvB/', '2018-01-03 14:05:03', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(0, 1, '$1$8w5.V63.$I.nuu3RdYlN6QyXF098Az1', '2018-01-03 14:12:53', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(0, 1, '$1$yN..Vt/.$4wfwcgDZquDJPkRQXTre5.', '2018-01-03 14:28:35', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(0, 1, '$1$BW5.Pp3.$CNixuCSkd4bLEMoiyBPuC1', '2018-01-03 17:42:52', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(0, 1, '$1$hO4.Mo3.$sT3NyhaD2hQEXiWUMxYly0', '2018-01-04 03:41:10', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(0, 1, '$1$JY1.0z3.$Ck6P7z06kw8i/fo1yTEnS0', '2018-01-04 11:23:58', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(0, 1, '$1$IF..zV..$zikXAgCJYT/TpHa0WyUge0', '2018-01-05 07:02:50', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(0, 1, '$1$RX4.Lz3.$m2CudMTuRlw0mjApiQXWG/', '2018-01-06 14:03:57', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
/*!40000 ALTER TABLE `dkm_authentication` ENABLE KEYS */;

-- Dumping structure for table db_ema.event
CREATE TABLE IF NOT EXISTS `event` (
  `id_event` int(4) NOT NULL AUTO_INCREMENT,
  `uname_dkm` varchar(50) DEFAULT NULL,
  `dkm_pelaksana` varchar(100) NOT NULL,
  `nama_event` varchar(200) NOT NULL,
  `pemateri` varchar(200) DEFAULT NULL,
  `gambar` varchar(150) DEFAULT NULL,
  `lokasi_event` text NOT NULL,
  `tlp_event` varchar(50) DEFAULT NULL,
  `waktu_event` datetime NOT NULL,
  `tanggal_event` date DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_event`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- Dumping data for table db_ema.event: ~9 rows (approximately)
DELETE FROM `event`;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` (`id_event`, `uname_dkm`, `dkm_pelaksana`, `nama_event`, `pemateri`, `gambar`, `lokasi_event`, `tlp_event`, `waktu_event`, `tanggal_event`, `updated_at`) VALUES
	(1, 'sample_two', 'Masjid Iqomah', 'Tabligh Akbar 2018', 'Habib Nanda', 'https://eventmasjid.azurewebsites.net/gambar/beawesome-t2.jpg', 'Masjid Iqomah', '2147483647', '2018-01-05 00:00:00', '2018-01-08', '2018-01-07 14:01:33'),
	(2, 'al-ikhlas', 'Masjid Al-Ikhlas', 'Fiqih Tematik', 'Ustadz Adi Hasan', 'https://eventmasjid.azurewebsites.net/gambar/geteventmasjid3.png', 'Masjid Al - Ikhlas', '081372127136', '2018-01-12 13:00:00', NULL, '2018-01-12 15:05:38'),
	(3, 'al-ikhlas', 'Masjid Al-Ikhlas', 'Move On', 'Ustadz Hanan', 'https://eventmasjid.azurewebsites.net/gambar/beawesome-t2.jpg', 'Masjid Al-Lathif', '123456', '2018-00-00 00:00:00', NULL, '2018-01-07 13:36:42'),
	(4, 'sample_two', 'Masjid Al - Ikhlas', 'Fiqih Tematik', 'Ustadz Adi Hidayat', 'https://eventmasjid.azurewebsites.net/gambar/learnmotto-wallpaper-1366x7681.jpg', 'Masjid Al - Ikhlas', '081372127136', '2018-00-00 00:00:00', NULL, '2018-01-11 07:26:35'),
	(8, 'al-ikhlas', 'Masjid Al-Ikhlas', 'Khitanan Nanda', 'Ust. Yusuf', NULL, 'Masjid Ujung Berung', '0898987654321', '0000-00-00 00:00:00', NULL, '2018-01-08 03:49:19'),
	(9, 'sample_two', 'Masji Al-Lathif', 'Jomblo Sampai Halal', 'Ustadz Hanan', NULL, 'Masjid Al-Lathif', '123456', '2018-00-00 00:00:00', NULL, '2018-01-08 06:14:34'),
	(11, 'al-ikhlas', 'Masjid Al-Ikhlas', 'Khitanan Fikri', 'Ust Nanda', NULL, 'Jl. Manisi', '08960979261', '0000-00-00 00:00:00', NULL, '2018-01-08 07:07:18'),
	(13, 'al-ikhlas', 'Masjid Al-Ikhlas', 'Nikahan Nanda', 'Bang Lubz', NULL, 'Kosan Nanda', '098555685', '0000-00-00 00:00:00', NULL, '2018-01-08 08:11:25');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;

-- Dumping structure for table db_ema.groups
CREATE TABLE IF NOT EXISTS `groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table db_ema.groups: ~0 rows (approximately)
DELETE FROM `groups`;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` (`id`, `name`, `description`) VALUES
	(1, 'members', 'General User');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;

-- Dumping structure for table db_ema.login_attempts
CREATE TABLE IF NOT EXISTS `login_attempts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table db_ema.login_attempts: ~0 rows (approximately)
DELETE FROM `login_attempts`;
/*!40000 ALTER TABLE `login_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_attempts` ENABLE KEYS */;

-- Dumping structure for table db_ema.produk
CREATE TABLE IF NOT EXISTS `produk` (
  `id_produk` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) NOT NULL,
  `jenis` varchar(255) NOT NULL,
  `harga` int(11) NOT NULL,
  `keterangan` text NOT NULL,
  `foto` varchar(255) NOT NULL,
  PRIMARY KEY (`id_produk`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table db_ema.produk: ~3 rows (approximately)
DELETE FROM `produk`;
/*!40000 ALTER TABLE `produk` DISABLE KEYS */;
INSERT INTO `produk` (`id_produk`, `nama`, `jenis`, `harga`, `keterangan`, `foto`) VALUES
	(1, 'pupuk tes', 'pupuk tes', 10000, '<p>\n	tes</p>\n', '5be99-celsea.jpg'),
	(2, 'pupuk tes', 'pupuk tes', 10000, 'tes', ''),
	(3, '<p>\r\n	si boy tes</p>\r\n', '<p>\r\n	masih boy</p>\r\n', 2000, '<p>\r\n	knapa boy</p>\r\n', '');
/*!40000 ALTER TABLE `produk` ENABLE KEYS */;

-- Dumping structure for table db_ema.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table db_ema.users: ~0 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`) VALUES
	(1, '127.0.0.1', 'member', '$2y$08$kkqUE2hrqAJtg.pPnAhvL.1iE7LIujK5LZ61arONLpaBBWh/ek61G', NULL, 'member@member.com', NULL, NULL, NULL, NULL, 1451903855, 1451905011, 1, 'Member', 'One', NULL, NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table db_ema.users_groups
CREATE TABLE IF NOT EXISTS `users_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table db_ema.users_groups: ~0 rows (approximately)
DELETE FROM `users_groups`;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
INSERT INTO `users_groups` (`id`, `user_id`, `group_id`) VALUES
	(1, 1, 1);
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
