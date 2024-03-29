DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS budgets;

SET datestyle to DMY, SQL;

CREATE TABLE merchants(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE tags(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE transactions(
  id SERIAL8 PRIMARY KEY,
  amount DECIMAL(10,2),
  transaction_date DATE,
  merchant_id INT8 REFERENCES merchants(id) ON DELETE CASCADE,
  tag_id INT8 REFERENCES tags(id) ON DELETE CASCADE
);

CREATE TABLE budgets(
  id SERIAL8 PRIMARY KEY,
  total DECIMAL(10,2),
  warning_limit FLOAT(2),
  message VARCHAR(255),
  message_indicator VARCHAR(255)
);

-- SELECT  Convert(varchar,transactions.transaction_date,103) as tran_date
-- order by Convert(varchar,transactions.transaction_date,103)
--
-- SELECT CONVERT(varchar(110),transactions.transaction_date,107) AS ConvertedDate
-- order by Convert(varchar(110),transactions.transaction_date,107)
--
-- select convert(varchar,transaction_date_time,103) from transactions;

-- SET datestyle to DMY, SQL;
-- SELECT *, TO_CHAR(transaction_date, 'DD-MON-YYYY')
-- FROM transactions
-- WHERE id = 5;

-- SELECT *, EXTRACT(MONTH FROM transaction_date) FROM transactions
-- WHERE EXTRACT(MONTH FROM transaction_date) = 3;
