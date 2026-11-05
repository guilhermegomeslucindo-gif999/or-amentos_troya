-- Banco de dados do Gerador de Orçamentos · Marmoraria Troya
-- As tabelas também são criadas automaticamente no primeiro acesso ao sistema.
-- Você só precisa rodar este arquivo se preferir criar tudo manualmente.

create table if not exists settings (
  id         integer primary key default 1 check (id = 1),
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

create table if not exists quotes (
  id         text primary key,
  numero     integer unique,
  titulo     text not null default '',
  cliente    text not null default '',
  vendedor   text not null default '',
  status     text not null default 'aberto' check (status in ('aberto', 'fechou', 'perdeu')),
  motivo     text not null default '',
  total_a    numeric(14, 2) not null default 0,
  total_b    numeric(14, 2),
  data       jsonb not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists quotes_updated_at_idx on quotes (updated_at desc);
create index if not exists quotes_status_idx on quotes (status);

insert into settings (id, data) values (1, '{}'::jsonb) on conflict (id) do nothing;
