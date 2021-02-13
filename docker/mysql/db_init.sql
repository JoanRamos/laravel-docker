/*
DROP TABLE IF EXISTS `todos`;

CREATE TABLE `todos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checked` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `todos` (name, checked) VALUES
('Test 0', 1),
('Test 1', 0),
('Test 2', 0),
('Test 3', 0),
('Test 4', 0),
('Test 5', 0)
*/
