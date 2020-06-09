drop schema common cascade;
create schema common;
comment on schema common is 'Common :: Tablas comunes del Sistema';

-- Tipos de documento
create table common.document_types (
  id_document_type              serial primary key,
  acronym                       character varying(25) not null,
  document_type                 character varying(100) not null,
  enabled                       boolean not null default true,
  date_of_creation              timestamp with time zone not null default now(),
  last_modification             timestamp with time zone not null default now()
);
comment on table  common.document_types                              is 'Tipos de documento';
comment on column common.document_types.id_document_type             is 'Tipos de documento';
comment on column common.document_types.acronym                      is 'Acrónimo';
comment on column common.document_types.document_type                is 'Tipo de documento';
comment on column common.document_types.enabled                      is 'Estado del registro';
comment on column common.document_types.date_of_creation             is 'Fecha de Creación';
comment on column common.document_types.last_modification            is 'Fecha de Modificación';

-- Paises
create table common.countries (
  id_country                    serial primary key,
  acronym                       character varying(15) not null,
  country                       character varying(100) not null,
  enabled                       boolean not null default true,
  date_of_creation              timestamp with time zone not null default now(),
  last_modification             timestamp with time zone not null default now()
);
comment on table  common.countries                           is 'Tabla de paises';
comment on column common.countries.id_country                is 'Llave primaria';
comment on column common.countries.acronym                   is 'Acrónimo';
comment on column common.countries.country                   is 'Pais';
comment on column common.countries.enabled                   is 'Estado del registro';
comment on column common.countries.date_of_creation          is 'Creación';
comment on column common.countries.last_modification         is 'Modificación';

