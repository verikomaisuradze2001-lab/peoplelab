create extension if not exists pgcrypto;

create table if not exists public.employees (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  first_name text not null,
  last_name text not null,
  role text not null,
  work_setup text,
  checklist_depth text,
  start_date date,
  notes text,
  status text not null default 'active' check (status in ('active','completed','archived')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create table if not exists public.onboarding_tasks (
  id uuid primary key default gen_random_uuid(),
  employee_id uuid not null references public.employees(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  section text not null default 'Custom tasks',
  task_text text not null,
  is_done boolean not null default false,
  due_date date,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create table if not exists public.idea_searches (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  tool text not null,
  brief jsonb not null,
  response jsonb,
  created_at timestamptz not null default now()
);

alter table public.employees enable row level security;
alter table public.onboarding_tasks enable row level security;
alter table public.idea_searches enable row level security;
create policy "employees own rows" on public.employees for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "tasks own rows" on public.onboarding_tasks for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "searches own rows" on public.idea_searches for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create index if not exists employees_user_start_idx on public.employees(user_id,start_date desc);
create index if not exists tasks_employee_idx on public.onboarding_tasks(employee_id,sort_order);
