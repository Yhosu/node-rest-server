drop schema security cascade;
create schema security;
comment on schema common is 'Security :: Tablas del Esquema de seguridad del usuario';

create table security.users (
  id_user                       serial primary key,
  id_profile                    integer,
  login                         character varying(50) unique,
  password                      character varying(32) default '' not null,
  id_country                    integer null constraint country references common.countries (id_country) on delete restrict on update cascade,
  id_nationality                integer null constraint nationality references common.countries (id_country) on delete restrict on update cascade,  
  id_document_type              integer null constraint document_type references common.document_types(id_document_type),  
  document_id                   character varying(20) null,
  document_issued_by            character varying(100) null,  
  commercial_id                 character varying(20) null,
  full_name                     character varying(200) default '',
  first_name                    character varying(50) default '',
  middle_name                   character varying(50) default '',
  last_name                     character varying(50) null default '',
  sure_name                     character varying(50) default '',
  birth_date                    date null,
  birth_place                   character varying(100) null,
  gender                        character varying(10)  null,
  phone                         character varying(100) null,
  cellphone                     character varying(100) null,
  address                       text null,
  mail                          character varying(255) null,
  photo                         text,  
  enabled                       boolean not null default true,
  id_creator                    integer not null,  
  date_of_creation              timestamp with time zone not null default now(),
  id_modificator                integer not null,  
  last_modification             timestamp with time zone not null default now()
);

create index user_login           on security.users (login);
create index people_fullname      on security.users (translate( lower( regexp_replace( full_name, ' +', ' ', 'g' ) ), 'áéíóúüñ', 'aeiouun' ));
create index people_commercial_id on security.users ( commercial_id );
comment on table security.users                                  is 'Tabla de usuarios';
comment on column security.users.id_user                         is 'Llave primaria';
comment on column security.users.id_profile                      is 'Perfil';
comment on column security.users.login                           is 'Nombre de usuario';
comment on column security.users.password                        is 'Contraseña';
comment on column security.users.id_country                      is 'Pais de nacimiento u oficina principal';
comment on column security.users.id_nationality                  is 'Nacionalidad';
comment on column security.users.document_id                     is 'Carnet de identidad';
comment on column security.users.document_issued_by              is 'Expedido en/por';
comment on column security.users.commercial_id                   is 'NIT';
comment on column security.users.full_name                       is 'Nombre completo o razón social|REPRESENTATIVE_FIELD';
comment on column security.users.first_name                      is 'Nombres';
comment on column security.users.middle_name                     is 'Otros nombres';
comment on column security.users.last_name                       is 'Apellido paterno';
comment on column security.users.sure_name                       is 'Apellido materno';
comment on column security.users.birth_date                      is 'Fecha de nacmiento o Fecha de constitución';
comment on column security.users.birth_place                     is 'Lugar de nacmiento o Lugar de constitución';
comment on column security.users.gender                          is 'Género';
comment on column security.users.phone                           is 'Teléfonos';
comment on column security.users.cellphone                       is 'Celular';
comment on column security.users.address                         is 'Dirección';
comment on column security.users.mail                            is 'Mail';
comment on column security.users.photo                           is 'Fotografía';
comment on column security.users.enabled                         is 'Estado del registro';
comment on column security.users.id_creator                      is 'Creador';
comment on column security.users.date_of_creation                is 'Creación';
comment on column security.users.id_modificator                  is 'Modificador';
comment on column security.users.last_modification               is 'Modificación';
alter table security.users add constraint creator foreign key (id_creator) references security.users (id_user) on delete restrict on update cascade;
alter table security.users add constraint modificator foreign key (id_modificator) references security.users (id_user) on delete restrict on update cascade;

-- Roles
create table security.rols (
  id_rol                        serial primary key,
  rol                           character varying(60) not null,
  description                   text default '',  
  enabled                       boolean not null default true,
  id_creator                    integer not null constraint creator references security.users( id_user ) on delete restrict on update cascade,
  date_of_creation              timestamp with time zone not null default now(),
  id_modificator                integer not null constraint modificator references security.users( id_user ) on delete restrict on update cascade,
  last_modification             timestamp with time zone not null default now()
);
create index rols_creator                                       on security.rols (id_creator);
create index rols_modificator                                   on security.rols (id_modificator);
comment on table  security.rols                             is 'Entidades que definen en el esquema de seguridad';
comment on column security.rols.id_rol                      is 'Llave primaria';
comment on column security.rols.rol                         is 'Rol';
comment on column security.rols.description                 is 'Descripción del rol';
comment on column security.rols.enabled                     is 'Estado del registro';
comment on column security.rols.id_creator                  is 'Creador';
comment on column security.rols.date_of_creation            is 'Creación//Creation|HIDE_ALL';
comment on column security.rols.id_modificator              is 'Modificador';
comment on column security.rols.last_modification           is 'Modificación//Modification|HIDE_ALL';

create table security.users_rol (
  id_user_rol                   serial primary key,
  id_user                       integer not null constraint referer_user references security.users( id_user ) on delete restrict on update cascade,
  id_rol                        integer not null constraint rol references security.rols( id_rol ) on delete restrict on update cascade,
  enabled                       boolean not null default true,
  date_of_creation              timestamp with time zone not null default now(),
  last_modification             timestamp with time zone not null default now()
);
create index users_rol_id_user        on security.users_rol( id_user );
comment on table  security.users_rol                       is 'Acceso de los usuarios según rol';
comment on column security.users_rol.id_user_rol           is 'Llave primaria';
comment on column security.users_rol.id_user               is 'Usuario';
comment on column security.users_rol.id_rol                is 'Rol';
comment on column security.users_rol.enabled               is 'Estado del resgistro';
comment on column security.users_rol.id_creator            is 'Creador';
comment on column security.users_rol.date_of_creation      is 'Creación';
comment on column security.users_rol.id_modificator        is 'Modificador';
comment on column security.users_rol.last_modification     is 'Modificación';

