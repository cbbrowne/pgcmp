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

create or replace function some_overloaded_function (p1 integer, p2 integer, p3 text, p4 timestamptz, p5 bigint, p6 uuid, p7 text) returns integer as $$
begin
   return 0;
end
$$ language plpgsql;
