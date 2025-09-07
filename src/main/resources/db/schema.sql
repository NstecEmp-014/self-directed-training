-- 株テーブルのみ
drop table if exists stock;
create table stock(
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,     -- 銘柄名
  code VARCHAR(10) NOT NULL,     -- 証券コード
  price INTEGER NOT NULL,        -- 現在価格
  delete_flag INTEGER NOT NULL DEFAULT 0
);