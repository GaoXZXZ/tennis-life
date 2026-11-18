-- Run this once in Supabase Dashboard → SQL Editor → New query.
-- This creates one private data space per authenticated user.

create table if not exists public.tennis_records (
  user_id uuid not null references auth.users(id) on delete cascade,
  record_id text not null,
  data jsonb,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  primary key (user_id, record_id)
);

create table if not exists public.tennis_settings (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

create or replace function public.set_tennis_sync_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists tennis_records_updated_at on public.tennis_records;
create trigger tennis_records_updated_at
before insert or update on public.tennis_records
for each row execute procedure public.set_tennis_sync_updated_at();

drop trigger if exists tennis_settings_updated_at on public.tennis_settings;
create trigger tennis_settings_updated_at
before insert or update on public.tennis_settings
for each row execute procedure public.set_tennis_sync_updated_at();

grant usage on schema public to authenticated;
grant select, insert, update on public.tennis_records to authenticated;
grant select, insert, update on public.tennis_settings to authenticated;

alter table public.tennis_records enable row level security;
alter table public.tennis_settings enable row level security;

drop policy if exists "users manage their tennis records" on public.tennis_records;
create policy "users manage their tennis records"
on public.tennis_records
for all to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

drop policy if exists "users manage their tennis settings" on public.tennis_settings;
create policy "users manage their tennis settings"
on public.tennis_settings
for all to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);
