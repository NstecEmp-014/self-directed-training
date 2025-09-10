-- 株テーブルのみ
drop table if exists stock;
drop sequence if exists stock_id_seq;
create table stock(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  code VARCHAR(10) NOT NULL,
  price INTEGER NOT NULL,
  delete_flag INTEGER NOT NULL DEFAULT 0
);