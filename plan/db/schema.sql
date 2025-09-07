-- 株テーブルのみ
drop table if exists stock;
drop sequence if exists stock_id_seq;
create table stock(
  id serial primary key,
  name varchar(50) not null,     -- 銘柄名
  code varchar(10) not null,     -- 証券コード
  price integer not null,        -- 現在価格
  delete_flag integer not null default 0
);