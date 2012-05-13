CREATE TABLE `items` (
  `id` int(11) NOT NULL auto_increment,
  `create_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `number` smallint(5) unsigned NOT NULL default '0',
  `act_type` varchar(5) NOT NULL default '',
  `item_desc` text NOT NULL,
  `value_when_done` varchar(255) default NULL,
  `where_to_do` varchar(255) default NULL,
  `short_task_name` varchar(255) default NULL,
  `swiss_cheese` varchar(255) default NULL,
  `out_indicator` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=678 DEFAULT CHARSET=utf8;

CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `taggings` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `tag_id` int(10) unsigned NOT NULL default '0',
  `taggable_id` int(10) unsigned NOT NULL default '0',
  `taggable_type` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3230 DEFAULT CHARSET=utf8;

CREATE TABLE `tags` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `created_at` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(80) default NULL,
  `password` varchar(40) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO schema_info (version) VALUES (2)