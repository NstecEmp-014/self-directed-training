CREATE TABLE stocs (
  id SERIAL PRIMARY KEY,           -- 自動採番のID
  name VARCHAR(50) NOT NULL,       -- 銘柄名
  code VARCHAR(10) NOT NULL,       -- 証券コード
  price INTEGER NOT NULL,          -- 価格
  delete_flag INTEGER NOT NULL DEFAULT 0 -- 削除フラグ（0:有効, 1:削除）
);