create table humans(
	human_id serial not null,
	first_name text not null,
	second_name text null,
	phone text null,
	address text null,
	age smallint default 18 not null,
	sex text default 'м' not null,
	busy bool default false not null,
	constraint human_id_pk primary key(human_id),
	constraint age_ck check(age > 17 and ((sex = 'м' and age < 56) or (sex = 'ж' and age < 56))),
	constraint sex_ck check(sex in ('ж', 'м')),
	constraint first_name_ck check(first_name != ''),
	constraint second_name_ck check(second_name != ''),
	constraint human_address_ck check(address != ''),
	constraint human_phone_unique unique(phone)
);

create table skills(
	skill_id serial,
	name text not null,
	constraint skill_id_pk primary key(skill_id),
	constraint skill_name_ck check(name !=''),
	constraint skill_name_unique unique(name)
);

create table companies (
	company_id serial,
	name text not null,
	address text not null,
	phone text null,
	latitude float null,
	longitude float null,
	constraint company_id_pk primary key(company_id),
	constraint company_name_ck check(name!=''),
	constraint company_address_ck check(address!=''),
	constraint company_name_unique unique(name),
	constraint company_phone_unique unique(phone)
);

create table human_skills(
	human_id int not null,
	skill_id int not null,
	constraint human_skill_id_pk primary key(human_id, skill_id),
	constraint human_id_fk foreign key (human_id) references humans(human_id) on delete cascade,
	constraint skill_id_fk foreign key (skill_id) references skills(skill_id) on delete cascade
);

create table vacancies(
	vacancy_id serial not null,
	company_id int not null,
	skill_id int not null,
	payment float not null,
	constraint vacancy_id_pk primary key (vacancy_id),
	constraint company_id_fk foreign key (company_id) references companies(company_id) on delete cascade,
	constraint skill_vacancy_id_fk foreign key (skill_id) references skills(skill_id) on delete cascade,
	constraint payment_vacancies_ck check(payment > 0)
);

create table workers(
	worker_id serial,
	human_id int not null,
	company_id int not null,
	payment float not null,
	constraint worker_id_pk primary key(worker_id),
	constraint worker_human_id_fk foreign key(human_id) references humans(human_id) on delete cascade,
	constraint worker_company_id_fk foreign key(company_id) references companies(company_id) on delete cascade,
	constraint payment_vacancies_ck check(payment > 0)
);