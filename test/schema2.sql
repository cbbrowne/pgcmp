drop schema if exists s2 cascade;

alter table s1.t1
  drop column c5;

alter table s1.t1 set (fillfactor=80);

alter index s1.t1_c6 set (fillfactor=50);

alter table s1.t1
  add column c7 integer;

alter table s1.t1
  alter column c2 set default 'foo';

create table s1.t3 (
  t3_c1 serial primary key,
  t3_c2 text not null unique
);
