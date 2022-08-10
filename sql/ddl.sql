-- NoxoStamp.author definition

CREATE TABLE `author` (
  `author_id` int NOT NULL AUTO_INCREMENT,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `birthdate` date DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `zip` varchar(9) DEFAULT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`author_id`),
  KEY `lname` (`lname`,`fname`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8mb3;


-- NoxoStamp.book definition

CREATE TABLE `book` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `isbn` varchar(14) NOT NULL,
  `cost` decimal(9,2) NOT NULL,
  `ratings_count` int unsigned NOT NULL,
  `rating` decimal(4,2) NOT NULL,
  `num_pages` int unsigned NOT NULL,
  `publication_date` date NOT NULL,
  `edition` int unsigned DEFAULT '1',
  `language` varchar(15) NOT NULL,
  `description` text,
  PRIMARY KEY (`book_id`),
  UNIQUE KEY `isbn` (`isbn`),
  CONSTRAINT `book_chk_1` CHECK ((`cost` >= 0)),
  CONSTRAINT `book_chk_2` CHECK ((`rating` between 0 and 10))
) ENGINE=InnoDB AUTO_INCREMENT=11124 DEFAULT CHARSET=utf8mb3;


-- NoxoStamp.branch definition

CREATE TABLE `branch` (
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `country` varchar(10) NOT NULL,
  `city` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `zip` varchar(10) NOT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3;


-- NoxoStamp.customer definition

CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `country` varchar(10) NOT NULL,
  `city` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `zip` varchar(10) NOT NULL,
  `phone` varchar(40) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `lname` (`lname`,`fname`)
) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8mb3;


-- NoxoStamp.genre definition

CREATE TABLE `genre` (
  `genre_name` varchar(40) NOT NULL,
  PRIMARY KEY (`genre_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- NoxoStamp.publisher definition

CREATE TABLE `publisher` (
  `publisher_name` varchar(100) NOT NULL,
  PRIMARY KEY (`publisher_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- NoxoStamp.supplier definition

CREATE TABLE `supplier` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `country` varchar(10) NOT NULL,
  `city` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `zip` varchar(10) NOT NULL,
  `phone` varchar(40) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb3;


-- NoxoStamp.author_book definition

CREATE TABLE `author_book` (
  `author_id` int NOT NULL,
  `book_id` int NOT NULL,
  PRIMARY KEY (`author_id`,`book_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `author_book_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`author_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `author_book_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- NoxoStamp.book_genre definition

CREATE TABLE `book_genre` (
  `book_id` int NOT NULL,
  `genre_name` varchar(40) NOT NULL,
  PRIMARY KEY (`book_id`,`genre_name`),
  KEY `genre_name` (`genre_name`),
  CONSTRAINT `book_genre_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `book_genre_ibfk_2` FOREIGN KEY (`genre_name`) REFERENCES `genre` (`genre_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- NoxoStamp.employee definition

CREATE TABLE `employee` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `manager_id` int DEFAULT NULL,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `position` varchar(20) NOT NULL,
  `salary` int unsigned NOT NULL,
  `hire_date` date NOT NULL,
  `birthdate` date NOT NULL,
  `country` varchar(10) NOT NULL,
  `city` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `zip` varchar(10) NOT NULL,
  `phone` varchar(40) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `manager_id` (`manager_id`),
  KEY `lname` (`lname`,`fname`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `employee` (`employee_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=1212 DEFAULT CHARSET=utf8mb3;


-- NoxoStamp.employee_branch definition

CREATE TABLE `employee_branch` (
  `employee_id` int NOT NULL,
  `branch_id` int NOT NULL,
  PRIMARY KEY (`employee_id`,`branch_id`),
  KEY `branch_id` (`branch_id`),
  CONSTRAINT `employee_branch_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON DELETE CASCADE,
  CONSTRAINT `employee_branch_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- NoxoStamp.order_detail definition

CREATE TABLE `order_detail` (
  `order_detail_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `branch_id` int NOT NULL,
  `open_employee_id` int DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  PRIMARY KEY (`order_detail_id`),
  KEY `customer_id` (`customer_id`),
  KEY `branch_id` (`branch_id`),
  KEY `open_employee_id` (`open_employee_id`),
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_detail_ibfk_3` FOREIGN KEY (`open_employee_id`) REFERENCES `employee` (`employee_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_detail_ibfk_4` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb3;


-- NoxoStamp.publisher_book definition

CREATE TABLE `publisher_book` (
  `publisher_name` varchar(100) NOT NULL,
  `book_id` int NOT NULL,
  PRIMARY KEY (`publisher_name`,`book_id`),
  UNIQUE KEY `publisher_book_UN` (`book_id`),
  CONSTRAINT `publisher_book_ibfk_1` FOREIGN KEY (`publisher_name`) REFERENCES `publisher` (`publisher_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `publisher_book_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- NoxoStamp.`order` definition

CREATE TABLE `order` (
  `order_detail_id` int NOT NULL,
  `book_id` int NOT NULL,
  `quantity` int unsigned DEFAULT '1',
  PRIMARY KEY (`order_detail_id`,`book_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`order_detail_id`) REFERENCES `order_detail` (`order_detail_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;