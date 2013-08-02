create schema s1;
create domain d1 as text not null;
create domain d2 as text default 'foo' check (value ~ '^[a-z]*$');
create table s1.t1 (
  c1 serial primary key,
  c2 text not null unique,
  c3 timestamptz default now(),
  c4 timestamptz default now() not null,
  c5 d1,
  c6 d2
) with (fillfactor=75);

create index t1_c6 on s1.t1(c6);

create sequence s1.seq1 start with 150 cache 10 maxvalue 150000 cycle ;
create sequence s1.seq2;

create schema s2;
create view s2.d1 as select c1, c2, c3, c4, c5 from s1.t1;

create or replace function s1.f1 (p1 text) returns integer as $$
begin
	return 1;
end
$$ language plpgsql security definer;

create or replace function s2.f1 () returns trigger as $$
begin
	return NULL;
end
$$ language plpgsql;

create trigger trigger_1 after update on s1.t1 
execute procedure s2.f1();
