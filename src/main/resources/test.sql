CREATE TABLE test (
  id BIGINT NOT NULL,
  value varchar(25) ,
  PRIMARY KEY (id)
);

CREATE STREAM st_test
EXPORT TO TARGET archive (  
  id BIGINT NOT NULL,
  value varchar(25) 
);

PARTITION TABLE test ON COLUMN id;