create or replace table `rakamin-kf-analytics-497805.Kimia_Farma.tabel_analisa` as
select
  t.transaction_id,
  t.date,
  c.branch_id,
  c.branch_name,
  c.kota,
  c.provinsi,
  c.rating as rating_cabang,
  t.customer_name,
  p.product_id,
  p.product_name,
  p.price as actual_price,
  t.discount_percentage,

case
  when t.price <= 50000 then 0.10
  when t.price <= 100000 then 0.15
  when t.price <= 300000 then 0.20
  when t.price <= 500000 then 0.25
  else 0.30
end as persentase_gross_laba,

t.price * (1 - t.discount_percentage) as nett_sales,

(t.price * (1 - t.discount_percentage))
*
(case
  when t.price <= 50000 then 0.10
  when t.price <= 100000 then 0.15
  when t.price <= 300000 then 0.20
  when t.price <= 500000 then 0.25
  else 0.30
end) as nett_profit,

t.rating as rating_transaksi

from `rakamin-kf-analytics-497805.Kimia_Farma.kf_final_transaction`t

left join `rakamin-kf-analytics-497805.Kimia_Farma.kf_kantor_cabang`c
on t.branch_id = c.branch_id

left join `rakamin-kf-analytics-497805.Kimia_Farma.kf_product`p
on t.product_id = p.product_id